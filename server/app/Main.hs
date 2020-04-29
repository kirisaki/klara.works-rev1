{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE OverloadedLabels  #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators     #-}
module Main where

import qualified Data.ByteString.Char8           as BSC
import           Data.Extensible
import qualified Data.Map.Strict                 as M
import           Data.Text
import           Network.HTTP.Types.Status
import           Network.Wai
import           Network.Wai.Handler.Warp
import           Network.Wai.Middleware.Gzip
import           Network.Wai.Middleware.HttpAuth
import           System.Environment

import           KlaraWorks
import           KlaraWorks.Env

main :: IO ()
main = do
    let settings = setPort 8080 defaultSettings
    user' <- fmap BSC.pack <$> lookupEnv "SERVER_USER"
    password' <- fmap BSC.pack <$> lookupEnv "SERVER_PASSWORD"
    let env = Env { works = WorksEnv { list = sample}}
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
