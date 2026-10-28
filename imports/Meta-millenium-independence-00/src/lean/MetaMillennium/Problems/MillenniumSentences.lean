/-
  MetaMillennium.Problems.MillenniumSentences
  The seven Millennium Problem sentences
-/

import MetaMillennium.Core.TheoryAndModel

namespace MetaMillennium.Problems

open MetaMillennium.Core

/-- The Millennium Problems as an enumeration -/
inductive MillenniumProblem where
  | RH       -- Riemann Hypothesis
  | PNP      -- P vs NP
  | NS       -- Navier-Stokes
  | BSD      -- Birch and Swinnerton-Dyer
  | Hodge    -- Hodge Conjecture
  | YM       -- Yang-Mills Mass Gap
  | Poincare -- Poincaré Conjecture (solved)
  deriving Repr, BEq, DecidableEq

/-- Status of each problem -/
inductive ProblemStatus where
  | open_     -- Still open
  | solved    -- Has been solved
  | analyzing -- Under independence analysis
  deriving Repr, BEq

/-- Get the status of a Millennium Problem -/
def MillenniumProblem.status : MillenniumProblem → ProblemStatus
  | .RH => .analyzing
  | .PNP => .analyzing
  | .NS => .analyzing
  | .BSD => .analyzing
  | .Hodge => .analyzing
  | .YM => .analyzing
  | .Poincare => .solved

/-- Convert each problem to its formal sentence -/
def MillenniumProblem.toSentence : MillenniumProblem → Sentence
  | .RH => { id := 1001, repr := "∀s(ζ(s)=0 ∧ 0<Re(s)<1 → Re(s)=1/2)" }
  | .PNP => { id := 1002, repr := "P ≠ NP" }
  | .NS => { id := 1003, repr := "∀(smooth initial data) ∃(global smooth solution)" }
  | .BSD => { id := 1004, repr := "rank(E(ℚ)) = ord_{s=1} L(E,s)" }
  | .Hodge => { id := 1005, repr := "Hodge classes = algebraic cycles (rationally)" }
  | .YM => { id := 1006, repr := "∃(mass gap Δ > 0)" }
  | .Poincare => { id := 1007, repr := "Simply connected 3-manifold ≅ S³" }

/-- Get problem description -/
def MillenniumProblem.description : MillenniumProblem → String
  | .RH => "Riemann Hypothesis: All non-trivial zeros of ζ(s) have Re(s) = 1/2"
  | .PNP => "P vs NP: Is P different from NP?"
  | .NS => "Navier-Stokes: Do smooth global solutions exist?"
  | .BSD => "Birch and Swinnerton-Dyer: rank equals analytic rank"
  | .Hodge => "Hodge Conjecture: Hodge classes are algebraic"
  | .YM => "Yang-Mills: Mass gap exists"
  | .Poincare => "Poincaré Conjecture: Solved by Perelman"

/-- All Millennium sentences -/
def allMillenniumSentences : List Sentence :=
  [.RH, .PNP, .NS, .BSD, .Hodge, .YM, .Poincare].map MillenniumProblem.toSentence

/-- Open problems only -/
def openProblems : List MillenniumProblem :=
  [.RH, .PNP, .NS, .BSD, .Hodge, .YM]

end MetaMillennium.Problems
