{-EX1
a) ["abc",[],"dce"]

b) [[2],[],[3],[4]]

c) 10

d) [2,4,6,8]

e) [1,0,-1,-2,-3]

f) [6,7,8,9,10]

g) [4,5,6]

h) [2 * x * (-1)^x | x <- [1..]]

i) 24

j) f :: [a] -> a

k) ([Bool], [Char]) ou ([Bool], String)

l) aval :: E a -> (a -> Bool) -> (Bool -> Bool -> Bool) -> Bool

m) foldr (++) [] :: ([a] -> [a] -> [a]) -> [a] -> [[a]] -> [a] ou Foldable a -> (a -> a -> a) -> a -> [a] -> a
-}

--EX2

aprov :: [Int] -> [Char]
aprov l = [if x >= 15 then 'A' else 'R' | x <- l]

injust :: [Int] -> Int
injust l = length [ 1 | x <- l, x >= 10 && x < 15]

--EX3

repete :: a -> [[a]]
repete a = lista where lista = [] : [ a : x | x <- lista]

--EX4

maximo::  IO ()
maximo = maximoAux 0

maximoAux ::  Int -> IO ()
maximoAux m = do x <- getLine
                 let n = read x in
                    if n == 0 then print m
                    else maximoAux (max n m)

maximo1 :: IO()
maximo1 = do xs <- maximoAux1
             print (maximum xs)

maximoAux1 :: IO [Int]
maximoAux1 = do x <- getLine
                let n = read x in
                    if n == 0 then return []
                    else do xs <- maximoAux1
                            return (n:xs)
                        

--EX5

compLRec, compLSup :: [a->a] -> a -> a
compLRec [] x = x
compLRec fs x = compLRec (init fs) (last fs x)

compLSup l x = foldr (\f x -> f x) x l

--EX6

data Arv a = Vazia | No a (Arv a) (Arv a)

soma :: Num a => Arv a -> a
soma Vazia = 0
soma (No a esq dir) = a + soma esq + soma dir 

foldtree :: (a -> b -> b -> b) -> b -> Arv a -> b
foldtree f x Vazia = x
foldtree f x (No a esq dir) = f a (foldtree f x esq) (foldtree f x dir) 






