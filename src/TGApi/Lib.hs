{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module TGApi.Lib
    ( getBotInfo,
      getUpdates
    ) where

import Network.HTTP.Simple
import qualified Data.ByteString.Lazy.Char8 as LazyBytes
import GHC.Generics
import Data.Aeson.Types
import Data.Aeson (encode, decode)
import System.Environment
import TGApi.Types

apiUrl = "https://api.telegram.org/bot"

getBotInfo :: IO (TGResponse BotInfo)
getBotInfo = do
    token <- getEnv "TOKEN"
    request <- parseRequest $ apiUrl ++ token ++ "/getMe"
    response <- httpJSON request :: IO (Response (TGResponse BotInfo))

    putStrLn $ "The status code was: " ++
               show (getResponseStatusCode response)
    print $ getResponseHeader "Content-Type" response
    let botInfoResponse = getResponseBody response
    return botInfoResponse

getUpdates :: IO (TGResponse [Update])
getUpdates = do
    token <- getEnv "TOKEN"
    initRequest <- parseRequest $ apiUrl ++ token ++ "/getUpdates"
    let params = GetUpdatesParameters {offset = Just 973058113, limit = Nothing, timeout = Nothing,
                                       allowed_updates = Nothing}
    let request = setRequestBodyJSON params $ setRequestMethod "POST" initRequest
    response <- httpJSON request :: IO (Response (TGResponse [Update]))

    putStrLn $ "The status code was: " ++
               show (getResponseStatusCode response)
    print $ getResponseHeader "Content-Type" response
    let updates = getResponseBody response
    return updates

