/-
  HEU-7 Framework: Functional Definitions
  
  This module provides the core functional structure for HEU frameworks.
  Each problem P has an associated functional F_P : X_P → Ordinal.
-/

import HEU.Core.Ordinals

namespace HEU.Core

/-- 
  A HEU Framework for a problem consists of:
  - X_P : Type (the space of objects)
  - F_P : X_P → Ordinal (the ordinal functional)
  - α_P : Ordinal (the critical ordinal)
-/
structure HEUFramework (X : Type*) where
  /-- The ordinal-valued functional -/
  functional : X → Ordinal
  /-- The critical ordinal -/
  criticalOrdinal : Ordinal

/-- 
  The structural equivalence statement:
  All objects satisfy the ordinal bound
-/
def StructuralEquivalence {X : Type*} (heu : HEUFramework X) : Prop :=
  ∀ x : X, heu.functional x ≤ heu.criticalOrdinal

/--
  A HEU Framework satisfies the bound property if the structural equivalence holds
-/
def SatisfiesBound {X : Type*} (heu : HEUFramework X) : Prop :=
  StructuralEquivalence heu

/--
  The negation: there exists a counterexample exceeding the bound
-/
def ExceedsBound {X : Type*} (heu : HEUFramework X) : Prop :=
  ∃ x : X, heu.functional x > heu.criticalOrdinal

theorem bound_or_exceed {X : Type*} [Nonempty X] (heu : HEUFramework X) :
    SatisfiesBound heu ∨ ExceedsBound heu := by
  by_cases h : ∀ x : X, heu.functional x ≤ heu.criticalOrdinal
  · left; exact h
  · right
    push_neg at h
    exact h

/-- Monotonic functional -/
def IsMonotonic {X : Type*} [LE X] (F : X → Ordinal) : Prop :=
  ∀ x y : X, x ≤ y → F x ≤ F y

end HEU.Core
