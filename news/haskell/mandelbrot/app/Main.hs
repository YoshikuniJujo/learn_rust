{-# OPTIONS_GHC -Wall -fno-warn-tabs #-}

module Main where

import Control.Arrow
import System.IO
import System.Environment

import Control.Parallel.Strategies

import Parse
import Mandelbrot
import Png

main :: IO ()
main = do
	pn <- getProgName
	args <- getArgs
	case args of
		[fp, wh_, lt_, rb_] -> do
			let	prms = do
					wh <- parsePair wh_ 'x'
					lt <- parseComplex lt_
					rb <- parseComplex rb_
					return (wh, lt, rb)
			case prms of
				Just (wh, lt, rb) -> do
					let	pxls = render wh lt rb
							`using` parList rsec
					uncurry (writePngFromArray fp pxls)
						$ (fromIntegral ***
							fromIntegral) wh
				_ -> error "error parsing some arguments"
		_ -> do	hPutStrLn stderr $
				"Usage: mandelbrot " ++
				"FILE PIXELS UPPERLEFT LOWERRIGHT"
			hPutStrLn stderr $
				"Example: " ++ pn ++
				" mandel.png 1000x750 -1.20,0.35 -1,0.20"
	putStrLn "Slozsoft"
