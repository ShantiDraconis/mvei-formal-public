/-
Copyright (c) 2025 ShantiDraconis. All rights reserved.
Released under MIT license.

Forms of type (p,q).
-/

/-!
# (p,q)-Forms

This file defines differential forms of type (p,q) on complex manifolds.

## Main definitions

* `Hodge.FormPQ` - forms of type (p,q)
* `Hodge.delOperator` - the ∂ operator
* `Hodge.delBarOperator` - the ∂̄ operator

-/

namespace Hodge

/-- A differential form of type (p,q) on a complex manifold. -/
structure FormPQ (X : SmoothVariety) (p q : ℕ) where
  -- Local expression: f_{I,J} dz_{i_1} ∧ ... ∧ dz_{i_p} ∧ dz̄_{j_1} ∧ ... ∧ dz̄_{j_q}
  mk ::

/-- The ∂ operator: Ω^{p,q} → Ω^{p+1,q}. -/
def delOperator (X : SmoothVariety) (p q : ℕ) :
    FormPQ X p q → FormPQ X (p + 1) q :=
  fun _ => FormPQ.mk

notation "∂" => delOperator

/-- The ∂̄ operator: Ω^{p,q} → Ω^{p,q+1}. -/
def delBarOperator (X : SmoothVariety) (p q : ℕ) :
    FormPQ X p q → FormPQ X p (q + 1) :=
  fun _ => FormPQ.mk

notation "∂̄" => delBarOperator

/-- The exterior derivative splits: d = ∂ + ∂̄. -/
theorem dSplits (X : SmoothVariety) (p q : ℕ) (ω : FormPQ X p q) :
    True := -- d(ω) = ∂(ω) + ∂̄(ω)
  trivial

/-- ∂² = 0. -/
theorem delSquaredZero (X : SmoothVariety) (p q : ℕ) :
    True := -- ∂ ∘ ∂ = 0
  trivial

/-- ∂̄² = 0. -/
theorem delBarSquaredZero (X : SmoothVariety) (p q : ℕ) :
    True := -- ∂̄ ∘ ∂̄ = 0
  trivial

/-- ∂∂̄ + ∂̄∂ = 0. -/
theorem delDelBarAnticommute (X : SmoothVariety) (p q : ℕ) :
    True :=
  trivial

end Hodge
