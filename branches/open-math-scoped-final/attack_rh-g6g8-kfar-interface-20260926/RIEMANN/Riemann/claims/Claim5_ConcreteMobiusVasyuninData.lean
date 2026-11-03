import Riemann.claims.Claim5_BalancedMobiusEstermannHabitant
import Mathlib.NumberTheory.ArithmeticFunction.Moebius
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic

namespace Riemann.claims

open scoped BigOperators
open scoped ArithmeticFunction.Moebius

/-- Exact finite Vasyunin cotangent sum. -/
noncomputable def vasyuninSum (p q : ℕ) : ℝ :=
  ∑ k in Finset.Icc 1 (q - 1),
    (((k * p) % q : ℕ) : ℝ) / (q : ℝ) *
      Real.cot (Real.pi * (k : ℝ) / (q : ℝ))

/-- Symmetric arithmetic kernel used by the frozen S_N route. -/
noncomputable def vasyuninSymmetricKernel (u v : ℕ) : ℝ :=
  if u = 0 ∨ v = 0 then 0
  else
    (vasyuninSum v u + vasyuninSum u v) / ((u : ℝ) * (v : ℝ))

/-- Explicit logarithmic taper. This is the linear BCF-style taper;
    no asymptotic property is assumed here. -/
noncomputable def mobiusLinearTaper (N n : ℕ) : ℝ :=
  if h : 1 ≤ n ∧ n ≤ N ∧ 1 < N then
    (Real.log N - Real.log n) / Real.log N
  else 0

/-- Exact real coefficient c_{N,n} = -mu(n) w_N(n). -/
noncomputable def mobiusTaperCoeff (N n : ℕ) : ℝ :=
  -((ArithmeticFunction.moebius n : ℤ) : ℝ) * mobiusLinearTaper N n

/-- Exact primitive/FAR selector for one gcd layer. -/
def balancedFarActive (delta : ℝ) (N d u v : ℕ) : Bool :=
  decide (
    Nat.Coprime (u + 1) (v + 1) ∧
    (d + 1) * (u + 1) ≤ N ∧
    (d + 1) * (v + 1) ≤ N ∧
    delta <
      |Real.log (((u + 1 : ℕ) : ℝ) / ((v + 1 : ℕ) : ℝ))|
  )

/-- Concrete multi-state datum for the explicit Möbius-taper / Vasyunin route. -/
noncomputable def concreteMobiusVasyuninData (delta : ℝ) : MultiStateSNData :=
  {
    coeff := mobiusTaperCoeff
    kernel := vasyuninSymmetricKernel
    active := balancedFarActive delta
  }

/-- The exact concrete epsilon attacked by the open-math decay theorem. -/
noncomputable def concreteBalancedBlockEps (delta : ℝ) : ℕ → ℝ :=
  balancedBlockEps (concreteMobiusVasyuninData delta)

/-- This is the sole mathematical target for the concrete explicit route. -/
def CONCRETE_BALANCED_MOBIUS_ESTERMANN_DECAY (delta : ℝ) : Prop :=
  Filter.Tendsto (concreteBalancedBlockEps delta) Filter.atTop (nhds 0)

/-- No new mathematics: once the concrete decay theorem exists, it inhabits
    the already-certified PACK. -/
noncomputable def concreteHabitantOfDecay
    (delta : ℝ)
    (hdecay : CONCRETE_BALANCED_MOBIUS_ESTERMANN_DECAY delta) :
    BalancedMobiusEstermannHabitant (concreteMobiusVasyuninData delta) :=
  { decay := hdecay }

theorem concreteDecay_closes_weighted_modular
    (delta : ℝ)
    (hdecay : CONCRETE_BALANCED_MOBIUS_ESTERMANN_DECAY delta) :
    WEIGHTED_MODULAR_BILINEAR_DECAY (concreteMobiusVasyuninData delta) :=
  (concreteHabitantOfDecay delta hdecay).closes_weighted_modular_decay

def CONCRETE_BALANCED_MOBIUS_ESTERMANN_STATE : String :=
  "OPEN_MATH_CORE__ONLY_DECAY_UNINHABITED"

#print axioms concreteDecay_closes_weighted_modular


theorem concrete_global_eq_explicit
    (delta : ℝ)
    (N : ℕ) :
    (concreteMobiusVasyuninData delta).global N =
      Real.log N *
        ∑ d in Finset.range N,
          ((1 : ℝ) / (d + 1 : ℝ)) *
            (∑ u in Finset.range N,
              ∑ v in Finset.range N,
                if balancedFarActive delta N d u v then
                  mobiusTaperCoeff N ((d + 1) * (u + 1)) *
                  mobiusTaperCoeff N ((d + 1) * (v + 1)) *
                  vasyuninSymmetricKernel (u + 1) (v + 1)
                else 0) := by
  rfl

#print axioms concrete_global_eq_explicit


theorem vasyuninSymmetricKernel_two_three :
    vasyuninSymmetricKernel 2 3 = 1 / (18 * Real.sqrt 3) := by
  unfold vasyuninSymmetricKernel vasyuninSum
  norm_num [Real.cot_eq_cos_div_sin]
  rw [show (2 * Real.pi) / 3 = Real.pi - Real.pi / 3 by ring]
  simp [Real.sin_pi_sub, Real.cos_pi_sub, Real.cot_eq_cos_div_sin]
  ring

theorem vasyuninSymmetricKernel_two_three_ne_zero :
    vasyuninSymmetricKernel 2 3 ≠ 0 := by
  rw [vasyuninSymmetricKernel_two_three]
  have hs : Real.sqrt 3 ≠ 0 := by positivity
  positivity

#print axioms vasyuninSymmetricKernel_two_three

end Riemann.claims
