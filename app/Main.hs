module Main (main) where

import System.Environment (getArgs)
import Lexer (tokenize)
import Parser (parse)

main :: IO ()
main = do
  args <- getArgs
  case args of
    [path] -> do
      contents <- readFile path
      print (parse (tokenize contents))
    _ -> putStrLn "Usage: babys-first-proof-checker <file>"
