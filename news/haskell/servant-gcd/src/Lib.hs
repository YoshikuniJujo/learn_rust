{-# LANGUAGE OverloadedStrings, TypeApplications #-}
{-# LANGUAGE DataKinds, TypeOperators #-}
{-# OPTIONS_GHC -Wall -fno-warn-tabs #-}

module Lib (startApp) where

import Prelude hiding (gcd)
import Network.Wai.Handler.Warp
import Web.FormUrlEncoded
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

data GcdArgs = GcdArgs { gcdArgN :: Word, gcdArgM :: Word } deriving Show

instance FromForm GcdArgs where
	fromForm form = do
		ns <- parseAll "n" form
		case ns of
			[n, m] -> return $ GcdArgs n m
			_ -> fail "Tow and only two parameters required"

data ShowResult = ShowResult {
	numN :: Word, numM :: Word, numGcd :: Word } deriving Show

instance ToHtml ShowResult where
	toHtml ShowResult { numN = n, numM = m, numGcd = g } = doctypehtml_ $ do
		head_ . title_ $ toHtml ("GCD Calculator" :: T.Text)
		body_ $ do
			toHtml $ "The greatest common divisor of the numbers " ++
				show n ++ " and " ++ show m ++ " is "
			b_ . toHtml $ show g
	toHtmlRaw = toHtml

type API =
	Get '[HTML] GetForm :<|>
	"gcd" :> ReqBody '[FormUrlEncoded] GcdArgs :> Post '[HTML] ShowResult

startApp :: IO ()
startApp = run 8080 $ serve @API Proxy $
	return GetForm :<|>
	\GcdArgs { gcdArgN = n, gcdArgM = m } ->
		return ShowResult { numN = n, numM = m, numGcd = gcd n m }

gcd :: Word -> Word -> Word
gcd n m | n > m = gcd m n
gcd 0 m = m
gcd n m = gcd (m `mod` n) n
