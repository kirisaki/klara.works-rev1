{-# LANGUAGE DataKinds #-}
{-# LANGUAGE OverloadedLabels #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators #-}
module KlaraWorks.Works where

import Control.Monad.Reader
import Control.Lens
import Data.Extensible
import Data.Text
import Data.Int
import qualified Data.Map.Strict as M
import GHC.Generics
import Servant
import Servant.API
import Servant.Server

import KlaraWorks.Env

-- temporary import
import Data.Maybe




type WorksApi = "works" :> 
    ( Capture "lang" Language :> Capture "id" Text :> Get '[JSON] Work
    :<|> Capture "lang" Language :> Get '[JSON] [Work]
    )

worksServer :: (HasWorksEnv env) => ServerT WorksApi (ApiHandler env)
worksServer = workHandler
            :<|> summaryHandler

workHandler :: (HasWorksEnv env) => Language -> Text -> ApiHandler env Work
workHandler lang wid = do
    work <- case M.lookup wid sample of
              Just w -> pure w
              Nothing -> throwError err404 {errBody = "{\"message\":\"not found\"}"}
    meta <- case M.lookup lang (work ^. #meta) of
              Just m -> pure m
              Nothing -> pure $ (work ^. #meta) M.! Japanese 
    pure $ #id @= work ^. #id
         <: #type @= work ^. #type
         <: #meta @= meta
         <: #cover @= fromJust (work ^. #cover) <> ".jpg"
         <: nil

summaryHandler :: (HasWorksEnv env) => Language -> ApiHandler env [Work]
summaryHandler lang = pure $  
    (\(k, work) -> 
        let
            meta = M.findWithDefault ((work ^. #meta) M.! Japanese) lang (work ^. #meta)
        in
            #id @= work ^. #id
         <: #type @= work ^. #type
         <: #meta @= meta
         <: #cover @= case work ^. #cover of
                        Just n -> n
                        Nothing -> work ^. #id <> ".jpg"
         <: nil
    ) <$> M.toDescList sample

sample :: M.Map Text WorkInternal
sample = M.fromList 
    [ ( "20200228-lady"
      , #id @= "20200228-lady" 
      <: #type @= Picture 
      <: #meta @= M.fromList 
        [ ( Japanese, #title @= "Lady" <: #origin @= Nothing <: nil )
        , ( English, #title @= "Lady" <: #origin @= Nothing <: nil )
        ]
      <: #cover @= Nothing
      <: nil
      )
    , ( "20200215-hamakaze"
      , #id @= "20200215-hamakaze" 
      <: #type @= Picture 
      <: #meta @= M.fromList 
        [ ( Japanese, #title @= "浜風" <: #origin @= Just "艦隊これくしょん" <: nil )
        , ( English, #title @= "Hamakaze" <: #origin @= Just "Kantai Collection" <: nil )
        ]
      <: #cover @= Nothing
      <: nil
      )
    ]
