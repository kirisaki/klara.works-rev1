{-# LANGUAGE ExtendedDefaultRules #-}
{-# LANGUAGE OverloadedStrings #-}
module KlaraWorks.Html where

import Data.Text
import Lucid

htmlTemplate :: Text -> Html ()
htmlTemplate t = do
    doctype_ 
    html_ $ do
        head_ $ do
            meta_ [charset_ "utf-8"]
            meta_ [name_ "viewport", content_ "width=device-width, initial-scale=1.0"]
            meta_ [name_ "description", content_ "同人サークル「Klara Works」、および霧咲空人のポートフォリオサイト"]
            link_ [href_ "https://fonts.googleapis.com/css2?family=Josefin+Sans:wght@400&display=swap", rel_ "stylesheet"]
            link_ [href_ "https://fonts.googleapis.com/css2?family=M+PLUS+1p&display=swap", rel_ "stylesheet"]
            link_ [href_ "/assets/favicon.ico", rel_ "icon"]
            style_ [type_ "text/css"] "background: #444 url('/assets/back.svg');"
            title_ [] (toHtml t)
            script_ [async_ "", src_ "https://www.googletagmanager.com/gtag/js?id=UA-163141650-1"] empty
            script_ [] ("  window.dataLayer = window.dataLayer || [];"
                     <> "  function gtag(){dataLayer.push(arguments);}"
                     <> "  gtag('js', new Date());"
                     )
        body_ $ do
            div_ [id_ "app"] mempty
            script_ [src_ "/assets/main.js"] empty
