{-# LANGUAGE DataKinds, TypeApplications, OverloadedStrings #-}
{-# OPTIONS_GHC -Wall -fno-warn-tabs #-}

module Lib (startApp) where

import Text.Blaze.Html5 ((!))
import Prelude hiding (head)
import Network.Wai.Handler.Warp
import Servant
import Servant.HTML.Blaze

import qualified Data.Text as T
import qualified Text.Blaze.Html5 as M
import qualified Text.Blaze.Html5.Attributes as A

data GetForm = GetForm deriving Show

instance M.ToMarkup GetForm where
	toMarkup _ = M.docTypeHtml $ do
		M.head . M.title $ M.toHtml ("GCD Calculator" :: T.Text)
		M.body . (M.form ! A.action "/gcd" ! A.method "post") $ do
			M.input ! A.type_ "text" ! A.name "n"
			M.input ! A.type_ "text" ! A.name "n"
			M.button ! A.type_ "submit" $ "Compute GCD"

type API = Get '[HTML] GetForm

startApp :: IO ()
startApp = run 8080 $ serve @API Proxy $ return GetForm
