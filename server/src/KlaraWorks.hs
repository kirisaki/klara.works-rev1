{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE OverloadedLabels  #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications  #-}
{-# LANGUAGE TypeOperators     #-}
module KlaraWorks where


import           Control.Monad.Reader
import           Data.Proxy
import           Lucid
import           Lucid.Servant
import           Network.Wai
import           Network.Wai.Middleware.Gzip
import           Servant
import           Servant.API
import           Servant.HTML.Lucid

import           KlaraWorks.Env
import           KlaraWorks.Html
import           KlaraWorks.Works

type Api =  "about" :> Get '[HTML] (Html ())
        :<|> "works" :> Get '[HTML] (Html ())
        :<|> Get '[HTML] (Html ())
        :<|> "assets" :> Raw
        :<|> "api" :> "v0" :> WorksApi

server :: (HasWorksEnv env) => ServerT Api (ApiHandler env)
server =  pure (htmlTemplate "Klara Works - About")
        :<|> pure (htmlTemplate "Klara Works - Works")
        :<|> pure (htmlTemplate "Klara Works")
        :<|> serveDirectoryWebApp "/assets"
        :<|> worksServer

app :: Env -> Application
app e = gzip def { gzipFiles = GzipCompress }
    $ serve (Proxy @ Api)
    $ hoistServer (Proxy @ Api) (`runReaderT` e) server

