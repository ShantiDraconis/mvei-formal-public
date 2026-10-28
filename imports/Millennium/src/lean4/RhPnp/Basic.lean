/-
  RhPnp/Basic.lean

  Basic definitions for the RH ↔ P vs NP Equivalence Framework.

  This file contains foundational definitions shared across the framework.
-/

namespace RhPnp

/-!
# Basic Definitions

This module provides basic type definitions and utilities used throughout
the RH ↔ P vs NP framework.
-/

/-- A real number representing a complexity exponent. -/
abbrev ComplexityExponent := Float

/-- A real number representing a delta (gap) value. -/
abbrev DeltaValue := Float

/-- The critical value 1/2 from the Riemann Hypothesis. -/
def criticalRealPart : Float := 0.5

/-- Check if a delta value represents "vanishing" (is approximately zero). -/
def isVanishing (δ : DeltaValue) (tolerance : Float := 1e-10) : Bool :=
  Float.abs δ < tolerance

/-- The result of a gap analysis. -/
structure GapAnalysis where
  value : DeltaValue
  isZero : Bool
  description : String

/-- Create a gap analysis from a delta value. -/
def analyzeGap (δ : DeltaValue) (name : String) : GapAnalysis :=
  { value := δ
  , isZero := isVanishing δ
  , description := s!"{name}: Δ = {δ}, vanishes = {isVanishing δ}"
  }

end RhPnp
