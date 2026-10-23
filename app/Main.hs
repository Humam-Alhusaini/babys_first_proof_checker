module Main (main) where

import System.Environment (getArgs)
import Lexer (tokenize)
import Printer (printTokens)

main :: IO ()
main = do
  args <- getArgs
  case args of
    [path] -> do
      contents <- readFile path
      printTokens (tokenize contents)
    _ -> putStrLn "Usage: babys-first-proof-checker <file>"
