/-
Copyright (c) 2024 Universal Emergent Logic Project. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.

# Navier-Stokes - Foundations
-/

import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Analysis.InnerProductSpace.Basic

namespace NavierStokes

/-- 3D Euclidean space -/
abbrev ℝ³ := Fin 3 → ℝ

/-- Velocity field -/
def VelocityField := ℝ³ → ℝ → ℝ³

/-- Pressure field -/
def PressureField := ℝ³ → ℝ → ℝ

/-- Initial data -/
structure InitialData where
  u₀ : ℝ³ → ℝ³
  smooth : sorry
  divergence_free : sorry

/-- Viscosity constant -/
axiom ν : ℝ
axiom ν_pos : ν > 0

/-- Sobolev spaces -/
def H¹ : Type := sorry
def H² : Type := sorry

end NavierStokes
