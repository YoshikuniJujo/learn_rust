{-# OPTIONS_GHC -Wall -fno-warn-tabs #-}

module Mandelbrot (render) where

import Data.Array
import Data.Complex
import Codec.Picture

escapeTime :: Complex Double -> Word -> Maybe Word
escapeTime c lim = case dropWhile ((<= 2) . magnitude . snd)
		. zip [0 .. lim - 1] . tail $ iterate (\z -> z * z + c) 0 of
	[] -> Nothing
	(i, _) : _ -> Just i

pixelToPoint :: (Word, Word) ->
	(Word, Word) -> Complex Double -> Complex Double -> Complex Double
pixelToPoint (wp, hp) (x, y) (l :+ t) (r :+ b) =
	(l + fromIntegral x * wc / fromIntegral wp) :+
	(t - fromIntegral y * hc / fromIntegral hp)
	where
	(wc, hc) = (r - l, t - b)

toPixel :: Maybe Word -> Pixel8
toPixel Nothing = 0
toPixel (Just c) = 255 - fromIntegral c

render :: (Word, Word) -> Complex Double -> Complex Double -> Array Int Pixel8
render wh@(w, h) lt rb = listArray (0, fromIntegral $ w * h - 1)
	$ (toPixel . (`escapeTime` 255) . \xy -> pixelToPoint wh xy lt rb)
		<$> [ (x, y) | y <- [0 .. h - 1], x <- [0 .. w - 1] ]