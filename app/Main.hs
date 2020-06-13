module Main where

import TGApi.Lib

main = do
--    botInfo <- getBotInfo
--    print botInfo
    updates <- getUpdates
    print updates
