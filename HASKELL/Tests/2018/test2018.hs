{-EX1
a) [[1,2,3],[4],[5]] 

b) 5

c) [8,6,4,2,0]

d) 9

e) [(1,1),(2,1),(3,1),(4,1),(2,2),(3,2),(4,2)]

f) [2,4,8,16,32]

g) [2^x - 1 | x <- [1..10]]

h) 1 + 2 + 3 + 4 + 5 = 15

i) ([Bool],[Char])

j) p :: a -> b -> (a,b)

k) k :: Eq a => [a] -> [a] -> [a]

l) feql :: Eq a => [a] -> Bool
-}

--EX2

distancia :: (Float,Float) -> (Float,Float) -> Float
distancia (x1,y1) (x2,y2) = sqrt ((x2 - x1)^2 + (y2 - y1)^2) 

colineares :: (Float,Float) -> (Float,Float) -> (Float,Float) -> Bool 
colineares (x1,y1) (x2,y2) (x3,y3) = (y2 - y1) / (x2 - x1) == (y3 - y2) / (x3 - x2)

--EX3

niguaisRec :: Int -> a -> [a]
niguaisRec 0 _ = []
niguaisRec n a = a : niguaisRec (n-1) a

niguaisLista :: Int -> a -> [a]
niguaisLista n a = [a | x <- [1..n]]

--EX4

merge :: Ord a => [a] -> [a] -> [a]
merge [] [] = []
merge l [] = l
merge [] l = l
merge (x:xs) (y:ys) | x <= y = x : merge xs (y:ys)
                    | otherwise = y : merge (x:xs) ys

--EX5

length_zip :: [a] -> [(Int, a)]
length_zip l = [x | x <- zip [length l, length l - 1..1] l]

--EX6

--FUCK TROCOS
