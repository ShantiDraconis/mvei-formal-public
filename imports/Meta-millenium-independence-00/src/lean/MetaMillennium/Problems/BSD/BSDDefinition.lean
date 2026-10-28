/-
  MetaMillennium.Problems.BSD.BSDDefinition
  Birch and Swinnerton-Dyer definition
-/

import MetaMillennium.Core.TheoryAndModel

namespace MetaMillennium.Problems.BSD

open MetaMillennium.Core

/-- An elliptic curve over ℚ (abstract) -/
structure EllipticCurve where
  /-- Curve identifier -/
  id : Nat
  /-- Coefficients (in Weierstrass form) -/
  a1 : Int
  a2 : Int
  a3 : Int
  a4 : Int
  a6 : Int

/-- The Mordell-Weil group E(ℚ) -/
-- The group of rational points on E
structure MordellWeilGroup (E : EllipticCurve) where
  /-- The rank (number of independent generators) -/
  rank : Nat

/-- The L-function of an elliptic curve -/
structure LFunction (E : EllipticCurve) where
  /-- Order of vanishing at s = 1 -/
  analytic_rank : Nat

/-- BSD Conjecture for a curve -/
def BSD_for_curve (E : EllipticCurve) : Prop :=
  ∀ MW : MordellWeilGroup E, ∀ L : LFunction E,
    MW.rank = L.analytic_rank

/-- BSD Conjecture (full) -/
def BSD_full : Prop :=
  ∀ E : EllipticCurve, BSD_for_curve E

/-- BSD as a sentence -/
def phi_BSD : Sentence := {
  id := 1004
  repr := "∀E/ℚ: rank(E(ℚ)) = ord_{s=1} L(E,s)"
}

/-- Known cases: rank 0 and 1 -/
-- BSD is known for curves of analytic rank 0 or 1 (Gross-Zagier, Kolyvagin)
axiom BSD_rank_0_1 :
  ∀ E : EllipticCurve, ∀ L : LFunction E,
    L.analytic_rank ≤ 1 → BSD_for_curve E

end MetaMillennium.Problems.BSD
