{-# OPTIONS_GHC -Wall -fno-warn-tabs #-}

module Try where

import Control.Monad.ST
import Data.Array.ST

data T a = E | A a | T a :| T a deriving Show

someArray :: ST s (STArray s Int Int)
someArray = do
	a <- newArray (0, 15) 0
	writeArray a 3 123
	return a
