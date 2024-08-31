{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE DeriveGeneric #-}

module Lib
    ( runServant
    ) where

import Servant
import Data.Aeson (ToJSON, FromJSON)
import GHC.Generics (Generic)
import Network.Wai (Application)
import Network.Wai.Handler.Warp (run)
import Network.Wai.Middleware.Cors
import Utils (doubleValue, getGCD) -- 別のファイルから関数をインポート

import Network.HTTP.Types (hContentType)
import Network.HTTP.Types.Method (methodGet, methodPost, methodPut, methodDelete)

-- Pointデータ型の定義
data Point = Point
  { x :: Int
  , y :: Int
  } deriving (Eq, Show, Generic)

instance ToJSON Point
instance FromJSON Point

-- 2つの整数を受け取るデータ型の定義
data TwoInts = TwoInts
  { int1 :: Int
  , int2 :: Int
  } deriving (Eq, Show, Generic)

instance FromJSON TwoInts

-- APIタイプの定義
type API = "doublePoint" :> ReqBody '[JSON] TwoInts :> Post '[JSON] Point
       :<|> "getGCD" :> ReqBody '[JSON] TwoInts :> Post '[JSON] Int

-- リクエストを処理するハンドラー
doublePointHandler :: TwoInts -> Handler Point
doublePointHandler (TwoInts a b) = return $ Point (doubleValue a) (doubleValue b)

-- 新しいハンドラーを追加
getGCDHandler :: TwoInts -> Handler Int
getGCDHandler (TwoInts int1 int2) = return (getGCD int1 int2)

-- サーバーの定義
server :: Server API
server = doublePointHandler :<|> getGCDHandler
corsPolicy :: CorsResourcePolicy
corsPolicy = simpleCorsResourcePolicy
  { corsRequestHeaders = [hContentType]
  , corsMethods = [methodGet, methodPost, methodPut, methodDelete]
  -- , corsOrigins = Just ([pack "*"], True)
  }

-- サーバーの設定
api :: Proxy API
api = Proxy

app :: Application
app = cors (const $ Just corsPolicy) $ serve api server

-- サーバーの起動
runServant :: IO ()
runServant = run 8090 app