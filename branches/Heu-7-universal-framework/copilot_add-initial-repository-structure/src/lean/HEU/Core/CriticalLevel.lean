/-
  HEU-7 Framework: Critical Level Definitions
  
  This module defines the Critical predicate and related
  concepts for the HEU framework.
-/

import HEU.Core.Ordinals
import HEU.Core.Functional

namespace HEU.Core

/-- The Critical predicate: all elements satisfy the threshold -/
def Critical (S : Functional) : Prop :=
  ∀ x : S.X, S.F x ≥ S.κ

/-- Critical is equivalent to the HEU statement -/
theorem critical_iff_heu (S : Functional) :
    Critical S ↔ S.HEU_Statement := by
  rfl

/-- A witness that fails the critical condition -/
def Counterexample (S : Functional) (x : S.X) : Prop :=
  S.F x < S.κ

/-- If Critical holds, no counterexample exists -/
theorem critical_no_counterexample (S : Functional) (h : Critical S) :
    ∀ x, ¬Counterexample S x := by
  intro x hc
  exact Nat.not_lt.mpr (h x) hc

/-- Strong criticality: all elements strictly exceed the threshold -/
def StrictlyCritical (S : Functional) : Prop :=
  ∀ x : S.X, S.F x > S.κ

/-- Strict criticality implies criticality -/
theorem strictly_critical_imp_critical (S : Functional) :
    StrictlyCritical S → Critical S := by
  intro h x
  exact Nat.le_of_lt (h x)

end HEU.Core
