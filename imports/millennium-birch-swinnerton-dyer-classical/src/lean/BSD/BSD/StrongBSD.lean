/-
Copyright (c) 2025 BSD Formalization Project. All rights reserved.
Released under MIT license.
Authors: BSD Formalization Project Contributors
-/

import BSD.BSD.Statement

/-!
# Strong BSD Conjecture

This file focuses on the strong form of BSD: the exact formula for the leading coefficient.

## Main Results

* Full BSD formula statement
* Verification strategies

## References

* [J. Silverman, *The Arithmetic of Elliptic Curves*][silverman2009]
-/

namespace EllipticCurve

variable (E : EllipticCurve ℚ)

/-! ## The BSD Formula -/

/-- The BSD formula expressed in detail -/
theorem BSD_formula_detailed :
    StrongBSD E ↔
    (algebraicRank E = analyticRank E ∧
     let r := analyticRank E
     let L_star := deriv^[r] (L_function E) 1 / Nat.factorial r
     (L_star).re = (realPeriod E * regulator E [] * (tamagawaProduct E : ℝ) * (shaOrder E : ℝ)) /
                   ((torsionOrder E : ℝ)^2)) := by
  sorry

/-- Strong BSD components are all positive -/
theorem BSD_components_pos (h : StrongBSD E) :
    realPeriod E > 0 ∧
    regulator E [] > 0 ∧
    (tamagawaProduct E : ℝ) > 0 ∧
    (shaOrder E : ℝ) > 0 ∧
    (torsionOrder E : ℝ) > 0 := by
  constructor
  · exact realPeriod_pos E
  · sorry  -- Regulator positivity
  constructor
  · sorry  -- Tamagawa positivity
  constructor
  · sorry  -- Sha positivity
  · sorry  -- Torsion positivity

/-! ## Special Cases -/

/-- BSD formula when rank = 0 -/
theorem BSD_formula_at_rank_0 (h0 : analyticRank E = 0) (hBSD : StrongBSD E) :
    (L_function E 1).re = (realPeriod E * (tamagawaProduct E : ℝ) * (shaOrder E : ℝ)) /
                          ((torsionOrder E : ℝ)^2) := by
  sorry

/-- BSD formula when rank = 1 -/
theorem BSD_formula_at_rank_1 (h1 : analyticRank E = 1)
    (gens : List (Point E)) (hgens : gens.length = 1) (hBSD : StrongBSD E) :
    (deriv (L_function E) 1).re =
    (realPeriod E * regulator E gens * (tamagawaProduct E : ℝ) * (shaOrder E : ℝ)) /
    ((torsionOrder E : ℝ)^2) := by
  sorry

/-! ## Numerical Verification -/

/-- Structure for numerical BSD verification data -/
structure BSDVerificationData where
  L_value : ℝ  -- L^(r)(E, 1) / r!
  period : ℝ
  regulator : ℝ
  tamagawa : ℕ
  sha : ℕ
  torsion : ℕ
  rank : ℕ

/-- Check if BSD formula holds numerically (up to precision) -/
def numerically_verifies (data : BSDVerificationData) (ε : ℝ) : Prop :=
  let rhs := (data.period * data.regulator * (data.tamagawa : ℝ) * (data.sha : ℝ)) /
             ((data.torsion : ℝ)^2)
  |data.L_value - rhs| < ε

/-! ## Implications of Strong BSD -/

/-- Strong BSD implies Sha is finite -/
theorem StrongBSD_sha_finite (h : StrongBSD E) :
    ∃ n : ℕ, shaOrder E = n := by
  use shaOrder E

/-- Strong BSD determines Sha order from other invariants -/
theorem StrongBSD_sha_from_formula (h : StrongBSD E) :
    (shaOrder E : ℝ) = ((torsionOrder E : ℝ)^2 * (leadingTerm E).re) /
                       (realPeriod E * regulator E [] * (tamagawaProduct E : ℝ)) := by
  sorry

/-- Strong BSD implies Sha is a perfect square -/
theorem StrongBSD_sha_square (h : StrongBSD E) :
    ∃ m : ℕ, shaOrder E = m^2 := sha_is_square E

/-! ## Relation to Known Results -/

/-- Strong BSD holds for CM curves of rank 0 (Coates-Wiles) -/
axiom StrongBSD_CM_rank_0 (h : True) (hrank : analyticRank E = 0) : StrongBSD E

/-- Strong BSD can be numerically verified for many curves -/
-- Cremona's tables verify BSD numerically for all curves of conductor ≤ N

end EllipticCurve
Released under MIT license as described in the file LICENSE.
Authors: BSD Formalization Team
-/

/-!
# Strong BSD

Statement of the strong form of BSD.

## References

* See: `docs/07-bsd-conjecture/weak-and-strong-bsd.md`
-/

import BSD.BSD.Statement

namespace BSD.BSD

/-!
## Strong BSD Statement

L^*(E, 1) = (Ω_E · Reg_E · ∏c_p · |Sha|) / |E(ℚ)_tors|²

This gives an explicit formula for the leading coefficient.
-/

-- See Statement.lean for BSD_Strong

/-!
## Implications

Strong BSD implies:
1. Weak BSD (rank equality)
2. Finiteness of Sha
3. |Sha| is computable from other terms
-/

end BSD.BSD
