{-# OPTIONS_GHC -Wall -fno-warn-tabs #-}

module Main where

import Data.Complex
import System.IO
import System.Environment

import Parse
import Mandelbrot
import SpeedChart

mandelChart :: Int -> (Word, Word) -> Complex Double -> Complex Double -> IO ()
mandelChart n wh lt rb = do
	ps <- speeds [0 .. n] $ \i -> render (2 ^ i) wh lt rb `seq` return ()
	writeSpeedChart "mandel_speed.svg"
		"Mandelbrot Speed" "i: (2 ^ i) par" "time, par" ps

getExponent :: Word -> Word -> Int
getExponent w h = ge (w * h) 0
	where
	ge n i	| 2 ^ i > n = i - 1
		| otherwise = ge n (i + 1)

main :: IO ()
main = do
	prg <- getProgName
	args <- getArgs
	case args of
		[wh_, lt_, rb_] -> do
			let	prms = do
					wh <- parsePair wh_ 'x'
					lt <- parseComplex lt_
					rb <- parseComplex rb_
					return (wh, lt, rb)
			case prms of
				Just (wh, lt, rb) -> mandelChart
					(uncurry getExponent wh) wh lt rb
				_ -> error "error parsing some arguments"
		_ -> do	hPutStrLn stderr $
				"Usage: mandel-speed " ++
				"FILE PIXELS UPPERLEFT LOWERRIGHT"
			hPutStrLn stderr $
				"Example: " ++ prg ++
				" 1000x750 -1.20,0.35 -1,0.20"
