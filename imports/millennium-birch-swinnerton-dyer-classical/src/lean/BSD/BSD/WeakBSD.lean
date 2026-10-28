/-
Copyright (c) 2025 BSD Formalization Project. All rights reserved.
Released under MIT license.
Authors: BSD Formalization Project Contributors
-/

import BSD.BSD.Statement

/-!
# Weak BSD Conjecture

This file focuses on the weak form of BSD: equality of ranks.

## Main Results

* Properties and implications of Weak BSD
* Known cases

## References

* [J. Silverman, *The Arithmetic of Elliptic Curves*][silverman2009]
-/

namespace EllipticCurve

variable (E : EllipticCurve ℚ)

/-! ## Weak BSD Properties -/

/-- Weak BSD is equivalent to rank equality -/
theorem WeakBSD_def : WeakBSD E ↔ algebraicRank E = analyticRank E := Iff.rfl

/-- If Weak BSD holds, root number determines parity of rank -/
theorem WeakBSD_parity (h : WeakBSD E) :
    Even (algebraicRank E) ↔ rootNumber E = 1 := by
  rw [h]
  exact analyticRank_parity' E

/-- Weak BSD for analytic rank 0 -/
theorem WeakBSD_analytic_rank_0 (h : analyticRank E = 0) :
    WeakBSD E ↔ algebraicRank E = 0 := by
  simp only [WeakBSD, h]

/-- Weak BSD for analytic rank 1 -/
theorem WeakBSD_analytic_rank_1 (h : analyticRank E = 1) :
    WeakBSD E ↔ algebraicRank E = 1 := by
  simp only [WeakBSD, h]

/-! ## Known Cases of Weak BSD -/

/-- Weak BSD holds when L(E, 1) ≠ 0 (rank 0 case) -/
theorem WeakBSD_holds_rank_0 (h : L_function E 1 ≠ 0) : WeakBSD E := by
  simp only [WeakBSD]
  have hr_an : analyticRank E = 0 := (analyticRank_zero_iff_L_nonzero E).mpr h
  have hr_alg : algebraicRank E = 0 := kolyvagin_rank_zero E h
  omega

/-- Weak BSD holds when analytic rank is 1 -/
theorem WeakBSD_holds_rank_1 (h0 : L_function E 1 = 0)
    (h1 : deriv (L_function E) 1 ≠ 0) : WeakBSD E := by
  simp only [WeakBSD]
  have hr_an : analyticRank E = 1 := (analyticRank_one_iff E).mpr ⟨h0, h1⟩
  have hr_alg : algebraicRank E = 1 := gross_zagier_kolyvagin E h0 h1
  omega

/-- Weak BSD holds when analytic rank ≤ 1 -/
theorem WeakBSD_holds_rank_leq_1 (h : analyticRank E ≤ 1) : WeakBSD E := by
  simp only [WeakBSD]
  exact BSD_rank_leq_1 E h

/-! ## Implications of Weak BSD -/

/-- Weak BSD implies the existence of rational points when rank > 0 -/
theorem WeakBSD_rational_points (h : WeakBSD E) (hr : analyticRank E ≥ 1) :
    ∃ P : Point E, ∀ n : ℕ, n > 0 → n • P ≠ Point.infinity := by
  -- If analytic rank ≥ 1, then algebraic rank ≥ 1 by BSD
  -- So there exists a point of infinite order
  sorry

/-- Weak BSD and root number -1 implies non-trivial rational point -/
theorem WeakBSD_root_minus_one_point (h : WeakBSD E) (hw : rootNumber E = -1) :
    ∃ P : Point E, ∀ n : ℕ, n > 0 → n • P ≠ Point.infinity := by
  apply WeakBSD_rational_points E h
  -- Root number -1 implies odd analytic rank, so ≥ 1
  have hodd := analyticRank_odd_if_root_minus_one E hw
  exact Nat.one_le_iff_ne_zero.mpr (Nat.odd_iff_not_even.mp hodd ∘ Even.mono (fun _ h => h ▸ rfl))

/-! ## Equivalent Formulations -/

/-- Weak BSD in terms of L-function values -/
theorem WeakBSD_L_function_form :
    WeakBSD E ↔
    (L_function E 1 ≠ 0 → algebraicRank E = 0) ∧
    (∀ k : ℕ, (∀ j < k, deriv^[j] (L_function E) 1 = 0) →
              deriv^[k] (L_function E) 1 ≠ 0 →
              algebraicRank E = k) := by
  sorry

/-- Weak BSD in terms of descent -/
-- Would require Selmer groups

end EllipticCurve
Released under MIT license as described in the file LICENSE.
Authors: BSD Formalization Team
-/

/-!
# Weak BSD

Statement and approach for the weak form of BSD.

## References

* See: `docs/07-bsd-conjecture/weak-and-strong-bsd.md`
-/

import BSD.BSD.Statement

namespace BSD.BSD

/-!
## Weak BSD Statement

rank(E(ℚ)) = ord_{s=1} L(E, s)

This is about the equality of two integers.
-/

-- See Statement.lean for BSD_Weak

/-!
## Approaches

1. For r_{an} = 0: Use Kolyvagin's Euler system
2. For r_{an} = 1: Use Gross-Zagier + Kolyvagin
3. For r_{an} ≥ 2: Open problem
-/

end BSD.BSD
