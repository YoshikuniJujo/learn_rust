{-# OPTIONS_GHC -Wall -fno-warn-tabs #-}

module Png (writePngFromArray) where

import Data.Array
import Codec.Picture

writePngFromArray :: FilePath -> Array Int Pixel8 -> Int -> Int -> IO ()
writePngFromArray fp pxls w h =
	writePng fp $ generateImage (\x y -> pxls ! (y * w + x)) w h

-- writePngFromArray "some.png" (listArray (0, 255) [0 ..]) 16 16
