--Aulas teóricas
primos :: [Int]
primos = crivo [2..]

crivo :: [Int] -> [Int]
crivo (p:xs) = p : crivo [x | x<-xs, mod x p /=0]


--EX1
factores :: Int -> [Int]
factores a = snd (until (\(x,y) -> x == 1) (\(x,y) -> (div x (primeiroDivisorPrimo x 2), y ++ [primeiroDivisorPrimo x 2])) (a,[]))

primeiroDivisorPrimo :: Int -> Int -> Int
primeiroDivisorPrimo a i    | mod a (head (crivo [i..])) == 0 = head (crivo [i..])
                            | otherwise = primeiroDivisorPrimo a (i+1)

--EX2
calcPi1 :: Int -> Double
calcPi1 a = sum (take a [(4.0 * (-1) ^ round x) / (2.0 * x + 1) | x <- [0..]])

calcPi2 :: Int -> Double
calcPi2 a = 3 + sum (take a (zipWith (/) [4 * (-1) ^ round x | x <- [0..]] [x * (x+1) * (x+2) | x <- [2..], even (round x)] ))

--EX3
intercalar :: a -> [a] -> [[a]]
intercalar a l = [intercalarHelper a l x | x <- [0..(length l)]]

intercalarHelper :: a -> [a] -> Int -> [a]
intercalarHelper a l x = take x l ++ [a] ++ drop x l

--EX4
perms :: Eq a => [a] -> [[a]]
perms l = elimRepetidos (permsHelper l 0 ++ permsHelper (reverse l) 0)

permsHelper :: Eq a => [a] -> Int -> [[a]]
permsHelper l x | x == length l = []
                | x == 0 = intercalar (l !! x) (tail l) ++ permsHelper l (x + 1)
                | otherwise = intercalar (l !! x) (take x l ++ drop (x + 1) l) ++ permsHelper l (x + 1)

elimRepetidos :: Eq a => [[a]] -> [[a]]
elimRepetidos [] = []
elimRepetidos l = head l : elimRepetidos (deleteDuplicates (head l) l)

deleteDuplicates :: Eq a => a -> [a] -> [a]
deleteDuplicates a l = [x | x <- l, a /= x]
