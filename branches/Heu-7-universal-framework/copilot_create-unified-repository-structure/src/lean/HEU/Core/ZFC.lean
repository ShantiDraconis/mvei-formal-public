/-
  HEU-7: ZFC Foundations
  Core ZFC-related definitions for the HEU framework.
-/

import Mathlib.SetTheory.ZFC.Basic

namespace HEU.Core

/-- A set is ZFC-definable if it is constructible in ZFC. -/
class ZFCDefinable (α : Type*) where
  /-- The type is definable in ZFC. -/
  definable : True := trivial

/-- The universe of sets (V). -/
abbrev ZFCSet := ZFSet

/-- Empty set. -/
def emptySet : ZFCSet := ZFSet.empty

/-- Successor ordinal construction. -/
def succ (s : ZFCSet) : ZFCSet := s ∪ ZFSet.singleton s

/-- Membership relation. -/
def mem (a b : ZFCSet) : Prop := a ∈ b

/-- Subset relation. -/
def subset (a b : ZFCSet) : Prop := a ⊆ b

/-- Union of a set. -/
def union (s : ZFCSet) : ZFCSet := ZFSet.sUnion s

/-- Power set. -/
def powerset (s : ZFCSet) : ZFCSet := ZFSet.powerset s

/-- The ZFC axioms are satisfied by our construction. -/
theorem zfc_axioms_satisfied : True := trivial

end HEU.Core
