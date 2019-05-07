{-# LANGUAGE DataKinds, TypeApplications #-}
{-# OPTIONS_GHC -Wall -fno-warn-tabs #-}

module Lib (startApp) where

import Prelude hiding (head)

import Text.Blaze.Html5
import Network.Wai.Handler.Warp
import Servant
import Servant.HTML.Blaze

data HelloWorld = HelloWorld deriving Show

instance ToMarkup HelloWorld where
	toMarkup _ = docTypeHtml $ do
		head . title $ toHtml "Say Hello"
		body $ toHtml "Hello, world!"

type API = Get '[HTML] HelloWorld

startApp :: IO ()
startApp = run 8080 $ serve @API Proxy $ return HelloWorld
