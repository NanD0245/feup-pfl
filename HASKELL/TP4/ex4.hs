import Distribution.Simple.Utils (xargs)
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

--EX5
cifraChave :: String -> String -> String --uppercase letters only
cifraChave c s = [  if fromEnum (fst x) + fromEnum (snd x) - 130 >= 26
                        then (toEnum (fromEnum (fst x) + fromEnum (snd x) - 65 - 26)::Char) 
                    else  toEnum (fromEnum (fst x) + fromEnum (snd x) - 65 )::Char
                     | x <- zip s (concat (replicate (div (length s) (length c) + 1) c))]

--EX6
binom :: Int -> Int -> Int
binom n k = div (product [1..n]) (product [1..k] * product[1..(n-k)])



pascal :: [[Int]]
pascal = [[binom x y | y <- [0..x]] | x <- [0..4]]

binomOptimized :: Int -> Int -> Int 
binomOptimized n 0 = 1
binomOptimized n k | n == k = 1
                    | otherwise = binomOptimized (n-1) (k-1) + binomOptimized (n-1) k

pascalOptimized :: [[Int]]
pascalOptimized = [[binomOptimized x y | y <- [0..x]] | x <- [0..4]]

--EX7
data Arv a = Vazia | No a (Arv a) (Arv a)

sumArv :: Num a => Arv a -> a
sumArv Vazia = 0
sumArv (No x esq dir) = x + sumArv esq + sumArv dir

--EX8 com listar (teóricas) e EX21 (ssort)
listar :: Ord a => Arv a -> [a]
listar Vazia = []
listar (No x esq dir) = listar esq ++ [x] ++ listar dir

myMinimum :: Ord a => [a] -> a
myMinimum l   | length l == 1 = head l
            | otherwise = if head l < myMinimum (tail l) then head l else myMinimum (tail l)

myDelete :: Eq a => a -> [a] -> [a]
myDelete a [] = []
myDelete a l    | head l == a = tail l
                | otherwise = head l : myDelete a (tail l)

ssort :: Ord a => [a] -> [a]
ssort [] = []
ssort l = myMinimum l : ssort (myDelete (myMinimum l) l)

descentTree :: Ord a => Arv a -> [a]
descentTree t = reverse (ssort(listar t))

--EX9
nivel :: Int -> Arv a -> [a]
nivel a Vazia = []
nivel a (No x esq dir)  | a == 0 = [x]
                        | otherwise = nivel (a-1) esq ++ nivel (a-1) dir

--EX10
mapArv :: (a -> b) -> Arv a -> Arv b
mapArv f Vazia = Vazia
mapArv f (No x esq dir) = No (f x) (mapArv f esq) (mapArv f dir)

--EX11

--construção por insersão simples
inserir :: Ord a => a -> Arv a -> Arv a
inserir x Vazia = No x Vazia Vazia
inserir x (No y esq dir)
    | x==y = No y esq dir -- já ocorre; não insere
    | x<y = No y (inserir x esq) dir -- insere à esquerda
    | x>y = No y esq (inserir x dir) -- insere à direita


construir :: Ord a => [a] -> Arv a
construir [] = Vazia
construir (x:xs) = inserir x (construir xs)


-- Construir uma árvore equilibrada
-- pré-condição: a lista de valores deve estar por ordem crescente
construir' :: [a] -> Arv a
construir' [] = Vazia
construir' xs = No x (construir' xs') (construir' xs'')
    where   n = length xs `div` 2 -- ponto médio
            xs' = take n xs -- partir a lista
            x:xs'' = drop n xs

altura :: Arv a -> Int
altura Vazia = 0
altura (No x esq dir) = 1 + max (altura esq) (altura dir)

--altura usando construir [0..n] irá sempre ser n pois estamos sempre a por no ramo da direita do anterior
--altura usando construir' [0..n] irá sempre ser o inteiro a seguir ao log2 de n pois divide o array a meio tendo assim a menor altura possível

--EX12
maisEsq :: Arv a -> a
maisEsq (No x Vazia _) = x
maisEsq (No _ esq _) = maisEsq esq

maisDir :: Arv a -> a
maisDir (No x _ Vazia) = x
maisDir (No _ _ dir) = maisDir dir

remover :: Ord a => a -> Arv a -> Arv a
remover a Vazia = Vazia
remover a (No x Vazia dir)  | x == a = dir
remover a (No x esq Vazia)  | x == a = esq
remover a (No x esq dir)    | a < x = No x (remover a esq) dir
                            | a > x = No x esq (remover a dir)
                            | a == x = No (maisDir esq) (remover (maisDir esq) esq) dir
