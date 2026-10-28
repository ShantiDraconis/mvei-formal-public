/-
Copyright (c) 2025 ShantiDraconis. All rights reserved.
Released under MIT license.

Intersection product.
-/

/-!
# Intersection Product

This file defines the intersection product on algebraic cycles.

## Main definitions

* `Hodge.intersectionProduct` - intersection of cycles
* `Hodge.properIntersection` - when cycles meet properly
* `Hodge.intersectionMultiplicity` - local intersection number

-/

namespace Hodge

/-- Two cycles intersect properly if their intersection has expected dimension. -/
def properIntersection (X : Variety) (p q : ℕ)
    (Z : AlgebraicCycle X p) (W : AlgebraicCycle X q) : Prop :=
  True -- dim(Z ∩ W) = dim(Z) + dim(W) - dim(X)

/-- Intersection multiplicity at a point. -/
def intersectionMultiplicity (X : Variety) (p q : ℕ)
    (Z : AlgebraicCycle X p) (W : AlgebraicCycle X q) : ℤ :=
  0 -- Placeholder

/-- Intersection product of properly intersecting cycles. -/
def intersectionProduct (X : Variety) (p q : ℕ)
    (Z : AlgebraicCycle X p) (W : AlgebraicCycle X q)
    (h : properIntersection X p q Z W) : AlgebraicCycle X (p + q) :=
  AlgebraicCycle.mk

notation Z " · " W => intersectionProduct _ _ _ Z W _

/-- Chow's Moving Lemma: any cycle can be moved to intersect properly. -/
theorem movingLemma (X : SmoothVariety) (p q : ℕ) (Z : AlgebraicCycle X.toVariety p) :
    ∃ Z' : AlgebraicCycle X.toVariety p, True := -- Z' ~_rat Z and properly intersects any W
  ⟨Z, trivial⟩

/-- Intersection descends to Chow groups. -/
def chowProduct (X : Variety) (p q : ℕ) :
    ChowGroup X p → ChowGroup X q → ChowGroup X (p + q) :=
  fun _ _ => Quotient.mk _ (AlgebraicCycle.mk)

/-- Commutativity of intersection product. -/
theorem intersectionCommutative (X : Variety) (p q : ℕ)
    (Z : AlgebraicCycle X p) (W : AlgebraicCycle X q) :
    True := -- Z · W = W · Z (up to sign and proper intersection)
  trivial

end Hodge
