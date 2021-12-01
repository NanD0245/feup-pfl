{-EX1
a) [2,3,1,4,4]

b) [0,10,20,30,40]

c) [[],[3,4],[5]]

d) 5

e) [1,1,1,1,1,1]

f) [(1,4),(2,3),(3,2)]

g) [2^x | x <- [0..6]]

h) 0

i) [(False,0),(True,1)] :: Num a => [(Bool,a)]

j) troca :: (a,b) -> (b,a)

k) g :: (Ord a, Num a) => a -> a -> a

l) [(x, x !! n) | n <- [0..10]] :: ([a], a)
-}

--EX2

ttriangulo :: (Eq a, Num a) => a -> a -> a -> String 
ttriangulo a b c    | a == b && b == c = "equilatiero"
                    | a == b || a == c || b == c = "isosceles"
                    | otherwise = "escaleno"

rectangulo :: (Ord a, Floating a) => a -> a -> a -> Bool 
rectangulo a b c    | a >= b && a >= c = b^2 + c^2 == a^2
                    | b >= a && b >= c = a^2 + c^2 == b^2
                    | otherwise = b^2 + a^2 == c^2

--EX3

maiores :: Ord a => [a] -> [a]
maiores [x] = []
maiores (x:y:ys)    | x > y = x : maiores (y:ys)
                    | otherwise = maiores (y:ys)

--EX4

somaparesRec, somaparesLista :: Num a => [(a,a)] -> [a]
somaparesRec [] = []
somaparesRec (x:xs) = (fst x + snd x) : somaparesRec xs

somaparesLista l = [fst x + snd x | x <- l]

--EX5

itera :: Int -> (a -> a) -> a -> a
itera 0 _ v = v
itera n f v = f (itera (n-1) f v)

mult :: Int -> Int -> Int 
mult a b = itera b (+a) 0 