/-
  HGEU.Basic - Basic definitions and types
  
  Core types and structures for the HGEU framework.
-/

import Mathlib.Analysis.Complex.Basic
import Mathlib.Data.Real.Basic
import Mathlib.Data.Complex.Basic
import Mathlib.Topology.Basic

namespace HGEU

/-- Complex number in the critical strip -/
structure ComplexPoint where
  σ : ℝ  -- Real part
  t : ℝ  -- Imaginary part
  deriving Repr

/-- Convert ComplexPoint to Complex number -/
def ComplexPoint.toComplex (s : ComplexPoint) : ℂ :=
  ⟨s.σ, s.t⟩

/-- Truncation parameter for operators -/
structure TruncationParam where
  N : ℕ
  N_pos : 0 < N
  deriving Repr

/-- Scale parameter for structural analysis -/
structure ScaleParam where
  n : ℕ
  n_pos : 0 < n
  deriving Repr

/-- Configuration parameters for stability potential -/
structure PotentialConfig where
  α : ℝ  -- Quadratic coefficient
  β : ℝ  -- Logarithmic coefficient
  α_pos : 0 < α
  β_pos : 0 < β

/-- Critical line: σ = 1/2 -/
def criticalLine : Set ComplexPoint :=
  {s : ComplexPoint | s.σ = 1/2}

/-- Check if point is on critical line -/
def isOnCriticalLine (s : ComplexPoint) : Prop :=
  s.σ = 1/2

/-- Distance from critical line -/
def distanceFromCriticalLine (s : ComplexPoint) : ℝ :=
  |s.σ - 1/2|

/-- Critical strip: 0 < σ < 1 -/
def criticalStrip : Set ComplexPoint :=
  {s : ComplexPoint | 0 < s.σ ∧ s.σ < 1}

/-- Known Riemann zero (on critical line) -/
structure RiemannZero where
  t : ℝ
  t_pos : 0 < t
  -- In full formalization, would include proof that ζ(1/2 + it) = 0

/-- Convert Riemann zero to ComplexPoint -/
def RiemannZero.toPoint (z : RiemannZero) : ComplexPoint :=
  ⟨1/2, z.t⟩

end HGEU
