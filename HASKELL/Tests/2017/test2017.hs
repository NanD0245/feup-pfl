{-EX1
a) [1,5,4,3]

b) [5,6,9]

c) 2

d) [15,18,21,24,27,30]

e) 4

f) [1,2,3,4,6,9]

g) [1,2,3]

h) [x*(-1)^x | x <- [0..10]]

i) 8

j) ([Char],[Float])

k) fst :: (a,b) -> a

l) h :: Ord a => a -> a -> a -> Bool

m) f :: [a] -> a
-}


--EX2

numEqual :: Eq a => a -> a -> a -> Int
numEqual n m p  | n == m && m == p = 3
                | n == m || n == p || m == p = 2
                | otherwise = 1

--EX3

area :: Floating a => a -> a -> a -> a -> a -> a -> a
area a b c d p q = sqrt(4 * (p^2) * (q^2) - (b^2 + d^2 - a^2 - c^2)^2) / 4

--EX4

enquantoPar :: [Int] -> [Int]
enquantoPar [] = []
enquantoPar (x:xs)  | mod x 2 == 0 = x : enquantoPar xs
                    | otherwise = []

--EX5

nat_zip :: [a] -> [(Int, a)]
nat_zip l = [x | x <- zip [1..length l] l]

--EX6

quadradosRec, quadradosLista :: [Int] -> [Int]
quadradosRec [] = []
quadradosRec (x:xs) = x^2 : quadradosRec xs

quadradosLista l = [x^2 | x <- l]

--EX7

