{-# OPTIONS_GHC -Wall -fno-warn-tabs #-}

module Main where

import System.IO (stderr, hPutStr)
import System.Environment (getProgName, getArgs)
import Text.Read (readMaybe)

import Parse (parsePair, parseComplex)
import Mandelbrot (render)
import Png (writeFromArray)

main :: IO ()
main = do
	(prg, args) <- (,) <$> getProgName <*> getArgs
	case args of
		[pn_, fp, wh_, lt_, rb_] -> do
			let	prms = do
					pn <- readMaybe pn_
					wh <- parsePair wh_ 'x'
					lt <- parseComplex lt_
					rb <- parseComplex rb_
					return (pn, wh, lt, rb)
			case prms of
				Just (pn, wh@(w, h), lt, rb) ->
					writeFromArray fp
						(render pn wh lt rb)
						(fromIntegral w)
						(fromIntegral h)
				_ -> hPutStr stderr prsErr
		_ -> hPutStr stderr . unlines $ usage prg

usage :: String -> [String]
usage prg = [
	"Usage: " ++ prg ++ " PARNUM FILE PIXELS LEFTTOP RIGHTBOTTOM",
	"Example: " ++ prg ++ " 8 mandel.png 1000x750 -1.20,0.35 -1,0.20" ]

prsErr :: String
prsErr = "Error: error parsing some command-line arguments"
