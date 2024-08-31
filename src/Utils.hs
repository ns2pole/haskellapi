-- Utils.hs
module Utils (doubleValue, getGCD) where

-- 2倍する処理を行う関数
doubleValue :: Int -> Int
doubleValue n = 200 * n + 12



getGCD :: Int -> Int -> Int
getGCD a b = if a == 0
                then b
            else if  b == 0
                then a
            else if  a `mod` b == 0
                then b
            else getGCD b (a `mod` b)

