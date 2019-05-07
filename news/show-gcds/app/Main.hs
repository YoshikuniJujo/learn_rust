{-# OPTIONS_GHC -Wall -fno-warn-tabs #-}

module Main where

import Prelude hiding (gcd)
import Text.Read
import System.IO
import System.Environment

import Gcd

main :: IO ()
main = do
	args <- getArgs
	let	numbers@(n : ns) =
			(either (error . ("error parsing argument: " ++))
				id . readEither) <$> args
	case length numbers of
		0 -> hPutStrLn stderr "Usage: gcd NUMBER ..."
		_ -> do	putStrLn $ "The greatest common divisor of " ++
				show numbers ++ " is " ++ show (foldl gcd n ns)
