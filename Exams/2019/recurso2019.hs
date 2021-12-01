import Distribution.Simple.Utils (xargs)
{-EX1
a) [[],[],[],[]]

b) 4

c) [0,0,0,1,1,1,1,2,2,2]

d) [1,3,9,27,81]

e) [4,8]

f) [2,4,6,8,10,12,14,16,18,20]

g) take 10 [if mod x 2 == 0 then 2 * x else 2^x - 1 | x <- [0..]]

h) False

i) Integral a => [a -> Bool]

j) [Char] -> Int

k) data Arv = No Arv a Arv

l) flip :: (b -> a -> c) -> a -> b -> c
-}

--EX2

imparDiv3 :: [Int] -> Bool 
imparDiv3 l = and [ not (mod x 2 == 0 && mod x 3 == 0) | x <- l]

imparDiv3Sup :: [Int] -> Bool 
imparDiv3Sup l = foldr (\x a -> not (mod x 2 == 0 && mod x 3 == 0) && a) True l

--EX3

type Rel a = [(a,[a])]

--EX4

get :: Int -> [Int]
get a = take a lista where lista = 1 : [2 * x + y + 1 | (x,y) <- zip lista [2..]]

--EX5

duplicada :: Eq a => [a] -> Bool 
duplicada [] = True 
duplicada [_] = False 
duplicada (x:y:ys)  | x == y = duplicada ys
                    | otherwise = False

duplica :: [a] -> [a]
duplica l = concat [ [x,x] | x <- l]

--EX6

data Arv a = Folha a | No (Arv a) (Arv a)

emOrdem :: Arv a -> [a]
emOrdem (Folha x) = [x]
emOrdem (No esq dir) = emOrdem esq ++ emOrdem dir

anyArv :: (a -> Bool) -> Arv a -> Bool
anyArv f (Folha x) = f x
anyArv f (No esq dir) = anyArv f esq || anyArv f dir



