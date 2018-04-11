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
--import System.FileManip


main = do
    args <- getArgs    
    --mapM (hPutStrLn stdout) args
    
    let len = length args
    if len /= 3 && len /= 2 
        then do
            hPutStrLn stdout "copy srcfiles to dest path"
            hPutStrLn stdout "error: number of args is not 3 or 2"
            hPutStrLn stdout "e.g. ycopy [/S] \"d:\\txt\\*.txt\" d:\\a, where /S means recursively"
            return ()
        else do
            
            let recurse = if len == 3 && head args == "/S" then True else False
            
            let 
                first =  head args
                src_path = if len == 3 then head (tail args) else head args        
                dest_path0 = last args      
                dest_path = dest_path0 ++ "\\"

            hPutStrLn stdout src_path
            hPutStrLn stdout dest_path

            if len == 3 && first /= "/S" then
                hPutStrLn stdout "first parameter not unknown"
                else return()

            --files <- listDirectory src_path
            --files <- getDirectoryContents src_path
            --files <- FP.find (False) (recurseR) "d:\\prj"
            --springilize src_path,as it may not be contain  ""
            let src_path' = "\""++src_path ++"\""
            hPutStrLn stdout src_path'

            if recurse 
                then 
                    system ("dir /B /S " ++ src_path' ++ " > dir.txt")
                else
                    system ("dir /B " ++ src_path' ++ " > dir.txt")

            contents <- readFile ("dir.txt")
            let files = lines contents
            mapM ( hPutStrLn stdout) files  

            --let files_spec = filter (isSuffixOf file_fmt) files
            --mapM ( hPutStrLn stdout) files_spec  

            --(\f -> isSuffixOf files_spec f) $ f | f <- files ]
            --[ copyFile src dest_path | src <- files]

            createDirectoryIfMissing True dest_path
            
            mapM_ (\x -> copyFile x (dest_path ++ (reverse $ fst $ span (/='\\') $ reverse x) )) files 
            --result <- copyFile "d:\\prj\\a.txt" "d:\\prj\\b.txt"  



    return ()



isDir :: String -> IO Bool
isDir path = do
    y <- doesFileExist path
    return (not y)

recurseDir :: String -> IO String
recurseDir path internal = do
    y <- isDir path    
    let ret_path =  
        if y 
            then do
                paths <- listDirectory y
                recurseDir paths    --y ++ internal $ y 
            else 
                return (y)
    in ret_path 



