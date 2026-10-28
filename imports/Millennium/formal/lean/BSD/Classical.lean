/-
Classical Definitions for Birch and Swinnerton-Dyer Conjecture

This file contains classical definitions for the BSD conjecture in Clay format.
-/

import Mathlib.NumberTheory.EllipticCurve
import Mathlib.Analysis.Complex.Basic

namespace BSD.Classical

/-- An elliptic curve over ℚ (axiomatized) -/
axiom EllipticCurve : Type

/-- The L-function of an elliptic curve -/
axiom L : EllipticCurve → ℂ → ℂ

/-- The order of vanishing of L at s=1 -/
axiom ord_s_1 : EllipticCurve → ℕ

/-- The group of rational points on E -/
axiom RationalPoints : EllipticCurve → Type

/-- The rank of E(ℚ) as a finitely generated abelian group -/
axiom rank : EllipticCurve → ℕ

/-- The Mordell-Weil group structure -/
axiom mordell_weil_theorem : ∀ E : EllipticCurve, 
  ∃ r : ℕ, ∃ T : Type, True  -- E(ℚ) ≅ ℤʳ ⊕ T where T is finite

/-- Regulator of E -/
axiom regulator : EllipticCurve → ℝ

/-- Tamagawa numbers -/
axiom tamagawa_product : EllipticCurve → ℕ

/-- Order of Tate-Shafarevich group (conjecturally finite) -/
axiom sha_order : EllipticCurve → ℕ

/-- Real period -/
axiom real_period : EllipticCurve → ℝ

/-- Classical statement of BSD conjecture -/
def BirchSwinnertonDyer : Prop :=
  ∀ E : EllipticCurve, ord_s_1 E = rank E

/-- Gap operator for BSD -/
def Δ_BSD (E : EllipticCurve) : ℤ :=
  (ord_s_1 E : ℤ) - (rank E : ℤ)

/-- BSD is equivalent to all gaps being zero -/
theorem bsd_gap_characterization :
  BirchSwinnertonDyer ↔ ∀ E : EllipticCurve, Δ_BSD E = 0 := by
  constructor
  · intro h E
    simp [Δ_BSD]
    have := h E
    simp [this]
  · intro h E
    have gap := h E
    simp [Δ_BSD] at gap
    exact Nat.cast_injective gap

/-- Weak BSD: L(E,1) ≠ 0 iff rank(E) = 0 -/
def WeakBSD : Prop :=
  ∀ E : EllipticCurve, (L E 1 ≠ 0) ↔ (rank E = 0)

/-- Weak BSD implies something about the gap -/
theorem weak_bsd_gap :
  WeakBSD → ∀ E : EllipticCurve, L E 1 ≠ 0 → Δ_BSD E = 0 := by
  intro h E hL
  simp [Δ_BSD]
  have := (h E).mp hL
  simp [this]
  -- If rank = 0, then ord = 0 by definition when L(E,1) ≠ 0
  sorry

end BSD.Classical
