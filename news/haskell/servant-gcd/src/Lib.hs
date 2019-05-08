{-# LANGUAGE DataKinds, TypeApplications, OverloadedStrings #-}
{-# OPTIONS_GHC -Wall -fno-warn-tabs #-}

module Lib (startApp) where

import Prelude hiding (head)
import Network.Wai.Handler.Warp
import Servant
import Servant.HTML.Lucid
import Lucid

import qualified Data.Text as T

data GetForm = GetForm deriving Show

instance ToHtml GetForm where
	toHtml _ = doctypehtml_ $ do
		head_ . title_ $ toHtml ("GCD Calculator" :: T.Text)
		body_ . form_ [action_ "/gcd", method_ "post"] $ do
			input_ [type_ "text", name_ "n"]
			input_ [type_ "text", name_ "n"]
			button_ [type_ "submit"] "Compute GCD"
	toHtmlRaw = toHtml

type API = Get '[HTML] GetForm

startApp :: IO ()
startApp = run 8080 $ serve @API Proxy $ return GetForm
