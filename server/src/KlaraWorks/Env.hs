{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE LambdaCase        #-}
{-# LANGUAGE OverloadedLabels  #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell   #-}
{-# LANGUAGE TypeOperators     #-}
module KlaraWorks.Env where

import           Control.Lens
import           Control.Monad.Reader
import           Data.Aeson
import           Data.Extensible
import qualified Data.Map.Strict      as M
import           Data.Text
import           GHC.Generics
import           Network.Wai
import           Servant
import           Servant.API

data Language
    = Japanese
    | English
    deriving(Show, Eq, Generic, Ord)

instance ToJSON Language
instance FromJSON Language
instance FromJSONKey Language
instance FromHttpApiData Language where
    parseUrlPiece = \case
        "jpn" -> Right Japanese
        "eng" -> Right English
        _ -> Left "unsupported"

data WorkType
    = Picture
    | Manga
    | Font
    deriving(Show, Eq, Generic)

instance ToJSON WorkType
instance FromJSON WorkType

type WorkMeta = Record
    '[ "title" >: Text
     , "origin" >: Maybe Text
     , "description" >: Maybe Text
     ]

type Work = Record
    '[ "id" >: Text
     , "type" >: WorkType
     , "meta" >: WorkMeta
     , "cover" >: Text
     ]
type WorkInternal = Record
    '[ "id" >: Text
     , "type" >: WorkType
     , "meta" >: M.Map Language WorkMeta
     , "cover" >: Maybe Text
     ]

newtype WorksEnv = WorksEnv
    { list :: M.Map Text WorkInternal
    }

makeLensesWith classyRules_ ''WorksEnv

newtype Env = Env
    { works :: WorksEnv
    }

makeClassy_ ''Env

instance HasWorksEnv Env where
    worksEnv = _works

type ApiHandler env = ReaderT env Servant.Handler
