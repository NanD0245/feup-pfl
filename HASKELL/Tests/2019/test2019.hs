{-EX1
a) [[1,2],[],[3,4],[5]]

b) [5]

c) 2

d) [16,20,24,28,32]

e) [(3,2),(4,3),(5,4),(5,6),(6,8),(7,12)]

f) [[2,8],[4,6],[]]

g) [x | x <- zip [0..6] (reverse [0..6])]

h) 1*3 + 3*1 + 1*5 + 5*0 + 0*4 + 4 = 15

i) [(Char,String)]

j) (Ord a, Num a) => a -> [a] -> Bool

k) ig :: Eq a => [a] -> Bool

i) Eq a => (a -> a) -> a -> Bool
-}

--EX2

pitagoricos :: Int -> Int -> Int -> Bool 
pitagoricos a b c   | a >= b && a >= c = b*b + c*c == a*a 
                    | b >= a && b >= c = a*a + c*c == b*b 
                    | otherwise = b*b + a*a == c*c

hipotenusa :: Float -> Float -> Float 
hipotenusa a b = sqrt (a*a + b*b)

--EX3

diferentesRec :: Eq a => [a] -> [a]
diferentesRec [] = []
diferentesRec [_] = []
diferentesRec (x:xs)    | x == head xs = diferentesRec xs
                        | otherwise = x : diferentesRec xs

diferentesLista :: Eq a => [a] -> [a]
diferentesLista l = [fst a | a <- zip l (tail l), fst a /= snd a]

--EX4

zip3 :: [a] -> [b] -> [c] -> [(a,b,c)]
zip3 a b c = [(x,y,z) | ((x,y),z) <- zip (zip a b) c]

--EX5

partir :: Eq a => a -> [a] -> ([a],[a])
partir x l = (lista1 x l,lista2 x l)

lista1, lista2 :: Eq a => a -> [a] -> [a]
lista1 x [] = []
lista1 x (y:ys)     | x == y = []
                    | otherwise = y : lista1 x ys

lista2 x [] = []
lista2 x (y:ys)     | x == y = (y:ys)
                    | otherwise = lista2 x ys

--EX6

parts :: [a] -> [[[a]]]
parts [] = [[]]
parts (x:xs) = [[x] : ps | ps <- pss] ++ [(x:p) : ps | (p:ps) <- pss] where pss = parts xs

            