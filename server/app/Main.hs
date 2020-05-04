{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE OverloadedLabels  #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators     #-}
module Main where

import           Control.Applicative
import           Control.Exception.Safe
import           Control.Lens
import           Control.Monad
import           Control.Monad.IO.Class
import qualified Data.ByteString.Char8           as BSC
import           Data.Extensible
import qualified Data.Map.Strict                 as M
import           Data.Text
import           Data.Yaml
import           Graphics.Image
import           Network.HTTP.Types.Status
import           Network.Wai
import           Network.Wai.Handler.Warp
import           Network.Wai.Middleware.Gzip
import           Network.Wai.Middleware.HttpAuth
import           Path
import           Path.IO
import           System.Environment

import           KlaraWorks
import           KlaraWorks.Env

main :: IO ()
main = do
    wenv <- traverseYaml
    generateThumbnails wenv
    runServer wenv

generateThumbnails :: WorksEnv -> IO ()
generateThumbnails (WorksEnv kv) = do
    worksDir <- parseAbsDir "/assets/works"
    thumbsDir <- parseAbsDir "/assets/thumbnails"
    createDirIfMissing True thumbsDir
    forM_ kv $ \v -> do
        d <- parseRelDir $ unpack (v ^. #id)
        src <- case unpack <$> v ^. #cover of
            Just c -> ((worksDir </> d) </>) <$> parseRelFile c
            Nothing -> do
                png <- findFile [worksDir </> d] =<< parseRelFile (unpack (v ^. #id <> ".png"))
                jpg <- findFile [worksDir </> d] =<< parseRelFile (unpack (v ^. #id <> ".jpg"))
                case (png, jpg) of
                    (Just p, _)       -> pure p
                    (Nothing, Just j) -> pure j
                    _                 -> throwString "not found cover image"
        distPort <- (thumbsDir </>) <$> parseRelFile (unpack (v ^. #id <> "-port.jpg"))
        distLand <- (thumbsDir </>) <$> parseRelFile (unpack (v ^. #id <> "-land.jpg"))
        img <- readImageRGB VS $ toFilePath src
        let (x, y) = dims img
            sizeLand = (250, ceiling $ 250 * (fromIntegral y / fromIntegral x))
            sizePort= (ceiling $ 250 * (fromIntegral x / fromIntegral y), 250)
            imgLand = resize (Bicubic (-1.0)) Edge sizeLand $ applyFilter (gaussianBlur 0.5) img
            imgPort = resize (Bicubic (-1.0)) Edge sizePort $ applyFilter (gaussianBlur 0.5) img
        writeImageExact JPG [JPGQuality 70] (toFilePath distLand) imgLand
        writeImageExact JPG [JPGQuality 70] (toFilePath distPort) imgPort

traverseYaml :: IO WorksEnv
traverseYaml = do
    dirs <- (fmap fst . listDir) =<< parseAbsDir "/assets/works"
    name <- parseRelFile "meta.yaml"
    let yamls = fmap (</> name) dirs
    (WorksEnv . M.fromList) . fmap (\x -> (x ^. #id ,x)) <$> mapM decodeFileThrow (fmap toFilePath  yamls)

runServer :: WorksEnv -> IO ()
runServer wenv = do
    let settings = setPort 8080 defaultSettings
    user' <- fmap BSC.pack <$> lookupEnv "SERVER_USER"
    password' <- fmap BSC.pack <$> lookupEnv "SERVER_PASSWORD"
    let env = Env { works = wenv }
    case (user', password') of
        (Just u, Just p) -> do
            putStrLn "Start server as private"
            let auth = basicAuth (\u' p' -> pure $ u' == u && p' == p) "Locked"
                health app req respond = case pathInfo req of
                    ["health"] -> respond $ responseLBS status200 [] ""
                    _          -> app req respond
            runSettings settings . health $ auth (app env)

        _ -> do
            putStrLn "Start server as public"
            runSettings settings (app env)


