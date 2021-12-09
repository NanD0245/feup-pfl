--EX1 -> [f x | x <- xs, p x]
ex1 :: (a -> a) -> (a -> Bool) -> [a] -> [a]
ex1 f p xs = map f (filter p xs)

--EX2
dec2int :: [Int] -> Int 
dec2int l = foldl (\a b -> a *10 + b) 0 l
--dec2int l = foldl ((+).(*10)) 0 l
-- [2,3,4,5] = 0*10+2 -> 2*10+3 -> 23*10+4 -> 234*10+5

--EX3
zipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith f xs [] = []
zipWith f [] xs = []
zipWith f xs ys = f (head xs) (head ys) : Main.zipWith f (tail xs) (tail ys)

--EX4
insert :: Ord a => a -> [a] -> [a]
insert x [] = [x]
insert x l  | head l > x = x : l
            | otherwise = head l : insert x (tail l)

isort :: Ord a => [a] -> [a]
isort l = foldr (\a b -> insert a b) [] l

--EX5
maximum :: Ord a => [a] -> a
maximum l = Prelude.foldl1 (\a b -> if a > b then a else b) l

minimum :: Ord a => [a] -> a
minimum l = Prelude.foldl1 (\a b -> if a < b then a else b) l

foldl1 :: (a -> a -> a) -> [a] -> a
foldl1 f l = foldl f (head l) (tail l)

foldr1 :: (a -> a -> a) -> [a] -> a
foldr1 f l = foldr f (last l) (init l)

--EX6
mdc :: Int -> Int -> Int
mdc a b = fst (until (\(x,y) -> y == 0) (\(x,y) -> (y,mod x y)) (a,b))

--EX7
(++) :: [a] -> [a] -> [a]
(++) a b = foldr (\c d -> c : d) b a

myconcat :: [[a]] -> [a]
myconcat l = foldr (\a b -> a Prelude.++ b) [] l

myreverseright :: [a] -> [a]
myreverseright l = foldr (\a b -> b Prelude.++ [a]) [] l

myreverseleft :: [a] -> [a]
myreverseleft l = foldl (\a b -> b : a) [] l

elem :: Eq a => a -> [a] -> Bool
elem x l = any (\n -> n==x) l

--EX8
palavras :: String -> [String]
palavras s  | takeWhile (/= ' ') s == s = [s]
            | otherwise = takeWhile (/= ' ') s : palavras (tail (dropWhile (/= ' ') s))

despalavras :: [String] -> String 
despalavras [] = ""
despalavras l = tail (foldr (\a b ->" " Prelude.++ a Prelude.++ b) "" l)

--EX9
scanl :: (a -> b -> a) -> a -> [b] -> [a]
scanl f a [] = [a]
scanl f a l = a : Main.scanl f (f a (head l)) (tail l)