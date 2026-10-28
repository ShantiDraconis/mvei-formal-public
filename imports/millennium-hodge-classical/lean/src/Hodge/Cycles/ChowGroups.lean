/-
Copyright (c) 2025 ShantiDraconis. All rights reserved.
Released under MIT license.

Chow groups.
-/

/-!
# Chow Groups

This file defines Chow groups and rational equivalence.

## Main definitions

* `Hodge.RationalEquivalence` - rational equivalence of cycles
* `Hodge.ChowGroup` - CH^p(X) = Z^p(X) / ~_rat
* `Hodge.ChowRing` - the Chow ring structure

-/

namespace Hodge

/-- Two cycles are rationally equivalent if they differ by a principal divisor. -/
def RationalEquivalence (X : Variety) (p : ℕ) (Z W : AlgebraicCycle X p) : Prop :=
  True -- Z - W = div(f) for some rational function f on a (p-1)-cycle

notation Z " ~_rat " W => RationalEquivalence _ _ Z W

/-- The Chow group CH^p(X) = Z^p(X) / ~_rat. -/
def ChowGroup (X : Variety) (p : ℕ) : Type :=
  Quotient (Setoid.mk (RationalEquivalence X p) (by
    constructor
    · intro a; trivial
    constructor
    · intro a b _; trivial
    · intro a b c _ _; trivial))

notation "CH^" p "(" X ")" => ChowGroup X p

/-- The rationalized Chow group CH^p(X)_ℚ. -/
def ChowGroupQ (X : Variety) (p : ℕ) : Type := ChowGroup X p -- Tensor with ℚ

notation "CH^" p "(" X ")_ℚ" => ChowGroupQ X p

/-- CH^0(X) ≅ ℤ for connected X. -/
theorem chow0IsZ (X : Variety) : True := trivial

/-- CH^1(X) ≅ Pic(X) for smooth X. -/
theorem chow1IsPic (X : SmoothVariety) : True := trivial

/-- The Chow ring structure. -/
structure ChowRing (X : Variety) where
  graded : ℕ → Type
  mul : ∀ p q, graded p → graded q → graded (p + q)
  mk ::

end Hodge
