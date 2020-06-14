{-# LANGUAGE OverloadedStrings #-}

module Main where

import Control.Monad
import TGApi.Api
import TGApi.Types

main = runBot Nothing

runBot :: Maybe Integer -> IO ()
runBot currentOffset = do
        let params = GetUpdatesParameters {offset = currentOffset, limit = Nothing, timeout = Nothing,
                                           allowed_updates = Nothing}
        updates <- getUpdates params
        let lastUpdateId = case updates of [] -> Nothing
                                           _  -> Just $ maximum $ map (\update -> update_id update) updates
        case lastUpdateId of Nothing -> return ()
                             _       -> print lastUpdateId
        let messages = map (\update -> (update_id update, text $ message update)) updates
        forM_ messages (\message -> putStrLn $ snd message)
        runBot $ (+ 1) <$> lastUpdateId