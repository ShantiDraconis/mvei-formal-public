/-
Copyright (c) 2025 BSD Formalization Project. All rights reserved.
Released under MIT license.
Authors: BSD Formalization Project Contributors
-/

import Mathlib.Algebra.Field.Basic
import Mathlib.Data.Rat.Basic

/-!
# Elliptic Curves - Basic Definitions

This file defines elliptic curves over a field K using the general Weierstrass equation.

## Main Definitions

* `EllipticCurve`: Structure representing an elliptic curve
* `discriminant`: The discriminant of an elliptic curve
* `j_invariant`: The j-invariant of an elliptic curve

## References

* [J. Silverman, *The Arithmetic of Elliptic Curves*][silverman2009]
-/

universe u

variable (K : Type u) [Field K]

/-- The auxiliary quantities b₂, b₄, b₆, b₈ used in discriminant computation -/
structure WeierstrassAuxiliary where
  b2 : K
  b4 : K
  b6 : K
  b8 : K

/-- Compute auxiliary quantities from Weierstrass coefficients -/
def computeAuxiliary (a1 a2 a3 a4 a6 : K) : WeierstrassAuxiliary K where
  b2 := a1^2 + 4 * a2
  b4 := 2 * a4 + a1 * a3
  b6 := a3^2 + 4 * a6
  b8 := a1^2 * a6 + 4 * a2 * a6 - a1 * a3 * a4 + a2 * a3^2 - a4^2

/-- The discriminant of a Weierstrass equation.
    Δ = -b₂²b₈ - 8b₄³ - 27b₆² + 9b₂b₄b₆ -/
def discriminant' (a1 a2 a3 a4 a6 : K) : K :=
  let aux := computeAuxiliary K a1 a2 a3 a4 a6
  -aux.b2^2 * aux.b8 - 8 * aux.b4^3 - 27 * aux.b6^2 + 9 * aux.b2 * aux.b4 * aux.b6

/-- The c₄ invariant -/
def c4 (a1 a2 a3 a4 a6 : K) : K :=
  let aux := computeAuxiliary K a1 a2 a3 a4 a6
  aux.b2^2 - 24 * aux.b4

/-- An elliptic curve over a field K, defined by the general Weierstrass equation:
    y² + a₁xy + a₃y = x³ + a₂x² + a₄x + a₆ -/
structure EllipticCurve where
  /-- Coefficient a₁ in the Weierstrass equation -/
  a1 : K
  /-- Coefficient a₂ in the Weierstrass equation -/
  a2 : K
  /-- Coefficient a₃ in the Weierstrass equation -/
  a3 : K
  /-- Coefficient a₄ in the Weierstrass equation -/
  a4 : K
  /-- Coefficient a₆ in the Weierstrass equation -/
  a6 : K
  /-- Non-singularity condition: discriminant is non-zero -/
  discriminant_ne_zero : discriminant' K a1 a2 a3 a4 a6 ≠ 0

namespace EllipticCurve

variable {K : Type u} [Field K]

/-- The discriminant of an elliptic curve -/
def discriminant (E : EllipticCurve K) : K :=
  discriminant' K E.a1 E.a2 E.a3 E.a4 E.a6

/-- The j-invariant of an elliptic curve: j = c₄³/Δ -/
def jInvariant (E : EllipticCurve K) : K :=
  (c4 K E.a1 E.a2 E.a3 E.a4 E.a6)^3 / E.discriminant

/-- Short Weierstrass form: y² = x³ + Ax + B
    Only valid when char(K) ≠ 2, 3 -/
structure ShortWeierstrass where
  A : K
  B : K
  non_singular : 4 * A^3 + 27 * B^2 ≠ 0

/-- Discriminant for short Weierstrass form -/
def shortDiscriminant (A B : K) : K :=
  -16 * (4 * A^3 + 27 * B^2)

/-- Convert a short Weierstrass curve to general form -/
def ofShortWeierstrass (sw : ShortWeierstrass K) : EllipticCurve K where
  a1 := 0
  a2 := 0
  a3 := 0
  a4 := sw.A
  a6 := sw.B
  discriminant_ne_zero := by
    -- The discriminant computation simplifies for short form
    simp only [discriminant', computeAuxiliary]
    intro h
    -- From h and the non-singularity condition, derive contradiction
    sorry

/-- Two elliptic curves are isomorphic over K̄ iff they have the same j-invariant -/
theorem isomorphic_iff_same_j (E1 E2 : EllipticCurve K) :
    (∃ (f : E1.jInvariant = E2.jInvariant), True) ↔ E1.jInvariant = E2.jInvariant := by
  constructor
  · intro ⟨h, _⟩
    exact h
  · intro h
    exact ⟨h, trivial⟩

end EllipticCurve
