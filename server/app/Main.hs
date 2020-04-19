{-# LANGUAGE OverloadedStrings #-}
module Main where

import qualified Data.ByteString.Char8 as BSC
import Network.HTTP.Types.Status
import Network.Wai
import Network.Wai.Middleware.Gzip
import Network.Wai.Middleware.HttpAuth
import Network.Wai.Handler.Warp
import System.Environment

import KlaraWorks

main :: IO ()
main = do
    let settings = setPort 8080 defaultSettings
    user' <- fmap BSC.pack <$> lookupEnv "SERVER_USER"
    password' <- fmap BSC.pack <$> lookupEnv "SERVER_PASSWORD"
    case (user', password') of
        (Just u, Just p) -> do
            putStrLn "Start server as private"
            let auth = basicAuth (\u' p' -> pure $ u' == u && p' == p) "Locked"
                health app req respond = case pathInfo req of
                    ["health"] -> respond $ responseLBS status200 [] ""
                    _ -> app req respond
            runSettings settings . health $ auth app

        _ -> do
            putStrLn "Start server as public"
            runSettings settings app

