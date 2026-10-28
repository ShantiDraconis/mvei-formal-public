/-
  AntiRHDefinitions.lean
  ======================
  Lean 4 definitions for the anti-RH working hypothesis and its
  structural consequences.

  These definitions formalise the computational scenarios in
  `anti_rh/core/hypothesis_engine.py`.

  Working hypothesis
  ------------------
    ∃ ρ = β + iγ  with  ζ(ρ) = 0,  0 < β < 1,  β ≠ 1/2.
-/

import Mathlib.Data.Real.Basic
import RHFramework

namespace AntiRHDefinitions

open RHFramework

/-! ## Scenario types -/

/-- A scenario assigns a displacement Δ to each zero index. -/
structure Scenario where
  /-- Name of the scenario. -/
  name : String
  /-- The list of zeros. -/
  zeros : List NonTrivialZero
  /-- Description of the working hypothesis. -/
  description : String

/-- The RH-baseline scenario: all Δ = 0. -/
def rhBaseline (zeros : List NonTrivialZero)
    (h : ∀ ρ ∈ zeros, ρ.beta = 0.5) : Scenario :=
  { name := "rh_baseline",
    zeros := zeros,
    description := "All zeros on the critical line. Δ ≡ 0." }

/--
  The minimal anti-RH scenario: exactly one zero has Δ ≠ 0.
-/
def antiRHMinimal
    (ρ_off : NonTrivialZero)
    (hOff : ρ_off.beta ≠ 0.5)
    (remaining : List NonTrivialZero) : Scenario :=
  { name := "anti_rh_minimal",
    zeros := ρ_off :: remaining,
    description :=
      s!"Exactly one off-critical zero with β = {ρ_off.beta}. All others satisfy RH." }

/-! ## Displacement analysis -/

/-- All Δ values in a scenario. -/
def allDeltas (s : Scenario) : List Float :=
  s.zeros.map Delta

/-- Count off-critical zeros in a scenario. -/
def countOffLine (s : Scenario) : Nat :=
  (s.zeros.filter (fun ρ => ρ.beta != 0.5)).length

/-- A scenario is RH-consistent iff all its zeros are on the critical line. -/
def isRHConsistent (s : Scenario) : Prop :=
  ∀ ρ ∈ s.zeros, ρ.beta = 0.5

/-- A scenario is anti-RH-minimal iff exactly one zero is off the line. -/
def isAntiRHMinimal (s : Scenario) : Prop :=
  ∃! ρ ∈ s.zeros, ρ.beta ≠ 0.5

/-! ## Quartet symmetry -/

/--
  The symmetric counterpart of a zero under the functional equation.
  If ρ = β + iγ, then the image is 1−β + iγ.
-/
noncomputable def functionalImage (ρ : NonTrivialZero) : NonTrivialZero :=
  { beta  := 1 - ρ.beta,
    gamma := ρ.gamma,
    hBeta := by
      constructor
      · linarith [ρ.hBeta.2]
      · linarith [ρ.hBeta.1],
    hGamma := ρ.hGamma }

/-- The midpoint between ρ and its functional image is always 1/2. -/
theorem midpoint_is_half (ρ : NonTrivialZero) :
    (ρ.beta + (functionalImage ρ).beta) / 2 = 0.5 := by
  simp [functionalImage]
  ring

/-- Δ and −Δ are the displacements of a ρ and its functional image. -/
theorem delta_opposite (ρ : NonTrivialZero) :
    Delta (functionalImage ρ) = -(Delta ρ) := by
  simp [functionalImage, Delta]
  ring

end AntiRHDefinitions
