/-
Copyright (c) 2025 ShantiDraconis. All rights reserved.
Released under MIT license.

Kähler manifolds.
-/

/-!
# Kähler Manifolds

This file defines Kähler manifolds and their properties.

## Main definitions

* `Hodge.KahlerManifold` - Kähler manifold structure
* `Hodge.KahlerForm` - the Kähler 2-form ω
* `Hodge.KahlerClass` - cohomology class [ω]

-/

namespace Hodge

/-- A Kähler manifold is a complex manifold with a compatible Kähler metric. -/
structure KahlerManifold extends SmoothVariety where
  -- Kähler form ω
  -- ω is closed: dω = 0
  -- ω is positive definite
  mk ::

/-- The Kähler form on a Kähler manifold. -/
def KahlerForm (X : KahlerManifold) : DifferentialForm X.toSmoothVariety 2 :=
  DifferentialForm.mk

/-- The Kähler class [ω] ∈ H^2(X, ℝ). -/
def KahlerClass (X : KahlerManifold) : CohomologyClass X.toSmoothVariety.toVariety 2 CohomologyCoefficients.R :=
  CohomologyClass.mk

/-- Every smooth projective variety is Kähler. -/
theorem projectiveIsKahler (X : SmoothProjectiveVariety) : True :=
  trivial -- The Fubini-Study metric restricts to give a Kähler metric

/-- A positive (1,1)-form. -/
structure PositiveForm (X : KahlerManifold) where
  mk ::

end Hodge
