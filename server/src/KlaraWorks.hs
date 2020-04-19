{-# LANGUAGE DataKinds #-}
{-# LANGUAGE OverloadedLabels #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeOperators #-}
module KlaraWorks where

import Data.Proxy
import Lucid
import Lucid.Servant
import Network.Wai
import Network.Wai.Middleware.Gzip
import Servant
import Servant.API
import Servant.HTML.Lucid

import KlaraWorks.Html

type Api = "about" :> Get '[HTML] (Html ())
        :<|> Get '[HTML] (Html ())
        :<|> "assets" :> Raw

server :: Server Api
server =  pure (htmlTemplate "Klara Works - About")
        :<|> pure (htmlTemplate "Klara Works")
        :<|> serveDirectoryWebApp "/assets"

app :: Application
app = gzip def { gzipFiles = GzipCompress } $ serve (Proxy @ Api) server

