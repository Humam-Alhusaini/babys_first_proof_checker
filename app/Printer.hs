module Printer (printTokens) where

import CnfLexer (Token)

printTokens :: [Token] -> IO ()
printTokens tokens = mapM_ print tokens
