module Main (main) where

import System.Environment (getArgs)

main :: IO ()
main = do
  args <- getArgs
  case args of
    [path] -> do
      contents <- readFile path
      putStr contents
    _ -> putStrLn "Usage: babys-first-proof-checker <file>"
