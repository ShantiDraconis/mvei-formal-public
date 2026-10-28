import Mathlib
import UMI_RH.Projections

namespace UMI_RH

/-!
ANCHOR:
Nyman–Beurling / Báez–Duarte equivalence in the chosen normalization.
For scaffold compilation, we axiomatize it. Later: replace this axiom by a fully formal proof
(or import a Mathlib theorem if available).
-/

-- Riemann Hypothesis proposition (placeholder axiom for now).
axiom RH : Prop

/--\nLimit distance from the Nyman–Beurling construction: the residual norm of the indicator\nin the closure of the NB spans in `L^2(0,1)`.\n-/
constant d : ℝ

axiom NB_BD_anchor : RH ↔ d = 0

end UMI_RH
