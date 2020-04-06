{-# LANGUAGE DataKinds #-}
{-# LANGUAGE OverloadedLabels #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeOperators #-}
module Main where

import qualified Data.ByteString.Char8 as BSC
import Data.CaseInsensitive
import Data.Extensible
import Data.Proxy
import Data.Text
import Lucid
import Lucid.Servant
import Network.HTTP.Types.Status
import Network.Wai
import Network.Wai.Middleware.Gzip
import Network.Wai.Middleware.HttpAuth
import Network.Wai.Handler.Warp
import Servant
import Servant.API
import Servant.HTML.Lucid
import System.Environment

htmlTemplate :: Text -> Html ()
htmlTemplate t = do
    doctype_ 
    html_ $ do
        head_ $ do
            meta_ [charset_ "utf-8"]
            title_ [] (toHtml t)
        body_ $ do
            div_ [id_ "app"] "Klara Works"
            script_ [src_ "/assets/main.js"] empty

type Api = Get '[HTML] (Html ())
        :<|> "assets" :> Raw

server :: Server Api
server = pure (htmlTemplate "Klara Works")
        :<|> serveDirectoryWebApp "/assets"

app :: Application
app = gzip def { gzipFiles = GzipCompress } $ serve (Proxy @ Api) server

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

