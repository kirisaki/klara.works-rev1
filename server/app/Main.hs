{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE OverloadedLabels  #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators     #-}
module Main where

import           Control.Monad
import qualified Data.ByteString.Char8           as BSC
import           Data.Extensible
import qualified Data.Map.Strict                 as M
import           Data.Text
import           Data.Yaml
import           Network.HTTP.Types.Status
import           Network.Wai
import           Network.Wai.Handler.Warp
import           Network.Wai.Middleware.Gzip
import           Network.Wai.Middleware.HttpAuth
import           Path
import           Path.IO
import           System.Environment
import           System.Directory
import Control.Lens

import           KlaraWorks
import           KlaraWorks.Env

main :: IO ()
main = do
    wenv <- traverseYaml
    runServer wenv

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


