-- EX1
testaTriangulo :: Float -> Float -> Float -> Bool
testaTriangulo a b c =  if a+b>c && a+c>b && b+c>a then True else False;

--EX2
s :: Float -> Float -> Float -> Float
s a b c = (a+b+c)/2

areaTriangulo :: Float -> Float -> Float -> Float
areaTriangulo a b c = sqrt ((s a b c)*(s a b c - a)*(s a b c - b)*(s a b c - c))

--EX3
metades :: [a] -> ([a],[a])
metades l = (take (div (length l) 2) l, drop (div (length l) 2) l);

--EX4
  --a)
myLast :: [a] -> a
myLast l = head (drop (length l - 1) l);
--myLast l = head (reverse l);

  --b)
myInit :: [a] -> [a]
myInit l = take (length l - 1) l;

--EX5
  --a)
binom :: Integer -> Integer -> Integer
binom n k = div (product [1..n]) (product [1..k] * product[1..(n-k)])

  --b)
binom_optimized :: Integer -> Integer -> Integer
binom_optimized n k | k < (n - k) = div (product [(n - k + 1)..n]) (product [1..k])
                    | otherwise = div (product [(k+1)..n]) (product [1..(n-k)])

--EX6
raizes :: Float -> Float -> Float -> Maybe (Float, Float)
raizes a b c = if (b*b - 4*a*c < 0) then Nothing else
  Just ((-b + sqrt(b*b - 4*a*c)) / (2*a), (-b - sqrt(b*b - 4*a*c)) / (2*a))

{-EX7
  a) [Char] ; String
  b) (Char,Char,Char)
  c) [(Bool,Char)]
  d) ([Bool],[Char])
  e) [[a] -> [a]]
  f) id:: a -> a ; not :: Bool -> Bool
     [Bool -> Bool]
-}

{-EX8
  a) [a] -> a
  b) (a,b) -> (b,a)
  c) a -> b -> (a,b)
  d) Num a => a -> a
  e) Fraction a => a -> a
  f) Char -> Bool
  g) Ord a => a -> a -> a -> Bool
  h) Eq a => [a] -> Bool
  i) (a -> a) -> a -> a
-}


--EX9
  --s/guardas
classifica :: Int -> String
classifica a = if a <= 9 then "reprovado" else (
              if a <= 12 then "suficiente" else (
              if a <= 15 then "bom" else (
              if a <= 18 then "muito bom" else (
              if a <= 20 then "muito bom com distinção" else "invalido"))));
  --c/guardas
classifica_guardas :: Int -> String
classifica_guardas a  | a <= 9 = "reprovado"
              | a <= 12 = "suficiente"
              | a <= 15 = "bom"
              | a <= 18 = "muito bom"
              | a <= 20 = "muito bom com distinção"
              | otherwise = "inválido"

--EX10
--IMC = peso/altura²
imc :: Float -> Float -> Float
imc p a = p / (a * a)

classifica_peso :: Float -> Float -> String
classifica_peso p a   | imc p a < 18.5 = "baixo peso"
                      | imc p a < 25 = "peso normal"
                      | imc p a < 30 = "excesso de peso"
                      | otherwise = "obesidade"

--EX11
  --a)
max3, min3 :: Ord a => a -> a -> a -> a
max3 a b c  | a >= b && a >= c = a
            | b >= c && b >= a = b
            | otherwise = c

min3 a b c  | a <= b && a <= c = a
            | b <= c && b <= a = b
            | otherwise = c

  --b)
max3_preludio, min3_preludio :: Ord a => a -> a -> a -> a
max3_preludio a b c = max (max a b) c
min3_preludio a b c = min (min a b) c

--EX12
xor :: Bool -> Bool -> Bool
xor a b = a /= b

--EX13
safetail :: [a] -> [a]
safetail l = if length l == 0 then [] else tail l;

safetail_guardas :: [a] -> [a]
safetail_guardas l  | length l == 0 = []
                    | otherwise = tail l

safetail_padroes :: [a] -> [a]
safetail_padroes l = case l of
  [] -> []
  _ -> tail l


--EX14

curta :: [a] -> Bool
curta l = if length l >= 0 && length l <= 3 then True else False;

tamanho :: [a] -> Int
tamanho [] = 0;
tamanho l = 1 + tamanho (drop 1 l);

myCurta l | tamanho l >= 0 && tamanho l <= 3 = True
        | otherwise = False

--EX15
middle3 :: Ord a => a -> a -> a -> a
middle3 a b c | b <= a && c >= a = a
              | b >= a && c <= a = a
              | a <= b && c >= b = b
              | a >= b && c <= b = b
              | a <= c && b >= c = c
              | a >= c && b <= c = c

  --a)
mediana :: Num a => a -> a -> a -> a
mediana a b c = middle3 a b c

  --b)
medianaB :: Num a => a -> a -> a -> a
medianaB a b c = a+b+c - min3 a b c - (max3 a b c)



--EX16
converte1 :: Int -> String
converte1 a = if div (mod a 100) 10 == 1 then "" else case mod a 10 of
  0 -> ""
  1 -> "um"
  2 -> "dois"
  3 -> "tres"
  4 -> "quatro"
  5 -> "cinco"
  6 -> "seis"
  7 -> "sete"
  8 -> "oito"
  9 -> "nove"

converte2 :: Int -> String
converte2 a = case div (mod a 100) 10 of
  0 -> ""
  1 -> case mod a 100 of
    10 -> "dez"
    11 -> "onze"
    12 -> "doze"
    13 -> "treze"
    14 -> "catorze"
    15 -> "quinze"
    16 -> "dezasseis"
    17 -> "dezassete"
    18 -> "dezoito"
    19 -> "dezanove"
  2 -> "vinte"
  3 -> "trinta"
  4 -> "quarenta"
  5 -> "cinquenta"
  6 -> "sessenta"
  7 -> "setenta"
  8 -> "oitenta"
  9 -> "noventa"

converte3 :: Int -> String
converte3 a = case div (mod a 1000) 100 of
  0 -> ""
  1 -> if mod a 1000 == 100 then "cem" else "cento"
  2 -> "duzentos"
  3 -> "trezentos"
  4 -> "quatrocentos"
  5 -> "quinhentos"
  6 -> "seiscentos"
  7 -> "setecentos"
  8 -> "oitcentos"
  9 -> "novecentos"

converte_3_algarismos :: Int -> String
converte_3_algarismos a =  converte3 a ++ (if div a 100 == 0 || div (mod a 100) 10 == 0 then "" else " e ") ++
              converte2 a ++ (if div a 10 == 0 || mod a 10 == 0 || div (mod a 100) 10 == 1 then "" else " e ") ++
              converte1 a;

converte :: Int -> String
converte a  | a < 0 || a >= 1000000 = "numero invalido (aceites: 1-999999)"
            | a == 1000 = "mil"
            | div a 1000 > 0 = converte_3_algarismos (div a 1000) ++ (if mod a 1000 == 0 then " mil" else " mil ") ++ converte_3_algarismos (mod a 1000)
            | otherwise = converte_3_algarismos a



--main = do {
--  print(testaTriangulo 0 0 0);
--  }
