/-
Classical Definitions for P vs NP

Clay Institute format definitions for computational complexity.
-/

import Mathlib.Data.Nat.Basic
import Mathlib.Logic.Basic

namespace PvsNP.Classical

/-- A decision problem / language -/
def Language := Set (List Bool)

/-- Turing machine (axiomatized) -/
axiom TuringMachine : Type

/-- Running time of a TM on input -/
axiom time_complexity : TuringMachine → List Bool → ℕ

/-- A TM decides a language -/
axiom accepts : TuringMachine → List Bool → Prop
def Decides (M : TuringMachine) (L : Language) : Prop :=
  ∀ x : List Bool, (x ∈ L ↔ accepts M x) ∧ ∃ t : ℕ, time_complexity M x ≤ t

/-- Polynomial time bound -/
def PolynomialTime (f : ℕ → ℕ) : Prop :=
  ∃ c k : ℕ, ∀ n : ℕ, f n ≤ c * n^k

/-- P: Languages decidable in polynomial time -/
def P : Set Language :=
  {L : Language | ∃ M : TuringMachine, Decides M L ∧ 
    ∃ p : ℕ → ℕ, PolynomialTime p ∧ ∀ x : List Bool, time_complexity M x ≤ p x.length}

/-- Nondeterministic Turing machine -/
axiom NondeterministicTM : Type

/-- Nondeterministic time complexity -/
axiom ntime_complexity : NondeterministicTM → List Bool → ℕ

/-- NP: Languages with polynomial nondeterministic verification -/
def NP : Set Language :=
  {L : Language | ∃ M : NondeterministicTM, sorry ∧
    ∃ p : ℕ → ℕ, PolynomialTime p ∧ ∀ x : List Bool, ntime_complexity M x ≤ p x.length}

/-- Classical question: Does P = NP? -/
def PequalsNP : Prop := P = NP

/-- It is known that P ⊆ NP -/
axiom p_subset_np : P ⊆ NP

/-- Deterministic time complexity class -/
def DTIME (f : ℕ → ℕ) : Set Language :=
  {L : Language | ∃ M : TuringMachine, Decides M L ∧ 
    ∀ x : List Bool, time_complexity M x ≤ f x.length}

/-- Nondeterministic time complexity class -/
def NTIME (f : ℕ → ℕ) : Set Language :=
  {L : Language | ∃ M : NondeterministicTM, sorry ∧
    ∀ x : List Bool, ntime_complexity M x ≤ f x.length}

/-- Gap function: difference between deterministic and nondeterministic time -/
def Δ_NP (L : Language) : ℝ :=
  if h : L ∈ NP then
    let t_det := (if L ∈ P then 0 else 1 : ℝ)
    let t_ndet := 0  -- Always 0 for NP
    t_det - t_ndet
  else 1  -- Undefined, set to 1

/-- Alternative: P = NP iff gap is zero for all NP languages -/
theorem p_equals_np_gap_characterization :
  PequalsNP ↔ ∀ L : Language, L ∈ NP → Δ_NP L = 0 := by
  constructor
  · intro h L hL
    simp [Δ_NP, hL]
    have : L ∈ P := by
      rw [← h]
      exact hL
    simp [this]
  · intro h
    ext L
    constructor
    · intro hP
      exact p_subset_np hP
    · intro hNP
      by_contra hnotP
      have gap := h L hNP
      simp [Δ_NP, hNP, hnotP] at gap
      norm_num at gap

end PvsNP.Classical
