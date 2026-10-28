/-
  Pairing of RH and P vs NP for analysis.
-/

import Millennium.Zeta.Basic
import Millennium.Complexity.Classes

namespace Millennium.Framework

open Millennium.Zeta
open Millennium.Complexity

/-- A pairing of the two problems -/
structure ProblemPair where
  rhStatement : Prop
  pnpStatement : Prop

/-- The actual problem pair -/
def MillenniumPair : ProblemPair :=
  { rhStatement := RiemannHypothesis,
    pnpStatement := P_not_equals_NP }

/-- A potential equivalence between problems -/
def Equivalence (p : ProblemPair) : Prop :=
  p.rhStatement ↔ p.pnpStatement

/-- A potential implication -/
def RHImpliesPNP (p : ProblemPair) : Prop :=
  p.rhStatement → p.pnpStatement

/-- Reverse implication -/
def PNPImpliesRH (p : ProblemPair) : Prop :=
  p.pnpStatement → p.rhStatement

/-- Neither problem is known to imply the other -/
axiom no_known_implication :
  ¬RHImpliesPNP MillenniumPair ∧ ¬PNPImpliesRH MillenniumPair

end Millennium.Framework
