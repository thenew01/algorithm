module Main where

import Data.List
import System.Directory
import Data.String
import Control.Monad
import Prelude
import System.Environment

--import Control.Monad (filterM)
--import System.Directory --(Permissions(..), getModificationTime, getPermissions)
--import System.Time (ClockTime(..))
import Data.Time.Clock
import System.FilePath ((</>),takeExtension)
import Control.Exception (bracket, handle)
import System.IO (IOMode(..), hClose, hFileSize, openFile)
import Data.Foldable

-- the function we wrote earlier
--import RecursiveContents (getRecursiveContents)


main = do --putStrLn "Hello World"
	args <- getArgs
	files <- betterFind (sizeP `greaterP` 3) (head args)
	--(head getArgs) >>= betterFind (sizeP `equalP` 1024)
	mapM print files
	return ()

{-
bmiTell :: (RealFloat a) => a->String
bmiTell bmi
	| bmi <= 18.5 = "You're underweight, you emo, you!"
	| bmi <= 25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"
	| bmi <= 30.0 = "You're fat! Lose some weight, fatty!"
	| otherwise = "You're a whale, congratulations!"


--bmiTell 19



search' :: (Eq a) => [a] -> [a] -> Bool
search' needle haystack =
 	let nlen = length needle
	in foldl (\acc x -> if take nlen x == needle then True else acc) False (tails haystack)
-}

{-
main path = do
	--dir <- getArgs
	--let path = head dir 
 	contents <- listDirectory path    
    files <- filterM doesFileExist contents
	mapM putStrLn files 
	return()
-}
--xs >>= f = concat (map f xs)
--[1,2] >>= \n -> ['a','b'] >>= \ch -> return (n,ch)
 --map (\m -> map (\n->[(m,n)]) ['a','b']) [1,2]


{-
data CMaybe a = CNothing | CJust Int a deriving (Show)

instance Functor CMaybe where
	fmap f CNothing = CNothing
	fmap f (CJust counter x) = CJust (counter+1) (f x)

	-}

type Predicate =  FilePath      -- path to directory entry
               -> Permissions   -- permissions
               -> Maybe Integer -- file size (Nothing if not file)
               -> UTCTime     -- last modified
               -> Bool
   
betterFind :: Predicate -> FilePath -> IO [FilePath]
betterFind p path = do getRecursiveContents  path >>= filterM check
	--files <- getRecursiveContents path
	--files2 <- filterM check files
	--return (files2)
	where check name = do
		perms <- getPermissions name
		--size <- getFileSize name
		size <- getFileSize name
		modified <- getModificationTime name
		return (p name perms size modified)
            -- -->(sizeP `greaterP` 1024) name perms size modified 
            -- -->(sizeP `liftP (>)` 1024) name perms size modified
            -- -->liftP (>) sizeP 1024 name perms size modified
            --    liftP q f k w x y z = f w x y z `q` k

getRecursiveContents :: FilePath -> IO [FilePath]
getRecursiveContents topdir = do
    names <- getDirectoryContents topdir
    let properNames = filter (`notElem` [".", ".."]) names
    paths <- forM properNames $ \name -> do
        let path = topdir </> name
        isDirectory <- doesDirectoryExist path
        if isDirectory
            then getRecursiveContents path
        else return [path]	
    return (concat paths)

getFileSize :: FilePath -> IO (Maybe Integer)
getFileSize path = bracket (openFile path ReadMode) hClose $ \h -> do
    size <- hFileSize h
    return (Just size)

type InfoP a =  FilePath        -- path to directory entry
             -> Permissions     -- permissions
             -> Maybe Integer   -- file size (Nothing if not file)
             -> UTCTime       -- last modified
             -> a

pathP :: InfoP FilePath
pathP path _ _ _ = path

sizeP :: InfoP Integer
sizeP _ _ (Just size) _ = size
sizeP _ _ Nothing     _ = -1

equalP :: (Eq a) => InfoP a -> a -> InfoP Bool
equalP f k = \w x y z -> f w x y z == k

equalP' :: (Eq a) => InfoP a -> a -> InfoP Bool
equalP' f k w x y z = f w x y z == k

liftP :: (a -> b -> c) -> InfoP a -> b -> InfoP c
liftP q f k w x y z = f w x y z `q` k

greaterP, lesserP :: (Ord a) => InfoP a -> a -> InfoP Bool
greaterP = liftP (>)
lesserP = liftP (<)

