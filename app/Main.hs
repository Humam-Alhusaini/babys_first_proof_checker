module Main (main) where

import System.Environment (getArgs)
import CnfLexer (tokenize)
import CnfParser (parse)
import qualified DrupLexer
import qualified DrupParser

main :: IO ()
main = do
  args <- getArgs
  case args of
    ["--drup", path] -> do
      contents <- readFile path
      print (DrupParser.parse (DrupLexer.tokenize contents))
    [path] -> do
      contents <- readFile path
      print (parse (tokenize contents))
    _ -> putStrLn "Usage: babys-first-proof-checker [--drup] <file>"
