{-# OPTIONS_GHC -Wall -fno-warn-tabs #-}

module Mandelbrot (render) where

import Control.Parallel.Strategies (
	NFData, Strategy, rparWith, rdeepseq, using, parListChunk)
import Data.List.Split (chunksOf)
import Data.Array (Array, listArray)
import Data.Complex (Complex(..), magnitude)
import Codec.Picture (Pixel8)

escapeTime :: Complex Double -> Word -> Maybe Word
escapeTime c lim = case dropWhile ((<= 2) . magnitude . snd)
		. zip [0 .. lim - 1] . tail $ iterate (\z -> z * z + c) 0 of
	[] -> Nothing
	(i, _) : _ -> Just i

pixelToPoint :: (Word, Word) -> Complex Double -> Complex Double ->
	(Word, Word) -> Complex Double
pixelToPoint (wp, hp) (l :+ t) (r :+ b) (x, y) =
	(l + fromIntegral x * (r - l) / fromIntegral wp) :+
	(t - fromIntegral y * (t - b) / fromIntegral hp)

render :: Word ->
	(Word, Word) -> Complex Double -> Complex Double -> Array Int Pixel8
render pn wh@(w, h) lt rb = listArray (0, fromIntegral $ w * h - 1) pixels
	where
	pixels = toGray . (`escapeTime` 255) . pixelToPoint wh lt rb
			<$> [ (x, y) | y <- [0 .. h - 1], x <- [0 .. w - 1] ]
		`using` parChunks (fromIntegral $ w * h `div` pn)
	toGray = maybe 0 ((255 -) . fromIntegral)

parChunks :: NFData a => Int -> Strategy [a]
-- parChunks = (`parListChunk` rdeepseq)
parChunks n _ | n < 1 = error "`parChunks n _': n should be positive"
parChunks n xs = concat <$> mapM (rparWith rdeepseq) (chunksOf n xs)
