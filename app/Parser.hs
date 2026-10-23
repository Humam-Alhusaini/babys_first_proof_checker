module Parser (Lit, Clause, Formula, parse) where

import Lexer (Token(..))

-- A negative integer represents a negated variable.
type Lit = Integer
type Clause = [Lit]
type Formula = [Clause]

parse :: [Token] -> Formula
parse (Problem : CNF : Number variables : Number clauses : tokens)
  | variables < 0 || clauses < 0 = error "Header counts must be nonnegative"
  | toInteger (length formula) /= clauses = error "Clause count does not match header"
  | otherwise = formula
  where
    formula = parseClauses variables tokens
parse _ = error "Expected header: p cnf <variables> <clauses>"

parseClauses :: Integer -> [Token] -> Formula
parseClauses _ [] = []
parseClauses variables tokens =
  let (clause, remaining) = parseClause variables tokens
  in clause : parseClauses variables remaining

parseClause :: Integer -> [Token] -> (Clause, [Token])
parseClause _ [] = error "Clause must end with 0"
parseClause _ (Number 0 : rest) = ([], rest)
parseClause variables (Number literal : rest)
  | abs literal > variables = error "Variable exceeds the count declared in the header"
  | otherwise =
      let (literals, remaining) = parseClause variables rest
      in (literal : literals, remaining)
parseClause _ _ = error "Expected an integer in a clause"
