{-# LANGUAGE DeriveGeneric #-}

module TGApi.Types
    ( BotInfoResponse,
      GetUpdatesParameters(..)
    ) where

import Data.Aeson.Types
import GHC.Generics

--botInfo
--{"ok":true,
-- "result":{"id":1171061905,
--           "is_bot":true,
--           "first_name":"notification-bot",
--           "username":"bzdyshek_bot",
--           "can_join_groups":true,
--           "can_read_all_group_messages":false,
--           "supports_inline_queries":false}}

data BotInfoResponse = BotInfoResponse {ok :: Bool, result :: BotInfo} deriving (Show, Generic)
instance FromJSON BotInfoResponse

data BotInfo = BotInfo {id :: Int, is_bot :: Bool, first_name :: String, username :: String, can_join_groups :: Bool,
                        can_read_all_group_messages :: Bool,  supports_inline_queries :: Bool} deriving (Show, Generic)
instance FromJSON BotInfo

data GetUpdatesParameters = GetUpdatesParameters {
    offset :: Maybe Int,
    limit :: Maybe Int,
    timeout :: Maybe Int,
    allowed_updates :: Maybe [String]
} deriving (Show, Generic)

instance ToJSON GetUpdatesParameters
instance FromJSON GetUpdatesParameters

--updateInfo
--{"ok":true,
-- "result":[
--    {"update_id":973058112,
--    "message":{
--        "message_id":15,
--        "from":{
--            "id":588485042,
--            "is_bot":false,
--            "first_name":"Vyacheslav",
--            "username":"Vyacheslav_Kovalev",
--            "language_code":"ru"
--        },
--        "chat":{
--            "id":588485042,
--            "first_name":"Vyacheslav",
--            "username":"Vyacheslav_Kovalev",
--            "type":"private"
--        },
--        "date":1591965645,
--        "text":"\u0411\u043e\u0442 \u0432\u0440\u043e\u0442\u043a\u043e\u043c\u043f\u043e\u0442"
--    }}
-- ]
--}

--data UpdateResponse = UpdateResponse {ok :: Bool, result :: [Update]}
--instance FromJSON UpdateResponse

--data Update = Update {update_id :: Int, }