module CnfLexer (Token(..), tokenize) where

import Data.Char (isDigit, isSpace)

data Token
  = Problem
  | CNF
  | Number Integer
  deriving (Show, Eq)

tokenize :: String -> [Token]
tokenize input = concatMap tokenizeLine (lines input)
  where
    tokenizeLine line =
      case dropWhile isSpace line of
        ('c' : _) -> []
        rest -> map tokenizeWord (words rest)

    tokenizeWord "p" = Problem
    tokenizeWord "cnf" = CNF
    tokenizeWord word
      | validNumber word = Number (read word)
      | otherwise = error ("Unexpected token: " ++ word)

    validNumber ('-' : digits) = nonemptyDigits digits
    validNumber digits = nonemptyDigits digits
    nonemptyDigits digits = not (null digits) && all isDigit digits
