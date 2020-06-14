{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module TGApi.Types
    ( TGResponse(result),
      GetUpdatesParameters(..),
      BotInfo,
      Update(update_id, message),
      Message(text)
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

data (FromJSON a, Show a) => TGResponse a = TGResponse {ok :: Bool, result :: a} deriving Show
instance (FromJSON a, Show a) => FromJSON (TGResponse a) where
    parseJSON (Object response) = TGResponse <$>
                                  response .: "ok" <*>
                                  response .: "result"
    parseJSON invalid = typeMismatch "Response" invalid

data BotInfo = BotInfo {id :: Integer, is_bot :: Bool, bot_first_name :: String, bot_username :: String,
                        can_join_groups :: Bool, can_read_all_group_messages :: Bool,
                        supports_inline_queries :: Bool} deriving Show
instance FromJSON BotInfo where
    parseJSON (Object botInfo) = BotInfo <$>
                                 botInfo .: "id" <*>
                                 botInfo .: "is_bot" <*>
                                 botInfo .: "first_name" <*>
                                 botInfo .: "username" <*>
                                 botInfo .: "can_join_groups" <*>
                                 botInfo .: "can_read_all_group_messages" <*>
                                 botInfo .: "supports_inline_queries"
    parseJSON invalid = typeMismatch "BotInfo" invalid

data GetUpdatesParameters = GetUpdatesParameters {
    offset :: Maybe Integer,
    limit :: Maybe Int,
    timeout :: Maybe Int,
    allowed_updates :: Maybe [String]
} deriving (Show, Generic)

instance ToJSON GetUpdatesParameters
instance FromJSON GetUpdatesParameters

--updates
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

data Update = Update {update_id :: Integer, message :: Message} deriving (Show, Generic)
instance FromJSON Update

data Message = Message {message_id :: Integer, from :: User, chat :: Chat, date :: Integer,
                        text :: String} deriving (Show, Generic)
instance FromJSON Message

data User = User {user_id :: Integer, user_is_bot :: Bool, first_name :: String, username :: String,
                  language_code :: String} deriving Show
instance FromJSON User where
    parseJSON (Object user) = User <$>
                              user .: "id" <*>
                              user .: "is_bot" <*>
                              user .: "first_name" <*>
                              user .: "username" <*>
                              user .: "language_code"
    parseJSON invalid = typeMismatch "User" invalid

data Chat = Chat {chat_id :: Integer, user_first_name :: String, username_in_chat :: String,
                  chat_type :: String} deriving Show
instance FromJSON Chat where
    parseJSON (Object chat) = Chat <$> chat .: "id" <*>
                              chat .: "first_name" <*>
                              chat .: "username" <*>
                              chat .: "type"
    parseJSON invalid = typeMismatch "Chat" invalid