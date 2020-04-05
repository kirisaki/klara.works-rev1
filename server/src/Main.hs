{-# LANGUAGE DataKinds #-}
{-# LANGUAGE OverloadedLabels #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeOperators #-}
module Main where

import Data.CaseInsensitive
import Data.Extensible
import Data.Proxy
import Data.Text
import Lucid
import Lucid.Servant
import Network.Wai
import Network.Wai.Middleware.Gzip
import Network.Wai.Handler.Warp
import Servant
import Servant.API
import Servant.HTML.Lucid

htmlTemplate :: Text -> Html ()
htmlTemplate t = do
    doctype_ 
    html_ $ do
        head_ $ do
            meta_ [charset_ "utf-8"]
            title_ [] (pure t)
        body_ $ do
            div_ [id_ "app"] "Klara Works"

type Api = Get '[HTML] (Html ())

server :: Server Api
server = pure (htmlTemplate "Klara Works")

app :: Application
app = gzip def { gzipFiles = GzipCompress  } $ serve (Proxy @ Api) server

main :: IO ()
main = do
    let settings = setPort 8080 defaultSettings
    runSettings settings app
