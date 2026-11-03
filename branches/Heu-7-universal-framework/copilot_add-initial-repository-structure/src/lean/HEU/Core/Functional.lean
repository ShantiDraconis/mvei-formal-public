/-
  HEU-7 Framework: Functional Structure
  
  This module defines the core Functional structure that
  captures the HEU hypothesis: for each problem P, we have
  a triple (X_P, F_P, κ_P).
-/

import HEU.Core.Ordinals

namespace HEU.Core

/-- The core HEU Functional structure.
    For each Millennium Problem P, we define:
    - X : the definable domain set
    - F : the ordinal-valued functional
    - κ : the critical ordinal threshold -/
structure Functional where
  /-- The domain type (definable set X_P) -/
  X : Type
  /-- The ordinal-valued functional F_P : X_P → Ord -/
  F : X → Ord
  /-- The critical ordinal κ_P -/
  κ : Ord

/-- The HEU statement for a Functional:
    The problem is true iff ∀ x ∈ X, F(x) ≥ κ -/
def Functional.HEU_Statement (S : Functional) : Prop :=
  ∀ x : S.X, S.F x ≥ S.κ

/-- Alternative formulation: no element falls below the critical level -/
def Functional.NoDeficit (S : Functional) : Prop :=
  ¬∃ x : S.X, S.F x < S.κ

/-- Equivalence between HEU statement and NoDeficit -/
theorem heu_equiv_no_deficit (S : Functional) :
    S.HEU_Statement ↔ S.NoDeficit := by
  constructor
  · intro h ⟨x, hx⟩
    exact Nat.not_lt.mpr (h x) hx
  · intro h x
    by_contra hc
    exact h ⟨x, Nat.not_le.mp hc⟩

end HEU.Core
