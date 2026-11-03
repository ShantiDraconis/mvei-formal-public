/-
  HEU-7 Framework: Core Ordinal Definitions
  
  This module provides the foundational ordinal theory for the HEU framework.
  We use Mathlib's ordinal definitions as our base.
-/

import Mathlib.SetTheory.Ordinal.Basic
import Mathlib.SetTheory.Ordinal.Arithmetic

namespace HEU.Core

/-- The first infinite ordinal (natural numbers) -/
abbrev omega : Ordinal := Ordinal.omega

/-- Successor ordinal -/
def succ (α : Ordinal) : Ordinal := Order.succ α

/-- Limit ordinals: ordinals that are not zero and not successors.
    Note: This is compatible with mathlib's Ordinal.IsLimit. -/
def IsLimitOrd (α : Ordinal) : Prop := α ≠ 0 ∧ ∀ β < α, succ β < α

/-- Check if an ordinal is finite (less than ω) -/
def IsFinite (α : Ordinal) : Prop := α < omega

/-- The ordinal ω^ω -/
def omega_pow_omega : Ordinal := omega ^ omega

/-- The ordinal ε₀ (first epsilon number) -/
def epsilon_zero : Ordinal := Ordinal.epsilon 0

/-- Natural embedding of ℕ into ordinals -/
def natToOrd (n : ℕ) : Ordinal := n

/-- Ordinal 1 -/
def one : Ordinal := 1

/-- Ordinal 2 -/
def two : Ordinal := 2

theorem omega_ne_zero : omega ≠ 0 := Ordinal.omega_ne_zero

theorem omega_isLimitOrd : IsLimitOrd omega := by
  constructor
  · exact omega_ne_zero
  · intro β hβ
    simp [succ, Order.succ]
    exact Ordinal.succ_lt_omega hβ

theorem finite_lt_omega {n : ℕ} : natToOrd n < omega := by
  simp [natToOrd]
  exact Ordinal.nat_lt_omega n

end HEU.Core
