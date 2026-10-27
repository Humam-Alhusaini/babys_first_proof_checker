module Main (main) where

import System.Environment (getArgs)
import qualified CnfLexer
import qualified CnfParser
import qualified DrupLexer
import qualified DrupParser
import qualified Checker
import Data.Function ((&))
import Checker (unitPropagate)

main :: IO ()
main = do
  args <- getArgs
  case args of
    [cnfPath] -> do
      cnfContents <- readFile cnfPath
      let cnf = CnfLexer.tokenize cnfContents & CnfParser.parse
      putStrLn "CNF:"
      print cnf
      putStrLn "Propagated CNF:"
      unitPropagate cnf & print
    [cnfPath, drupPath] -> do
      cnfContents <- readFile cnfPath
      drupContents <- readFile drupPath
      let cnf = CnfLexer.tokenize cnfContents & CnfParser.parse
      let drup = DrupLexer.tokenize drupContents & DrupParser.parse
      putStrLn "CNF:"
      print cnf
      putStrLn "DRUP:"
      print drup
      putStrLn "Propagated CNF:"
      unitPropagate cnf & print
    _ -> putStrLn "Usage: babys-first-proof-checker <file.cnf> <file.drup>"
