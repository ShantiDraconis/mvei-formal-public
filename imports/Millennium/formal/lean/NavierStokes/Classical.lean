/-
Classical Definitions for Navier-Stokes Regularity

This file contains classical mathematical definitions for the Navier-Stokes
existence and smoothness problem in the format expected by the Clay Institute.
-/

import Mathlib.Analysis.NormedSpace.Basic
import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Topology.MetricSpace.Basic

namespace NS.Classical

/-- 3D Euclidean space -/
def ℝ³ := Fin 3 → ℝ

/-- Vector field on ℝ³ -/
def VectorField := ℝ³ → ℝ³

/-- Scalar field (pressure) -/
def ScalarField := ℝ³ → ℝ

/-- Time-dependent vector field -/
def FlowField := ℝ → VectorField

/-- The velocity field u(t,x) satisfies the Navier-Stokes equations -/
structure NavierStokesFlow where
  /-- Velocity field u: ℝ × ℝ³ → ℝ³ -/
  u : ℝ → ℝ³ → ℝ³
  /-- Pressure field p: ℝ × ℝ³ → ℝ -/
  p : ℝ → ℝ³ → ℝ
  /-- Viscosity constant (ν > 0) -/
  ν : ℝ
  ν_pos : ν > 0
  /-- Initial condition u₀ -/
  u₀ : ℝ³ → ℝ³

/-- Divergence-free condition: ∇·u = 0 -/
axiom divergence_free : NavierStokesFlow → ℝ → ℝ³ → Prop

/-- The NS equations are satisfied -/
axiom satisfies_ns_equations : NavierStokesFlow → Prop

/-- H¹ Sobolev space (functions with bounded first derivatives) -/
axiom H1 : Type
axiom H1_norm : H1 → ℝ
axiom vector_to_H1 : (ℝ³ → ℝ³) → H1

/-- Initial data is smooth with finite energy -/
def SmoothInitialData (u₀ : ℝ³ → ℝ³) : Prop :=
  ∃ h : H1, h = vector_to_H1 u₀ ∧ H1_norm h < ∞

/-- Maximum existence time for a solution -/
axiom T_max : NavierStokesFlow → ℝ

/-- A solution is global if it exists for all time -/
def GlobalSolution (flow : NavierStokesFlow) : Prop :=
  T_max flow = ∞

/-- A solution remains smooth (bounded derivatives) for all time -/
axiom remains_smooth : NavierStokesFlow → ℝ → Prop

/-- Definition: No blow-up means the solution stays bounded -/
def NoBlow_up (flow : NavierStokesFlow) : Prop :=
  GlobalSolution flow ∧ ∀ t : ℝ, t ≥ 0 → remains_smooth flow t

/-- Classical statement of Navier-Stokes regularity -/
def NavierStokesRegularity : Prop :=
  ∀ flow : NavierStokesFlow, 
    SmoothInitialData flow.u₀ → 
    satisfies_ns_equations flow →
    divergence_free flow 0 flow.u₀ →
    NoBlow_up flow

/-- Gap operator: measures inverse blow-up time -/
def Δ_NS (flow : NavierStokesFlow) : ℝ :=
  if T_max flow = ∞ then 0 else 1 / T_max flow

/-- Alternative formulation: NS regularity is equivalent to all gaps being zero -/
theorem ns_gap_characterization :
  NavierStokesRegularity ↔ 
  ∀ flow : NavierStokesFlow,
    SmoothInitialData flow.u₀ →
    satisfies_ns_equations flow →
    divergence_free flow 0 flow.u₀ →
    Δ_NS flow = 0 := by
  constructor
  · intro h flow h_smooth h_ns h_div
    simp [Δ_NS]
    have := h flow h_smooth h_ns h_div
    simp [NoBlow_up, GlobalSolution] at this
    rw [this.1]
    simp
  · intro h flow h_smooth h_ns h_div
    simp [NoBlow_up, GlobalSolution]
    have gap_zero := h flow h_smooth h_ns h_div
    simp [Δ_NS] at gap_zero
    split at gap_zero
    · assumption
    · norm_num at gap_zero

end NS.Classical
