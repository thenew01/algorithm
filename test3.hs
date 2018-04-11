--module test3(--aaa,describeList, describeList2) where


import Data.List
import qualified Data.Set as Set
import qualified Data.Map as Map

main = putStrLn "Hello World"

add a b = a + b

x = 1


--aaa = map (++ "@") ["BIFF","BANG","POW"]

{--print(aaa)--}

{--map (+ 1) [1,2,3]--}

length1 :: [a] -> Int
length1 [ ] = 0
length1 (x:xs) = 1 + length xs

zip' :: [a] -> [b] -> [(a, b)]
zip' [] ys = []
zip' xs [] = []
zip' (x:xs) (y:ys) = (x, y) : zip xs ys


describeList :: [a] -> String
describeList xs = "The list is " ++ case xs of
  [] -> "empty."
  [x] -> "a singleton list."
  xs -> "a longer list."

describeList2 :: [a] -> String
describeList2 xs = "The list is " ++ what xs
 where what [] = "empty."
       what [x] = "a singleton list."
       what xs = "a longer list."

{-
filter1 :: (a -> Bool) -> [a] -> [a]
filter1 _ [] = []
filter1 p (x:xs) 
 | p x = x:filter1 p xs
 | otherwise = filter1 p xs
-}

-- max x y returns the largest of the two
max :: Ord a => a -> a -> a
max x y
  | x > y = x
  | otherwise = y

max' :: (Ord a) => a -> a -> a
max' a b | a > b = a | otherwise = b


bmiTell :: (RealFloat a) => a -> String
bmiTell bmi
  | bmi <= 18.5 = "You're underweight, you emo, you!"
  | bmi <= 25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"
  | bmi <= 30.0 = "You're fat! Lose some weight, fatty!"
  | otherwise = "You're a whale, congratulations!"


bmiTell0 :: (RealFloat a) => a -> a -> String
bmiTell0 weight height
 | weight / height ^ 2 <= 18.5 = "You're underweight, you emo, you!"
 | weight / height ^ 2 <= 25.0 = "You're supposedly normal. Pffft, I bet you're "
 | weight / height ^ 2 <= 30.0 = "You're fat! Lose some weight, fatty!"
 | otherwise = "You're a whale, congratulations!"


bmiTell1 :: (RealFloat a) => a -> a -> String
bmiTell1 weight height
    | bmi <= 18.5 = "You're underweight, you emo, you!"
    | bmi <= 25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"
    | bmi <= 30.0 = "You're fat! Lose some weight, fatty!"
    | otherwise = "You're a whale, congratulations!"
    where bmi = weight / height ^ 2

    
bmiTell2 :: (RealFloat a) => a -> a -> String
bmiTell2 weight height
    | bmi <= skinny = "You're underweight, you emo, you!"
    | bmi <= normal = "You're supposedly normal. Pffft, I bet you're ugly!"
    | bmi <= fat = "You're fat! Lose some weight, fatty!"
    | otherwise = "You're a whale, congratulations!"
   where bmi = weight / height ^ 2
         skinny = 18.5
         normal = 25.0
         fat = 30.0


initials :: String -> String -> String
initials firstname lastname = f ++ ". " ++ l ++ "."
  where (f) = firstname
        (l) = lastname

calcBmis :: (RealFloat a) => [(a, a)] -> [a]
calcBmis xs = [bmi w h | (w, h) <- xs]
 where bmi weight height = weight / height ^ 2


calcBmis2 :: (RealFloat a) => [(a, a)] -> [a]
calcBmis2 xs = [bmi | (w, h) <- xs, let bmi = w / h ^ 2]
 
cylinder :: (RealFloat a) => a -> a -> a
cylinder r h =
 let sideArea = 2 * pi * r * h
     topArea = pi * r ^2
 in sideArea + 2 * topArea
 


head' :: [a] -> a
head' xs = case xs of [] -> error "No head for empty lists!"
                      (x:_) -> x


--Main.head' [1,2,3]

--[x:xs | True <- (x > 3), xs = [1,1,2,4,5,3]




search' :: (Eq a) => [a] -> [a] -> Bool
search' needle haystack =
	let nlen = length needle
	in foldl (\acc x -> if (take nlen x) == needle then True else acc) False (tails haystack)

--replicate 100 (product (map (*3) (zipWith max [1,2,3,4,5] [4,5,6,7,8])))



phoneBook = [("betty","555-2938") ,("betty","555-1"), ("betty","555-2"), ("bonnie","452-2928") ,("patsy","493-2928") ,("lucille","205-2928") ,("wendy","939-8282") ,("penny","853-2492") ]

phoneBookToMap :: (Ord k) => [(k, String)] -> Map.Map k String  
phoneBookToMap xs = Map.fromListWith (\number1 number2 -> number1 ++ ", " ++ number2) xs 

phoneBookToMap' :: (Ord k) => [(k, a)] -> Map.Map k [a]  
phoneBookToMap' xs = Map.fromListWith (++) $ map (\(k,v) -> (k,[v])) xs  


--Set.filter odd $ Set.fromList [3,4,5,6,7,2,3,4]  
--Set.map (+1) $ Set.fromList [3,4,5,6,7,2,3,4]  

--data Either a b = Left a | Right b deriving (Eq, Ord, Read, Show)  
data LockerState = Taken | Free deriving (Show, Eq)
type Code = String
type LockerMap = Map.Map Int (LockerState, Code)

lockerLookup :: Int -> LockerMap -> Either String Code
lockerLookup lockerNumber map =
	case Map.lookup lockerNumber map of
		Nothing -> Left $ "Locker number " ++ show lockerNumber ++ " doesn't exist!"
		Just (state, code) -> if state /= Taken
								then Right code
								else Left $ "Locker " ++ show lockerNumber ++ " is already taken!"  

lockers :: LockerMap
lockers = Map.fromList
	[(100,(Taken,"ZD39I"))
	,(101,(Free,"JAH3I"))
	,(103,(Free,"IQSA9"))
	,(105,(Free,"QOTSA"))
	,(109,(Taken,"893JJ"))
	,(110,(Taken,"99292"))
	]
								
data Tree a = EmptyTree | Node a (Tree a) (Tree a) deriving (Show, Read, Eq)

singleton :: a -> Tree a
singleton x = Node x EmptyTree EmptyTree
treeInsert :: (Ord a) => a -> Tree a -> Tree a
treeInsert x EmptyTree = singleton x
treeInsert x (Node a left right)
	| x == a = Node x left right
	| x < a = Node a (treeInsert x left) right
	| x > a = Node a left (treeInsert x right)

treeElem :: (Ord a) => a -> Tree a -> Bool
treeElem x EmptyTree = False
treeElem x (Node a left right)
	| x == a = True
	| x < a = treeElem x left
	| x > a = treeElem x right