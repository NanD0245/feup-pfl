import Data.Char

--EX1
ex1 :: Num a => [a] -> a
ex1 l = sum [x^2 | x<-l] 

--EX2
aprox :: Int -> Double
aprox n = sum [(-1)^x / fromIntegral (2*x + 1) | x<-[0..n]] * 4

aprox2 :: Int -> Double
aprox2 n = sum [(-1)^x / fromIntegral (x + 1)^2 | x<-[0..n]] * 12

--EX#3
dotprod :: [Float] -> [Float] -> Float
dotprod a b = sum [ x * y | (x,y) <- zip a b ]

--EX4
divprop :: Int -> [Int]
divprop a = [x | x<-[1..div a 2], mod a x == 0] 

--EX5
perfeitos :: Int -> [Int]
perfeitos a = [ x | x <- [1..a], sum (divprop x) == x]

--EX6
pitagoricos :: Int -> [(Int,Int,Int)]
pitagoricos a = [(x,y,z) | x<-[1..a],y<-[1..a],z<-[1..a],x^2 + y^2 == z^2]

--EX7
primo :: Int -> Bool 
primo a | length (divprop a) > 1 = False 
        | otherwise = True 

--EX8
binom :: Int -> Int -> Int
binom n k = div (product [1..n]) (product [1..k] * product[1..(n-k)])

pascal :: Int -> [[Int]]
pascal n = [[binom x y | y<-[0..x]] | x<-[0..n]]

--EX9
cifrar :: Int -> String -> String --uppercase letters only
cifrar a s = [  if fromEnum x + a > 90 
                        then (toEnum (fromEnum x + a - 26)::Char) 
                else (if fromEnum x + a < 65 && x /= ' ' 
                        then (toEnum (fromEnum x + a + 26)::Char)
                else (if x == ' ' 
                        then x
                else toEnum (fromEnum x + a)::Char)) | x <- s ]

--EX10
myAnd :: [Bool] -> Bool 
myAnd l | length l == 1 && head l = True
        | not (head l) = False 
        | otherwise = myAnd (tail l)

myOr :: [Bool] -> Bool
myOr l | length l == 1 && not (head l) = False 
       | head l = True 
       | otherwise = myOr (tail l)

myConcat :: [[a]] -> [a]
myConcat [] = []
myConcat (x:xs) = x ++ myConcat xs

myReplicate :: Int -> a -> [a]
myReplicate 0 y = []
myReplicate x y = [y] ++ myReplicate (x-1) y

(!!) :: [a] -> Int -> a 
(!!) l 0 = head l
(!!) l x = (Main.!!) (tail l) (x-1)

myElem :: Eq a => a -> [a] -> Bool 
myElem a [] = False 
myElem a l | head l == a = True 
           | otherwise = myElem a (tail l)

--EX11
myConcatLists :: [[a]] -> [a]
myConcatLists l = [ x | a<-l, x<-a ]

myReplicateLists :: Int -> a -> [a]
myReplicateLists x y = [ y | _ <- [1..x] ]

(!!!) :: [a] -> Int -> a
(!!!) l a = head [ x | (x,y) <- zip l [0..a], y == a]

--EX12
forte :: String -> Bool
forte s = length s >= 8 && any (\x -> fromEnum x < 91 && fromEnum x > 64) s
    && any (\x -> fromEnum x < 123 && fromEnum x > 98) s
    && any (\x -> fromEnum x < 58 && fromEnum x > 47) s

--EX13
mindiv :: Int -> Int
mindiv n = head ([ x | let p = round (sqrt (fromIntegral n)), x <- [2 .. p], mod n x == 0 ] ++ [n])

primo' :: Int -> Bool
primo' n = mindiv n == n

--EX14
deleteDuplicates :: Eq a => a -> [a] -> [a]
deleteDuplicates a l = [x | x <- l, a /= x]

nub :: Eq a => [a] -> [a]
nub [] = []
nub l = head l : nub (deleteDuplicates (head l) (tail l) )

--EX15
myInterperse :: a -> [a] -> [a]
myInterperse x l | length l == 1 = l
                 | otherwise = [head l] ++ [x] ++ myInterperse x (tail l)

--EX16
algarismos :: Int -> [Int]
algarismos x | x == 0 = []
             | otherwise = algarismos (div x 10) ++ [mod x 10]

--EX17
toBits :: Int -> [Int]
toBits x    | x == 0 = []
            | otherwise = toBits (div x 2) ++ [mod x 2]

--EX18
fromBits :: [Int] -> Int 
fromBits [] = 0
fromBits l  | head l == 1 = 2 ^ (length l - 1) + fromBits (tail l)
            | otherwise = fromBits (tail l)

--EX19
mdc :: Int -> Int -> Int 
mdc a b | b == 0 = a
        | otherwise = mdc b (mod a b)

--EX20
myInsert :: Ord a => a -> [a] -> [a]
myInsert x [] = [x]
myInsert x l | head l > x = x : l
             | otherwise = head l : myInsert x (tail l)

--EX21
--minimum :: Ord a => [a] -> a

--delete :: Eq a => a -> [a] -> [a]

--ssort :: Ord a => [a] -> [a]

--EX22
--merge :: Ord a => [a] -> [a] -> [a]
--msort :: Ord a => [a] -> [a]

--EX23
addPoly :: [Int] -> [Int] -> [Int]
addPoly [] l = l
addPoly l [] = l
addPoly l1 l2 = [head l1 + head l2] ++ addPoly (tail l1) (tail l2)

multPoly :: [Int] -> [Int] -> [Int]
multPoly [] l = []
multPoly l [] = []
multPoly l1 l2 = addPoly ([head l1 * y | y<-l2])  (multPoly (tail l1) (0 : l2))