module Main (main) where

import System.Environment (getArgs)
import qualified CnfLexer
import qualified CnfParser
import qualified DrupLexer
import qualified DrupParser

main :: IO ()
main = do
  args <- getArgs
  case args of
    [cnfPath, drupPath] -> do
      cnfContents <- readFile cnfPath
      drupContents <- readFile drupPath
      putStrLn "CNF:"
      print (CnfParser.parse (CnfLexer.tokenize cnfContents))
      putStrLn "DRUP:"
      print (DrupParser.parse (DrupLexer.tokenize drupContents))
    _ -> putStrLn "Usage: babys-first-proof-checker <file.cnf> <file.drup>"
