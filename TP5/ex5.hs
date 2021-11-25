import Stack

--EX1
parent :: String -> Bool 
parent s = checkStack s empty

checkStack :: String -> Stack Char -> Bool 
checkStack [] stk = isEmpty stk
checkStack (x:xs) stk   | x == '(' = checkStack xs (push x stk)
                        | x == '[' = checkStack xs (push x stk)
                        | x == ')' = top stk == '(' && checkStack xs (pop stk)
                        | x == ']' = top stk == '[' && checkStack xs (pop stk)
                        | otherwise = checkStack xs stk

--EX2
calc :: Stack Float -> String -> Stack Float 
calc stk "" = stk;
calc stk s  | s == "+" = push (top stk + top (pop stk)) (pop (pop stk)) 
            | s == "-" = push (top stk - top (pop stk)) (pop (pop stk)) 
            | s == "*" = push (top stk * top (pop stk)) (pop (pop stk)) 
            | s == "/" = push (top stk / top (pop stk)) (pop (pop stk))
            | otherwise = push (read s::Float) stk

calcular :: String -> Float 
calcular s = top (calcularAux empty (reverse (words s)))

calcularAux :: Stack Float -> [String] -> Stack Float
calcularAux stk [] = stk
calcularAux stk s = calc (calcularAux stk (tail s)) (head s)

--EX3
    --Ver Slides

--EX4
data Set a = Empty | Node a (Set a) (Set a)

empty :: Set a
empty = Empty

insert :: Ord a => a -> Set a -> Set a
insert a Empty = Node a Empty Empty
insert a (Node x esq dir)   | a < x = Node x (insert a esq) dir
                            | a > x = Node x esq (insert a dir)
                            | a == x = Node x esq dir

member :: Ord a => a -> Set a -> Bool
member a Empty = False 
member a (Node x esq dir)   | a < x = member a esq
                            | a > x = member a dir
                            | a == x = True 

--EX5
listar :: Set a -> [a]
listar Empty = []
listar (Node x esq dir) = listar esq ++ [x] ++ listar dir

union :: Ord a => Set a -> Set a -> Set a
union a b = fst (until (\(x,y) -> null y) (\(x,y) -> (insert (head y) x, tail y)) (a, listar b))

intersect :: Ord a => Set a -> Set a -> Set a
intersect a b = insertLista l empty where l = [x | x <- listar a,  member x b]

difference :: Ord a => Set a -> Set a -> Set a
difference a b = insertLista (l1 ++ l2) empty where l1 = [x | x <- listar a, not (member x b)] 
                                                    l2 = [x | x <- listar b, not (member x a)]

insertLista :: Ord a => [a] -> Set a -> Set a
insertLista [] a = a
insertLista (x:xs) a = insertLista xs (insert x a) 


--EX6
data Map k v = Vazio | No k v (Map k v) (Map k v)

emptyMap :: Map k v 
emptyMap = Vazio

insertMap :: Ord k => k -> v -> Map k v  -> Map k v 
insertMap k a Vazio = No k a Vazio Vazio
insertMap k a (No key x esq dir)    | k < key = No key x (insertMap k a esq) dir
                                    | k > key = No key x esq (insertMap k a dir)
                                    | k == key = No key x esq dir

lookup :: Ord k => k -> Map k a -> Maybe a
lookup k Vazio = Nothing
lookup k (No key x esq dir) | k == key = Just x
                            | k < key = Main.lookup k esq
                            | k > key = Main.lookup k dir

--EX7