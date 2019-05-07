{-# OPTIONS_GHC -Wall -fno-warn-tabs #-}

module Gcd (gcd) where

import Prelude hiding (gcd)

gcd :: Word -> Word -> Word
gcd n_ m_ | n_ /= 0 && m_ /= 0 = g n_ m_
	where
	g n 0 = n
	g n m | m < n = g m n
	g n m = g n (m `mod` n)
gcd _ _ = error "gcd n m: n != 0 && m != 0"
