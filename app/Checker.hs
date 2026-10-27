module Checker (unitPropagate) where

import CnfParser (Formula, Clause, Lit)
import DrupParser ()
import Data.Function ((&))
import Text.Printf (FormatAdjustment)

unitPropagate :: Formula -> Formula
unitPropagate formula =
  case firstUnit formula of
    Nothing  -> formula
    Just lit -> unitPropagate (unitClausePropagate lit formula)

firstUnit :: Formula -> Maybe Lit
firstUnit [] = Nothing
firstUnit ([] : clauses) = firstUnit clauses
firstUnit ([lit] : _) = Just lit
firstUnit (_ : clauses) = firstUnit clauses

unitClausePropagate :: Lit -> Formula -> Formula
unitClausePropagate lit =
  map (filter (/= negateLit lit))
    . filter (notElem lit)

negateLit :: Lit -> Lit
negateLit = negate
