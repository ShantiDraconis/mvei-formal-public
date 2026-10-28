/-
  BSD Conjecture: Hawking Limit Analysis
  
  Definition of the BSD-Hawking Functional.
-/

import Hawking.UniversalFunctional

namespace Problems.BSD

open Hawking

/-- Elliptic curve (axiomatized) -/
structure EllipticCurve where
  a : ℤ
  b : ℤ
  discriminant_nonzero : -16 * (4 * a^3 + 27 * b^2) ≠ 0

/-- L-function of an elliptic curve (axiomatized) -/
axiom L_function (E : EllipticCurve) : ℂ → ℂ

/-- Algebraic rank of E(ℚ) (axiomatized) -/
axiom algebraic_rank (E : EllipticCurve) : ℕ

/-- The BSD-Hawking Functional -/
noncomputable def H_BSD (E : EllipticCurve) (s : ℂ) : ℂ :=
  L_function E s / (s - 1)^(algebraic_rank E)

/-- Order of vanishing of L at s = 1 -/
axiom analytic_rank (E : EllipticCurve) : ℕ

/-- BSD Conjecture: analytic rank = algebraic rank -/
def BSD_Conjecture (E : EllipticCurve) : Prop :=
  analytic_rank E = algebraic_rank E

/-- BSD-Hawking equivalence -/
theorem bsd_hawking_equivalence (E : EllipticCurve) :
    BSD_Conjecture E ↔ 
    ∃ L : ℂ, L ≠ 0 ∧ RegularLimit (H_BSD E) 1 L := by
  sorry

end Problems.BSD
