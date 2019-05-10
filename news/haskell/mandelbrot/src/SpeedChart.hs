{-# OPTIONS_GHC -Wall -fno-warn-tabs #-}

module SpeedChart (speeds, writeSpeedChart) where

import Control.Arrow
import Data.Traversable
import Data.Time
import Graphics.Rendering.Chart.Easy
import Graphics.Rendering.Chart.Backend.Diagrams

speeds :: [a] -> (a -> IO ()) -> IO [(a, NominalDiffTime)]
speeds xs act = for xs $ uncurry ((<$>) . (,)) . (id &&& speed . act)

speed :: IO () -> IO NominalDiffTime
speed act = do
	t0 <- getCurrentTime
	act
	(t0 `diffUTCTime`) <$> getCurrentTime

writeSpeedChart :: PlotValue a =>
	FilePath -> String -> String -> [(a, NominalDiffTime)] -> IO ()
writeSpeedChart fp ttl lt ps_ = toFile def fp $ speedChart ttl lt ps
	where ps = map (second $ fromRational . toRational) ps_

speedChart :: String -> String -> [(a, Double)] -> EC (Layout a Double) ()
speedChart ttl lt ps = do
	layout_title .= ttl
	plot $ line lt [ps]
