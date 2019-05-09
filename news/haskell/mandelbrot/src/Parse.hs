{-# OPTIONS_GHC -Wall -fno-warn-tabs #-}

module Parse (parsePair, parseComplex) where

import Data.Complex
import Text.Read

parsePair :: Read a => String -> Char -> Maybe (a, a)
parsePair s c = case span (/= c) s of
	(_, []) -> Nothing
	(l, _ : r) -> (,) <$> readMaybe l <*> readMaybe r

parseComplex :: String -> Maybe (Complex Double)
parseComplex s = uncurry (:+) <$> parsePair s ','
