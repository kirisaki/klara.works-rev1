{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedLabels #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators #-}
module KlaraWorks.Works where

import Control.Lens
import Data.Extensible
import Data.Text
import Data.Aeson
import Data.Int
import qualified Data.HashMap.Strict as HM
import GHC.Generics
import Servant
import Servant.API

data Language
    = Japanese
    | English
    deriving(Show, Eq, Generic)
instance ToJSON Language
instance FromJSON Language

data WorkType
    = Picture
    | Manga
    | Font
    deriving(Show, Eq, Generic)

instance ToJSON WorkType
instance FromJSON WorkType

type WorkMeta = Record
    '[ "title" >: Text
     , "origin" >: Text
     ]

type Work = Record 
    '[ "id" >: Text
     , "timeStamp" >: Int32
     , "type" >: WorkType
     , "meta" >: HM.HashMap Language WorkMeta
     ]

type WorkSummary = Record
    '[ "id" >: Text
     , "timeStamp" >: Int32
     ]

type WorksApi = "works" :> 
    ( Capture "lang" Language :> Capture "id" Text :> Get '[JSON] Work
    :<|> Capture "lang" Language :> Get '[JSON] [WorkSummary]
    )

worksServer :: Server WorksApi
worksServer = workHandler
            :<|> summaryHandler

workHandler :: Language -> Text -> Servant.Handler Work
workHandler = undefined

summaryHandler :: Language -> Servant.Handler [WorkSummary]
summaryHandler = undefined
