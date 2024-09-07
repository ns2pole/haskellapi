-- Utils.hs
module Utils (getGCD, getCoprimeNumsUnder, getCyclicGroupBy, getCyclicGroupsBy, getCyclicGroupOrderBy, getCyclicGroupIndexOf, isCyclicForReducedResidueClassGroup,getCyclicGroupOrderListBy) where

getGCD :: Integer -> Integer -> Integer
getGCD a b = if a == 0
                then b
            else if  b == 0
                then a
            else if  a `mod` b == 0
                then b
            else getGCD b (a `mod` b)

getCoprimeNumsUnder :: Integer -> [Integer]
getCoprimeNumsUnder n = [x | x <- [1 .. n-1], getGCD n x == 1]

getPower :: Integer -> Integer -> Integer -> Integer
getPower x modulo y = x^y `mod` modulo

takeUntilUnit :: [Integer] -> [Integer]
takeUntilUnit integers = ( takeWhile ( /= 1 ) integers ) ++ [1]

getCyclicGroupBy :: Integer -> Integer -> [Integer]
getCyclicGroupBy ele modulo = takeUntilUnit (map (getPower ele modulo ) [1 ..])

getCyclicGroupTupleFormatBy :: Integer -> Integer -> (Integer, [Integer])
getCyclicGroupTupleFormatBy ele modulo = (ele, getCyclicGroupBy ele modulo)

getCyclicGroupOrderBy :: Integer -> Integer -> Integer
getCyclicGroupOrderBy ele modulo = fromIntegral (length (getCyclicGroupBy ele modulo))

getCyclicGroupOrderListBy :: Integer -> [Integer]
getCyclicGroupOrderListBy modulo = map (`getCyclicGroupOrderBy` modulo) (getCoprimeNumsUnder modulo)


getCyclicGroupIndexOf :: Integer -> Integer -> Integer
getCyclicGroupIndexOf ele modulo = fromIntegral(length(getCoprimeNumsUnder modulo)) `div` (getCyclicGroupOrderBy ele modulo)

getCyclicGroupsBy  :: Integer -> [(Integer, [Integer])]
getCyclicGroupsBy modulo = map (`getCyclicGroupTupleFormatBy` modulo) (getCoprimeNumsUnder modulo) 


isCyclicForReducedResidueClassGroup :: Integer -> Bool
isCyclicForReducedResidueClassGroup modulo = or (map (== (length (getCoprimeNumsUnder modulo))) (map length (map snd (getCyclicGroupsBy modulo))))
    
    -- (length(getCoprimeNumsUnder modulo) == ) snd()
-- mod 10
-- f : 10 -> G = [1,3,7,9]
-- g : x y -> x^y mod 10
-- g : n , [1,2...] -> [n, (n^2 % 10), (n^3 % 10), ...
-- 7 -> 9 -> 3 -> 1

-- [1,3,7,9] 
-- 1 -> [1]
-- 3 -> [3,9,7,1] 
-- isCyclic
