{-# OPTIONS_GHC -Wall -fno-warn-tabs #-}

module Main where

import Control.Arrow
import System.IO
import System.Environment
import Text.Read

import Parse
import Mandelbrot
import Png

main :: IO ()
main = do
	prg <- getProgName
	args <- getArgs
	case args of
		[pn_, fp, wh_, lt_, rb_] -> do
			let	prms = do
					pn <- readMaybe pn_
					wh <- parsePair wh_ 'x'
					lt <- parseComplex lt_
					rb <- parseComplex rb_
					return (pn, wh, lt, rb)
			case prms of
				Just (pn, wh, lt, rb) -> do
					let	pxls = render pn wh lt rb
					uncurry (writePngFromArray fp pxls)
						$ (fromIntegral ***
							fromIntegral) wh
				_ -> error "error parsing some arguments"
		_ -> do	hPutStrLn stderr $
				"Usage: mandelbrot " ++
				"PARNUM FILE PIXELS UPPERLEFT LOWERRIGHT"
			hPutStrLn stderr $
				"Example: " ++ prg ++
				" 8 mandel.png 1000x750 -1.20,0.35 -1,0.20"
	putStrLn "Slozsoft"
