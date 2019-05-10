{-# OPTIONS_GHC -Wall -fno-warn-tabs #-}

module Png (writeFromArray) where

import Data.Array
import Codec.Picture

writeFromArray :: FilePath -> Array Int Pixel8 -> Int -> Int -> IO ()
writeFromArray fp pxls w h =
	writePng fp $ generateImage (\x y -> pxls ! (y * w + x)) w h
