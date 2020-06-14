{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module TGApi.Api
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

getBotInfo :: IO BotInfo
getBotInfo = do
    token <- getEnv "TOKEN"
    request <- parseRequest $ apiUrl ++ token ++ "/getMe"
    response <- httpJSON request :: IO (Response (TGResponse BotInfo))

--    putStrLn $ "The status code was: " ++
--               show (getResponseStatusCode response)
--    print $ getResponseHeader "Content-Type" response
    let botInfoResponse = getResponseBody response
    return $ result botInfoResponse

getUpdates :: GetUpdatesParameters -> IO [Update]
getUpdates updateParams = do
    token <- getEnv "TOKEN"
    initRequest <- parseRequest $ apiUrl ++ token ++ "/getUpdates"
    let proxy = Proxy "127.0.0.1" 9051
    let request = setRequestProxy (Just proxy) $ setRequestBodyJSON updateParams $ setRequestMethod "POST" initRequest
    response <- httpJSON request :: IO (Response (TGResponse [Update]))

--    putStrLn $ "The status code was: " ++
--               show (getResponseStatusCode response)
--    print $ getResponseHeader "Content-Type" response
    let updatesResponse = getResponseBody response
    return $ result updatesResponse

