/-
  BSD.lean - Birch and Swinnerton-Dyer Conjecture
  
  The BSD conjecture relates the rank of an elliptic curve E/ℚ
  to the order of vanishing of its L-function L(E, s) at s = 1.
  
  In the Δ-formulation:
    X_BSD = {E : elliptic curve over ℚ}
    Δ_BSD(E) = |rank(E(ℚ)) - ord_{s=1} L(E, s)|
    
  BSD ⟺ ∀ E, Δ_BSD(E) = 0
-/

import Millennium.CoreDelta

namespace Millennium.BSD

/-- Abstract representation of an elliptic curve over ℚ -/
structure EllipticCurve where
  /-- Weierstrass coefficients -/
  a : ℤ × ℤ × ℤ × ℤ × ℤ
  /-- Non-singularity condition -/
  nonsingular : True

/-- The Mordell-Weil rank of E(ℚ) -/
axiom algebraicRank : EllipticCurve → ℕ

/-- The L-function of an elliptic curve -/
axiom L_function : EllipticCurve → (ℂ → ℂ)

/-- Order of vanishing of L(E, s) at s = 1 -/
axiom analyticRank : EllipticCurve → ℕ

/-- The space of all elliptic curves over ℚ -/
def allEllipticCurves : Set EllipticCurve :=
  Set.univ

/-- The BSD deviation function -/
def delta_BSD (E : EllipticCurve) : ℝ :=
  |(algebraicRank E : ℝ) - (analyticRank E : ℝ)|

/-- The Birch and Swinnerton-Dyer Conjecture -/
def BSDConjecture : Prop :=
  ∀ E : EllipticCurve, algebraicRank E = analyticRank E

/-- BSD in Δ-form -/
theorem BSD_delta_formulation :
    BSDConjecture ↔ ∀ E : EllipticCurve, delta_BSD E = 0 := by
  unfold BSDConjecture delta_BSD
  constructor
  · intro h E
    rw [h E]
    simp
  · intro h E
    have := h E
    simp at this
    omega

/-- The BSD DeltaProblem structure -/
def bsdProblem : DeltaProblem EllipticCurve where
  X_crit := allEllipticCurves
  delta := delta_BSD
  delta_nonneg := fun _ _ => abs_nonneg _

/-- BSD solved iff the conjecture holds -/
theorem bsd_solved_iff_conjecture :
    bsdProblem.solved ↔ BSDConjecture := by
  rw [DeltaProblem.solved, BSD_delta_formulation]
  simp [allEllipticCurves]

end Millennium.BSD
