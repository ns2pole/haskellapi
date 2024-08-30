{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE DeriveGeneric #-}

module Lib
    ( runServant
    ) where

import Servant
import Data.Aeson(ToJSON)
import Data.Time.Calendar
import GHC.Generics(Generic)
import Network.Wai(Application)
import Network.Wai.Handler.Warp(run)

data User = User
  { name :: String
  , age :: Int
  , email :: String
  , registration_date :: Day
  } deriving (Eq, Show, Generic)

instance ToJSON User


data Point = Point
  { x :: Int
  , y :: Int
  } deriving (Eq, Show, Generic)

instance ToJSON Point

isaac :: User
isaac = User "Isaac Newton" 372 "isaac@newton.co.uk" (fromGregorian 1683 3 1)

isaac2 :: User
isaac2 = User "Isaac2 Newton" 372 "isaac@newton.co.uk" (fromGregorian 1683 3 1)

point :: Point
point = Point 1 3


albert :: User
albert = User "Albert Einstein" 136 "ae@mc2.org" (fromGregorian 1905 12 1)

users2 :: [User]
users2 = [isaac, albert]

type UserAPI2 = "users" :> Get '[JSON] [User]
           :<|> "albert" :> Get '[JSON] User
           :<|> "isaac" :> Get '[JSON] User
           :<|> "isaac2" :> Get '[JSON] User
           :<|> "point" :> Get '[JSON] Point

server2 :: Server UserAPI2
server2 = return users2
     :<|> return albert
     :<|> return isaac
     :<|> return isaac2
     :<|> return point

userAPI :: Proxy UserAPI2
userAPI = Proxy

-- 'serve' comes from servant and hands you a WAI Application,
-- which you can think of as an "abstract" web application,
-- not yet a webserver.
app2 :: Application
app2 = serve userAPI server2

runServant :: IO ()
runServant = run 8090 app2