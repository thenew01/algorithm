module Main where

import Control.Monad
import System.Environment
import System.IO
import System.Directory
--import System.FilePath.Find as FP
import Data.List
import Data.String
import System.Process
import Prelude

import CountEntries

main = do
    args <- getArgs   
    dirs <- countEntriesTrad (head args)    
    let dirs2 = map fst dirs
        counts = map snd dirs
    mapM (putStrLn) dirs2
    print (length counts)
    --mapM (\x ->mapM putStrLn x ) counts
    let lens = map length counts
    mapM print lens
    --mapM (print $ length) counts
    --mapM print counts
   
    --putStrLn 1
    return ()

myAction :: IO String
myAction = do
    a <- getLine
    b <- getLine
    return $ a ++ b