{-EX1
a) [[],[5,2]]

b) [1,4,7,10]

c) 11

d) [0,3,6,9]

e) [1,3,5,7,2]

f) [(1,3), (2,2)]

g) [1,4..31] ou [x * 3 + 1 | x <- [0..10]]

h) 80

i) f :: [a] -> a 

j) [[Int] -> Int]

k) ntoI :: N -> Int ou ntoI :: Num a => N -> a

i) Ord a => a -> [a] -> [Bool]
-}

--EX2

maioresQ :: Ord a => [a] -> a -> [a]
maioresQ l a = [x | x <- l , x > a]

tamanhoS :: [String] -> [Int]
tamanhoS l = [length s | s <- l]

--EX3

--EX4

tabuada :: IO ()
tabuada = do 
            x <- getLine 
            let n = read x 
                l = tabuadaAux n 10 in
             putStr (concat [show x ++ "\n" | x <- l])


tabuadaAux :: Int -> Int -> [Int]
tabuadaAux n c  | c == -1 = []
                | otherwise = tabuadaAux n (c-1) ++ [n*c]

tabuadaSeq :: IO [()]
tabuadaSeq = do 
                x <- getLine 
                let n = read x in
                  sequence (tabuadaSeqAux n 10)
                    
tabuadaSeqAux :: Int -> Int -> [IO ()]
tabuadaSeqAux n c   | c == -1 = []
                    | otherwise = tabuadaSeqAux n (c-1) ++ [print (n*c)]

--EX5

listaInf :: [Int]
listaInf = lista where lista = 0 : [x + y | (x,y) <- zip lista [1..]]

--EX6

data Arv a = Vazia | No a (Arv a) (Arv a)

listar :: Arv a -> [a]
listar Vazia = []
listar (No a esq dir) = listar esq ++ [a] ++ listar dir

simetrica :: Arv a -> Arv a
simetrica Vazia = Vazia
simetrica (No a esq dir) = No a (simetrica dir) (simetrica esq)
                