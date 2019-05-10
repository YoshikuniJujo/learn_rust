{-# OPTIONS_GHC -Wall -fno-warn-tabs #-}

module Main where

import Control.Monad
import Data.Complex
import System.IO
import System.Environment
import Text.Read

import Parse
import Mandelbrot
import SpeedChart

mandelChart :: FilePath -> Int ->
	Int -> (Word, Word) -> Complex Double -> Complex Double -> IO ()
mandelChart fp ts n wh lt rb = do
	pss <- replicateM ts $
		speeds [0 .. n] $ \i -> render (2 ^ i) wh lt rb `seq` return ()
	writeSpeedChart fp "Mandelbrot Speed" "i: (2 ^ i) par" "time, par" pss

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
		[fp, ts_, wh_, lt_, rb_] -> do
			let	prms = do
					ts <- readMaybe ts_
					wh <- parsePair wh_ 'x'
					lt <- parseComplex lt_
					rb <- parseComplex rb_
					return (ts, wh, lt, rb)
			case prms of
				Just (ts, wh, lt, rb) -> mandelChart fp ts
					(uncurry getExponent wh) wh lt rb
				_ -> error "error parsing some arguments"
		_ -> do	hPutStrLn stderr $
				"Usage: mandel-speed " ++
				"FILE TIMES PIXELS UPPERLEFT LOWERRIGHT"
			hPutStrLn stderr $
				"Example: " ++ prg ++
				" mandel_speed.svg 5 1000x750 -1.20,0.35 -1,0.20"
