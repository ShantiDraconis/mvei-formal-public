import Mathlib.Data.Real.Basic
import Mathlib.Data.Finset.Basic
import FormalSuite.I.Universal.Semantics

namespace FormalSuite.I.Universal

/-- One petal in a d-rose. -/
structure RosePetal where
  u : ℕ
  v : ℕ
  u_pos : 0 < u
  v_pos : 0 < v

/-- Data needed to build the weighted modular bilinear scalar S_N. -/
structure SNMultistateData where
  scales : ℕ → Finset ℕ
  petals : ℕ → ℕ → Finset RosePetal
  coeff : ℕ → ℕ → ℝ
  V : ℕ → ℕ → ℝ

/-- Contribution of one petal (u,v) in the d-fiber. -/
noncomputable def petalContribution
    (R : SNMultistateData) (N d : ℕ) (p : RosePetal) : ℝ :=
  R.coeff N (d * p.u) * R.coeff N (d * p.v) *
    (R.V p.v p.u + R.V p.u p.v) /
    ((p.u : ℝ) * (p.v : ℝ))

/-- One d-indexed rose/fiber. -/
noncomputable def roseFiber
    (R : SNMultistateData) (N d : ℕ) : ℝ :=
  (1 / (d : ℝ)) * ∑ p ∈ R.petals N d, petalContribution R N d p

/-- Scalar projection obtained by aggregating all active d-states. -/
noncomputable def SN
    (R : SNMultistateData) (N : ℕ) : ℝ :=
  Real.log N * ∑ d ∈ R.scales N, roseFiber R N d

theorem SN_eq_rose_sum (R : SNMultistateData) (N : ℕ) :
    SN R N = Real.log N * ∑ d ∈ R.scales N, roseFiber R N d := by
  rfl

theorem roseFiber_eq_petal_sum (R : SNMultistateData) (N d : ℕ) :
    roseFiber R N d =
      (1 / (d : ℝ)) * ∑ p ∈ R.petals N d, petalContribution R N d p := by
  rfl

/-- Explicit epsilon formulation of S_N tending to zero. -/
def SNVanishes (R : SNMultistateData) : Prop :=
  ∀ ε : ℝ, 0 < ε → ∃ N₀ : ℕ, ∀ N : ℕ, N₀ ≤ N → |SN R N| ≤ ε

/-- The exact OPEN_MATH_CORE proposition. -/
def WEIGHTED_MODULAR_BILINEAR_DECAY (R : SNMultistateData) : Prop :=
  ∃ ε : ℕ → ℝ,
    (∀ N, |SN R N| ≤ ε N) ∧
    (∀ δ : ℝ, 0 < δ → ∃ N₀ : ℕ, ∀ N : ℕ, N₀ ≤ N → ε N ≤ δ)

/-- Wiring theorem: the missing bound, if supplied, forces S_N to vanish. -/
theorem weighted_modular_bilinear_decay_implies_SN_vanishes
    (R : SNMultistateData)
    (h : WEIGHTED_MODULAR_BILINEAR_DECAY R) :
    SNVanishes R := by
  rcases h with ⟨ε, hbound, hε⟩
  intro δ hδ
  rcases hε δ hδ with ⟨N₀, hN₀⟩
  exact ⟨N₀, fun N hN => le_trans (hbound N) (hN₀ N hN)⟩

inductive GapShape where
  | F1_VANISHING
  | F2_POSITIVE_GAP
  | F3_WITNESS
  | F4_REALIZATION
  | F5_EQUALITY_DEFECT
  | F6_EXCLUSION
  | F7_COMPACTNESS
  | F8_FIXED_POINT
  | F10_MOBIUS_GCD
  | F12_OPERATOR
  | F13_SPECTRAL
  | F14_TELESCOPING
deriving DecidableEq, Repr

def SNGapShape : GapShape := .F1_VANISHING

inductive SNStage where
  | startClosed
  | middleClosed
  | terminalOpen
deriving DecidableEq, Repr

def nextStage : SNStage → SNStage
  | .startClosed => .middleClosed
  | .middleClosed => .terminalOpen
  | .terminalOpen => .terminalOpen

theorem zero_one_two_chain :
    nextStage .startClosed = .middleClosed ∧
    nextStage .middleClosed = .terminalOpen := by
  exact ⟨rfl, rfl⟩

/-- Supplying an inhabitant is exactly the still-open analytic obligation. -/
structure WeightedModularBilinearDecayCertificate
    (R : SNMultistateData) where
  decay : WEIGHTED_MODULAR_BILINEAR_DECAY R

theorem certificate_closes_terminal_gap
    (R : SNMultistateData)
    (cert : WeightedModularBilinearDecayCertificate R) :
    SNVanishes R :=
  weighted_modular_bilinear_decay_implies_SN_vanishes R cert.decay

#print axioms SN_eq_rose_sum
#print axioms weighted_modular_bilinear_decay_implies_SN_vanishes
#print axioms certificate_closes_terminal_gap

end FormalSuite.I.Universal
