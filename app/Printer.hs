module Printer (printTokens) where

import Lexer (Token)

printTokens :: [Token] -> IO ()
printTokens tokens = mapM_ print tokens
