{-EX1
a) 4

b) []

c) 22

d) [True, True, True, False, False]

e) 26

f) [(2,1),(3,2),(4,3)]

g) [(x,2^y) | (x,y) <- zip [1,3..] [1..]]

h) [2,4,2,10,12]

i) (Num a,Ord a) => [a -> Bool] ou [Int -> Bool]

j) Num a => a -> a

k) data Arv = Folha Int | No esq dir

l) f :: (Num a) => [a] -> [a] -> a
-}

--EX2

nafrente :: a -> [[a]] -> [[a]]
nafrente v l = [v : x | x <- l]

ocorreN :: Eq a => Int -> a -> [a] -> Bool 
ocorreN n a l = n == length [1 | x <- l , a == x]

--EX3



--EX4

soma :: IO ()
soma = somaAux 0

somaAux :: Int -> IO ()
somaAux m = do 
                x <- getLine 
                let n = read x in 
                    if n == 0 then print m
                    else somaAux (m + n)

--EX5

data ArvT a = Folha a | No (ArvT a) (ArvT a) (ArvT a)

arv :: ArvT Int 
arv = No (Folha 1) (No (Folha 4) (Folha 5) (Folha 8)) (Folha 9)


nelementos :: ArvT a -> Int 
nelementos (Folha a) = 1 
nelementos (No esq mid dir) = nelementos esq + nelementos mid + nelementos dir

mapTree :: (a -> b) -> ArvT a -> ArvT b
mapTree f (Folha a) = Folha (f a)
mapTree f (No esq mid dir) = No (mapTree f esq) (mapTree f mid) (mapTree f dir)


--EX6

scanl :: (a -> a -> a) -> a -> [a] -> [a]
scanl f a l = lista where lista = a : [ f x y | (x,y) <- zip lista l]