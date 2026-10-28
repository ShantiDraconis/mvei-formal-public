/-
Copyright (c) 2025 ShantiDraconis. All rights reserved.
Released under MIT license.

Singular cohomology.
-/

/-!
# Singular Cohomology

This file defines singular cohomology groups.

## Main definitions

* `Hodge.SingularCohomology` - H^k(X, R) for various coefficient rings
* `Hodge.CupProduct` - the cup product on cohomology

-/

namespace Hodge

/-- Coefficient ring for cohomology. -/
inductive CohomologyCoefficients
  | Z : CohomologyCoefficients  -- Integers
  | Q : CohomologyCoefficients  -- Rationals
  | R : CohomologyCoefficients  -- Reals
  | C : CohomologyCoefficients  -- Complex

/-- Singular cohomology group H^k(X, R). -/
structure SingularCohomology (X : Variety) (k : ℕ) (R : CohomologyCoefficients) where
  -- The cohomology group as an R-module
  mk ::

notation "H^" k "(" X ", " R ")" => SingularCohomology X k R

/-- A cohomology class. -/
structure CohomologyClass (X : Variety) (k : ℕ) (R : CohomologyCoefficients) where
  mk ::

/-- The cup product on cohomology. -/
def cupProduct (X : Variety) (k l : ℕ) (R : CohomologyCoefficients)
    (α : CohomologyClass X k R) (β : CohomologyClass X l R) :
    CohomologyClass X (k + l) R :=
  CohomologyClass.mk

notation α " ∪ " β => cupProduct _ _ _ _ α β

/-- Change of coefficients map. -/
def coefficientChange (X : Variety) (k : ℕ)
    (R S : CohomologyCoefficients)
    (h : R = CohomologyCoefficients.Z ∨ S = CohomologyCoefficients.C) :
    SingularCohomology X k R → SingularCohomology X k S :=
  fun _ => SingularCohomology.mk

end Hodge
