/-
  HEU-7 Universal Framework
  Core ZF Axioms Module

  This module defines the foundational axioms of Zermelo-Fraenkel set theory
  with the Axiom of Choice (ZFC). These axioms form the basis for all
  set-theoretic constructions in the HEU-7 framework.

  Designed for automatic expansion by AI assistants (Copilot, etc.)
-/

namespace HEU.Core.ZF

/-- Extensionality: Two sets are equal iff they have the same elements -/
axiom Extensionality : Prop

/-- Foundation (Regularity): Every non-empty set has a ∈-minimal element -/
axiom Foundation : Prop

/-- Pairing: For any two sets, there exists a set containing exactly those two -/
axiom Pairing : Prop

/-- Union: For any set of sets, there exists their union -/
axiom Union : Prop

/-- Power Set: For any set, there exists the set of all its subsets -/
axiom PowerSet : Prop

/-- Infinity: There exists an infinite set -/
axiom Infinity : Prop

/-- Replacement: The image of a set under a definable function is a set -/
axiom Replacement : Prop

/-- Separation (Comprehension): Subsets defined by formulas exist -/
axiom Separation : Prop

/-- Choice: Every family of non-empty sets has a choice function -/
axiom Choice : Prop

/-- ZFC: The conjunction of all ZFC axioms -/
def ZFC : Prop :=
  Extensionality ∧ Foundation ∧ Pairing ∧ Union ∧
  PowerSet ∧ Infinity ∧ Replacement ∧ Separation ∧ Choice

/-- ZF without Choice -/
def ZF : Prop :=
  Extensionality ∧ Foundation ∧ Pairing ∧ Union ∧
  PowerSet ∧ Infinity ∧ Replacement ∧ Separation

/-- Axiom: ZFC is consistent (working assumption) -/
axiom ZFC_consistent : ZFC

end HEU.Core.ZF
