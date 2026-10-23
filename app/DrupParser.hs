module DrupParser (Step(..), Proof, parse) where

import qualified DrupLexer as Lexer
import CnfParser (Clause)

data Step = Add Clause | Delete Clause
  deriving (Show, Eq)

type Proof = [Step]

-- Reading proof steps does not check whether the additions satisfy RUP.
parse :: [Lexer.Token] -> Proof
parse [] = []
parse (Lexer.Delete : tokens) =
  let (clause, remaining) = parseClause tokens
  in Delete clause : parse remaining
parse tokens =
  let (clause, remaining) = parseClause tokens
  in Add clause : parse remaining

parseClause :: [Lexer.Token] -> (Clause, [Lexer.Token])
parseClause [] = error "DRUP clause must end with 0"
parseClause (Lexer.Number 0 : rest) = ([], rest)
parseClause (Lexer.Number literal : rest) =
  let (literals, remaining) = parseClause rest
  in (literal : literals, remaining)
parseClause (Lexer.Delete : _) = error "Unexpected d inside a DRUP clause"
