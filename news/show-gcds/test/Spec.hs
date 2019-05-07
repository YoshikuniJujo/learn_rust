{-# OPTIONS_GHC -Wall -fno-warn-tabs #-}

import Prelude hiding (gcd)
import Control.Monad
import System.Exit

import Gcd

main :: IO ()
main = do
	unless (gcd 14 15 == 1) exitFailure
	unless (gcd
		(2 * 3 * 5 * 11 * 17)
		(3 * 7 * 11 * 13 * 19) == 3 * 11) exitFailure
