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
import Control.Monad.IO.Class (liftIO)
import Utils (doubleValue) -- 別のファイルから関数をインポート

-- Pointデータ型の定義
data Point = Point
  { x :: Int
  , y :: Int
  } deriving (Eq, Show, Generic)

instance ToJSON Point
instance FromJSON Point

-- 2つの整数を受け取るデータ型の定義
data TwoInts = TwoInts
  { a :: Int
  , b :: Int
  } deriving (Eq, Show, Generic)

instance FromJSON TwoInts

-- APIタイプの定義
type API = "doublePoint" :> ReqBody '[JSON] TwoInts :> Post '[JSON] Point

-- サーバーの定義
server :: Server API
server = doublePointHandler

-- リクエストを処理するハンドラー
doublePointHandler :: TwoInts -> Handler Point
doublePointHandler (TwoInts a b) = return $ Point (doubleValue a) (doubleValue b)

-- サーバーの設定
api :: Proxy API
api = Proxy

app :: Application
app = serve api server

-- サーバーの起動
runServant :: IO ()
runServant = run 8090 app