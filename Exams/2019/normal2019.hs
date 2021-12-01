{-EX1
a) 3

b) [[1,2],[3]]

c) [11,12,13,14,15]

d) 240

e) []

f) False

g) [(1,1),(4,4),(9,7),(16,10),(25,13),(36,16)] 

h) [x | x <- zip [1,3..] [10,8..]]

i) [5,4,3,2,1]

j) Num a => a -> a

k) [(Bool -> Bool) -> [Bool] -> [Bool]]

l) data Arv a = F a | N (Arv a) (Arv a)

m) g :: (a -> Bool) -> [a]
-}

--EX2

notaF :: [Float] -> [Float] -> Float
notaF a b = sum [x*y | (x,y) <- zip a b]

rfc :: [[Float]] -> [Float] -> Int
rfc a b = length [1 | x <- a, notaF x b < 8]

--EX3

type Vert = Int
type Graph = [(Vert,Vert)]

--EX4

iterate :: (a -> a) -> a -> [a]
iterate f a = lista where lista = a : [f a | a <- lista]

--EX5

deleteNthRec :: Int -> [a] -> [a]
deleteNthRec = deleteNthAux 1

deleteNthAux :: Int -> Int -> [a] -> [a]
deleteNthAux _ _ [] = []
deleteNthAux i n (x:xs) | i == n = deleteNthAux 1 n xs
                        | otherwise = x : deleteNthAux (i+1) n xs

deleteNthLista :: Int -> [a] -> [a]
deleteNthLista n l = [fst x | x <- zip l (concat (replicate (div (length l) n + 1) [1..n])), snd x /= n]

--EX6

data Arv a  = Folha | No a (Arv a) (Arv a)

soma :: Num a => Arv a -> a
soma Folha = 0
soma (No x esq dir) = x + soma esq + soma dir

somaArv :: Num a => Arv a -> Arv a -> Arv a
somaArv Folha Folha = No 0 Folha Folha
somaArv (No x esq1 dir1) Folha = No x esq1 dir1
somaArv Folha (No y esq2 dir2) = No y esq2 dir2
somaArv (No x esq1 dir1) (No y esq2 dir2) = No (x+y) (somaArv esq1 esq2) (somaArv dir1 dir2)

--EX7
