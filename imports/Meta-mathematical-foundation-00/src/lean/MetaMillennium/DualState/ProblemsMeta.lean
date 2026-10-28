/-
  MetaMillennium.DualState.ProblemsMeta
  
  Meta-level declarations for Millennium Problems.
-/

import MetaMillennium.DualState.DualStateDefinition
import MetaMillennium.DualState.NumericClassesCore

namespace MetaMillennium.Problems

open MetaMillennium.DualState

/-- Riemann Hypothesis as a proposition -/
axiom RH : Prop

/-- P ≠ NP as a proposition -/
axiom PNP : Prop

/-- Navier-Stokes regularity as a proposition -/
axiom NS : Prop

/-- BSD Conjecture as a proposition -/
axiom BSD : Prop

/-- Hodge Conjecture as a proposition -/
axiom Hodge : Prop

/-- Yang-Mills Mass Gap as a proposition -/
axiom YM : Prop

/-- All Millennium Problems -/
def MillenniumProblems : List Prop := [RH, PNP, NS, BSD, Hodge, YM]

/-- Dual-states for each problem -/
def DS_RH := DS RH
def DS_PNP := DS PNP
def DS_NS := DS NS
def DS_BSD := DS BSD
def DS_Hodge := DS Hodge
def DS_YM := DS YM

end MetaMillennium.Problems
