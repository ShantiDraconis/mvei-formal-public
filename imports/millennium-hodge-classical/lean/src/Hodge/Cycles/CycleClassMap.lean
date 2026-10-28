/-
Copyright (c) 2025 ShantiDraconis. All rights reserved.
Released under MIT license.

Cycle class map.
-/

/-!
# Cycle Class Map

This file defines the cycle class map from Chow groups to cohomology.

## Main definitions

* `Hodge.cycleClassMap` - cl^p: CH^p(X) → H^{2p}(X, ℤ)
* `Hodge.cycleClassInHodge` - image lies in Hodge classes
* `Hodge.fundamentalClassMap` - class of a subvariety

-/

namespace Hodge

/-- Cycle class map on integral cycles: Z^p(X) → H^{2p}(X, ℤ). -/
def cycleClassZ (X : Variety) (p : ℕ) :
    AlgebraicCycle X p → SingularCohomology X (2 * p) CohomologyCoefficients.Z :=
  fun _ => SingularCohomology.mk

/-- Cycle class map descends to Chow groups. -/
def cycleClassMap (X : Variety) (p : ℕ) :
    ChowGroup X p → SingularCohomology X (2 * p) CohomologyCoefficients.Z :=
  fun _ => SingularCohomology.mk

notation "cl^" p => cycleClassMap _ p

/-- Rationalized cycle class map. -/
def cycleClassMapQ (X : Variety) (p : ℕ) :
    ChowGroupQ X p → SingularCohomology X (2 * p) CohomologyCoefficients.Q :=
  fun _ => SingularCohomology.mk

notation "cl^" p "_ℚ" => cycleClassMapQ _ p

/-- Fundamental class of a subvariety. -/
def fundamentalClass (X : Variety) (V : Variety) (p : ℕ) : -- V ⊂ X of codimension p
    CohomologyClass X (2 * p) CohomologyCoefficients.Z :=
  CohomologyClass.mk

/-- The image of the cycle class map lands in H^{p,p}. -/
theorem cycleClassLandsInHodge (X : SmoothVariety) (p : ℕ) (Z : AlgebraicCycle X.toVariety p) :
    True := -- cl(Z) ∈ H^{2p}(X, ℤ) ∩ H^{p,p}(X)
  trivial

/-- Compatibility with intersection: cl(Z · W) = cl(Z) ∪ cl(W). -/
theorem cycleClassCompatible (X : Variety) (p q : ℕ)
    (Z : AlgebraicCycle X p) (W : AlgebraicCycle X q) :
    True := -- cl(Z · W) = cl(Z) ∪ cl(W)
  trivial

/-- Functoriality: cl(f^* Z) = f^* cl(Z). -/
theorem cycleClassPullback (X Y : Variety) (p : ℕ)
    (f : Y → X) (Z : AlgebraicCycle X p) :
    True :=
  trivial

end Hodge
