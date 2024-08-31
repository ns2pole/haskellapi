-- Utils.hs
module Utils (doubleValue, getGCD) where

-- 2倍する処理を行う関数
doubleValue :: Int -> Int
doubleValue n = 200 * n + 12



getGCD :: Int -> Int -> Int
getGCD a b = a `mod` b

-- コードを書く
-- localで動く
-- localでangularから動く
-- centosにhaskellを送る→build→buildしたものをmacに送る→gitにpush→vpsでgitでpull→executeファイルを/usr/local/binに移動→execute
-- docker cp ~/Program/haskell_exercise/first-project d502e9d8db1a:/app/
-- docker cp d502e9d8db1a:/app/first-project/.stack-work ~
