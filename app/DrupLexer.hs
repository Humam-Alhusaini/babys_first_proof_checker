module DrupLexer (Token(..), tokenize) where

import Data.Char (isDigit, isSpace)

data Token = Delete | Number Integer
  deriving (Show, Eq)

tokenize :: String -> [Token]
tokenize input = concatMap tokenizeLine (lines input)
  where
    tokenizeLine line =
      case dropWhile isSpace line of
        ('c' : _) -> []
        rest -> map tokenizeWord (words rest)

    tokenizeWord "d" = Delete
    tokenizeWord word
      | validNumber word = Number (read word)
      | otherwise = error ("Unexpected DRUP token: " ++ word)

    validNumber ('-' : digits) = nonemptyDigits digits
    validNumber digits = nonemptyDigits digits
    nonemptyDigits digits = not (null digits) && all isDigit digits
