{-# OPTIONS_GHC -Wall -fno-warn-tabs #-}

module SpeedChart (speeds, writeSpeedChart) where

import Control.Arrow
import Data.Foldable
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
	(`diffUTCTime` t0) <$> getCurrentTime

writeSpeedChart :: PlotValue a =>
	FilePath -> String -> String -> String -> [[(a, NominalDiffTime)]] -> IO ()
writeSpeedChart fp ttl xt lt ps_ = toFile def fp $ speedChart ttl xt lt ps
	where ps = map (map $ second $ fromRational . toRational) ps_

speedChart :: String -> String -> String ->
	[[(a, Double)]] -> EC (Layout a Double) ()
speedChart ttl xt lt pss = do
	layout_title .= ttl
	layout_x_axis .laxis_title .= xt -- "i: (2 ^ i) par"
	layout_y_axis .laxis_title .= "sec"
	for_ ([1 :: Int ..] `zip` pss) $ \(i, ps) ->
		plot $ line (lt ++ " " ++ show i) [ps]
