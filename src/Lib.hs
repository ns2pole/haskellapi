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
import Utils (getGCD, getCoprimeNumsUnder, getCyclicGroupBy, getCyclicGroupsBy, getCyclicGroupOrderBy, getCyclicGroupIndexOf, isCyclicForReducedResidueClassGroup, getCyclicGroupOrderListBy)

import Network.HTTP.Types (hContentType)
import Network.HTTP.Types.Method (methodGet, methodPost, methodPut, methodDelete)

-- Pointデータ型の定義
data Point = Point
  { x :: Integer
  , y :: Integer
  } deriving (Eq, Show, Generic)

instance ToJSON Point
instance FromJSON Point

-- 2つの整数を受け取るデータ型の定義
data TwoInts = TwoInts
  { int1 :: Integer
  , int2 :: Integer
  } deriving (Eq, Show, Generic)

instance FromJSON TwoInts

-- APIタイプの定義
type API = "getGCD" :> ReqBody '[JSON] TwoInts :> Post '[JSON] Integer
      :<|> "getCoprimeNumsUnder" :> ReqBody '[JSON] Integer :> Post '[JSON] [Integer]
      :<|> "getCyclicGroupBy" :> ReqBody '[JSON] TwoInts :> Post '[JSON] [Integer]
      :<|> "getCyclicGroupsBy" :> ReqBody '[JSON] Integer :> Post '[JSON] [(Integer, [Integer])]
      :<|> "getCyclicGroupIndexOf" :> ReqBody '[JSON] TwoInts :> Post '[JSON] Integer
      :<|> "isCyclicForReducedResidueClassGroup" :> ReqBody '[JSON] Integer :> Post '[JSON] Bool
      :<|> "getCyclicGroupOrderListBy" :> ReqBody '[JSON] Integer :> Post '[JSON] [Integer]
      


-- ハンドラーを追加
getGCDHandler :: TwoInts -> Handler Integer
getGCDHandler (TwoInts int1 int2) = return (getGCD int1 int2)

getCoprimeNumsUnderHandler :: Integer -> Handler [Integer]
getCoprimeNumsUnderHandler n = return (getCoprimeNumsUnder n)

getCyclicGroupByHandler :: TwoInts -> Handler [Integer]
getCyclicGroupByHandler (TwoInts ele modulo) = return (getCyclicGroupBy ele modulo)

getCyclicGroupsByHandler :: Integer -> Handler [(Integer, [Integer])]
getCyclicGroupsByHandler modulo = return (getCyclicGroupsBy modulo)

getCyclicGroupIndexOfHandler :: TwoInts -> Handler Integer
getCyclicGroupIndexOfHandler (TwoInts ele modulo) = return (getCyclicGroupIndexOf ele modulo)

isCyclicForReducedResidueClassGroupHandler :: Integer -> Handler Bool
isCyclicForReducedResidueClassGroupHandler modulo = return (isCyclicForReducedResidueClassGroup modulo)

getCyclicGroupOrderListByHandler :: Integer -> Handler [Integer]
getCyclicGroupOrderListByHandler modulo = return (getCyclicGroupOrderListBy modulo)


-- サーバーの定義
server :: Server API
server = getGCDHandler 
  :<|> getCoprimeNumsUnderHandler 
  :<|> getCyclicGroupByHandler
  :<|> getCyclicGroupsByHandler
  :<|> getCyclicGroupIndexOfHandler
  :<|> isCyclicForReducedResidueClassGroupHandler
  :<|> getCyclicGroupOrderListByHandler
  
  
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
