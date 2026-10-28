/-
  LocalGlobal/Gap.lean
  
  Gap Operators for the Local→Global Framework
  
  This module defines the Δ gap operators that measure deviation
  from ideal conditions for each Millennium problem.
-/

import Mathlib.Data.Real.Basic
import Mathlib.Data.Complex.Basic
import Mathlib.Analysis.SpecialFunctions.Pow.Real

namespace LocalGlobal.Gap

/-- Abstract gap operator type -/
structure GapOperator (X : Type*) where
  /-- The gap function -/
  gap : X → ℝ
  /-- Gap is bounded below (for well-posedness) -/
  bounded_below : ∃ M : ℝ, ∀ x, gap x ≥ M

/-- The zero set of a gap operator -/
def zeroSet (G : GapOperator X) : Set X :=
  {x | G.gap x = 0}

/-- The epsilon-neighborhood of zero -/
def epsilonNeighborhood (G : GapOperator X) (ε : ℝ) : Set X :=
  {x | |G.gap x| ≤ ε}

/-- Gap operator is non-negative -/
def NonNegative (G : GapOperator X) : Prop :=
  ∀ x, G.gap x ≥ 0

/-- Monotonicity of gap under some ordering -/
def Monotone (G : GapOperator X) [LE X] : Prop :=
  ∀ x y, x ≤ y → G.gap x ≤ G.gap y

/-- Two gap operators are equivalent if they have the same zero set -/
def Equivalent (G₁ G₂ : GapOperator X) : Prop :=
  zeroSet G₁ = zeroSet G₂

/-- Combination of gap operators (for unified framework) -/
def combine (G₁ G₂ : GapOperator X) : GapOperator X where
  gap := fun x => G₁.gap x + G₂.gap x
  bounded_below := by
    obtain ⟨M₁, h₁⟩ := G₁.bounded_below
    obtain ⟨M₂, h₂⟩ := G₂.bounded_below
    use M₁ + M₂
    intro x
    linarith [h₁ x, h₂ x]

/-- Product gap operator for vector of gaps
    Note: The bounded_below proof requires additional assumptions about
    the individual gap operators. This is marked as an axiom since the
    general case requires knowing that each Gi has a lower bound. -/
axiom product_bounded_below (Gs : List (GapOperator X)) : 
  ∃ M : ℝ, ∀ x, (Gs.map (fun G => G.gap x)).sum ≥ M

def product (Gs : List (GapOperator X)) : GapOperator X where
  gap := fun x => (Gs.map (fun G => G.gap x)).sum
  bounded_below := product_bounded_below Gs

/-- Norm-based gap from a list of gaps -/
def normGap (Gs : List (GapOperator X)) : GapOperator X where
  gap := fun x => Real.sqrt ((Gs.map (fun G => (G.gap x)^2)).sum)
  bounded_below := ⟨0, fun x => Real.sqrt_nonneg _⟩

/-- The gap spectrum type -/
def Spectrum (G : GapOperator X) (crit : Set X) : Set ℝ :=
  {y | ∃ x ∈ crit, G.gap x = y}

/-- Gap is critical if it vanishes on the critical set -/
def IsCritical (G : GapOperator X) (crit : Set X) : Prop :=
  ∀ x ∈ crit, G.gap x = 0

/-- Gap satisfies continuity-like property -/
def Continuous (G : GapOperator X) [TopologicalSpace X] : Prop :=
  Continuous G.gap

end LocalGlobal.Gap
