
import System.Random

--import qualified Control.Monad.Writer as M
--import Control.Monad.Instances
--import Control.Monad
import Control.Monad.Trans.State.Lazy

-- file: ch03/BookStore.hs
data Customer = Customer {
      customerID      :: Int
    , customerName    :: String
    , customerAddress :: String
} deriving (Show)

customer1 = Customer 271828 "J.R. Hacker"
            "255 Syntax Ct"

--type customer1



-- file: ch03/BookStore.hs
customer2 = Customer {
              customerID = 271828
            , customerAddress = "1048576 Disk Drive"
            , customerName = "Jane Q. Citizen"
            }


zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' _ [] _ = []
zipWith' _ _ [] = []
zipWith' f (x:xs) (y:ys) = f x y : zipWith' f xs ys


add a b = a + b


--data CoolBool = CoolBool { getCoolBool :: Bool }
newtype CoolBool = CoolBool { getCoolBool :: Bool }

helloMe :: CoolBool -> String
helloMe (CoolBool _) = "hello"

{-
instance Applicative ZipList where
  pure x = ZipList (repeat x)
  ZipList fs <*> ZipList xs = ZipList (zipWith (\f x -> f x) fs xs)
-}


newtype Product a = Product { getProduct :: a }
  deriving (Eq, Ord, Read, Show, Bounded)

instance Num a => Monoid (Product a) where
  mempty = Product 1
  Product x `mappend` Product y = Product (x * y)

newtype Sum a = Sum { getSum :: a }
  deriving (Eq, Ord, Read, Show, Bounded)

instance Num a => Monoid (Sum a) where
  mempty = Sum 1
  Sum x `mappend` Sum y = Sum (x + y)

newtype Any = Any { getAny :: Bool }
  deriving (Eq, Ord, Read, Show, Bounded)

instance Monoid Any where
  mempty = Any False
  Any x `mappend` Any y = Any (x || y)

newtype All = All { getAll :: Bool }
  deriving (Eq, Ord, Read, Show, Bounded)

instance Monoid All where
  mempty = All True
  All x `mappend` All y = All (x && y)


lengthCompare :: String -> String -> Ordering
{-
lengthCompare x y = let a = length x `compare` length y
                        b = x `compare` y
                    in if a == EQ then b else a
-}
lengthCompare x y = (length x `compare` length y) `mappend` (x `compare` y)


lengthCompare' :: String -> String -> Ordering
lengthCompare' x y = (length x `compare` length y) `mappend`
                    (vowels x `compare` vowels y) `mappend`
                    (x `compare` y)
                    where vowels = length . filter (`elem` "aeiou")


--return (0,0) >>= landRight 2 >>= landLeft 2 >>= landRight 2

{-
newtype Writer' w a = Writer' { runWriter :: (a, w) }

instance (M.Monoid w) => M.Monad (Writer' w) where
  return x = Writer' (x, mempty)
  (Writer' (x,v)) >>= f = let (Writer' (y, v')) = f x in Writer' (y, v `mappend` v')


logNumber :: Int -> Writer' [String] Int
logNumber x = Writer' (x, ["Got number: " ++ show x])

multWithLog :: Writer' [String] Int
multWithLog = do
  a <- logNumber 3
  b <- logNumber 5
  return (a*b)
-}


addStuff :: Int -> Int
addStuff = do
  a <- (*2)
  b <- (+10)
  return (a+b)


addStuff' :: Int -> Int
addStuff' x = let
  a = (*2) x
  b = (+10) x
  in a+b


type Stack = [Int]
{-
pop :: Stack -> (Int,Stack)
pop (x:xs) = (x,xs)

push :: Int -> Stack -> ((),Stack)
push a xs = ((),a:xs)


stackManip :: Stack -> (Int, Stack)
stackManip stack = let
  ((),newStack1) = push 3 stack
  (a ,newStack2) = pop newStack1
  in pop newStack2
-}

--newtype State s a = State { runState :: s -> (a,s) }
{-
instance Monad (State s) where
  return x = State $ \s -> (x,s)
  (State h) >>= f = State $ \s -> let (a, newState) = h s
                                      (State g) = f a
                                  in g newState
pop :: State Stack Int
pop = State $ \(x:xs) -> (x,xs)

push :: Int -> State Stack ()
push a = State $ \xs -> ((),a:xs)

stackManip' = do
  push 3
  a <- pop
  pop
-}

{-
randomSt :: (RandomGen g, Random a) => state g a
randomSt = state random

threeCoins :: State StdGen (Bool,Bool,Bool)
threeCoins = do
  a <- randomSt
  b <- randomSt
  c <- randomSt
  return (a,b,c)
  -}

{-
instance (Error e) => Monad (Either e) where
  return x = Right x
  Right x >>= f = f x
  Left err >>= f = Left err
  fail msg = Left (strMsg msg)
  -}


binSmalls :: Int -> Int -> Maybe Int
binSmalls acc x
  | x > 9 = Nothing
  | otherwise = Just (acc + x)