/-
  HEU-7: Ordinal Theory
  Core definitions for ordinals used in the HEU framework.
-/

import Mathlib.SetTheory.Ordinal.Basic
import Mathlib.SetTheory.Ordinal.Arithmetic

namespace HEU.Core

/-- The class of ordinals. -/
abbrev Ord := Ordinal

/-- Zero ordinal. -/
def zero : Ord := 0

/-- The first infinite ordinal ω. -/
def omega : Ord := Ordinal.omega

/-- Ordinal ω^ω, used as critical level for P vs NP. -/
def omega_omega : Ord := omega ^ omega

/-- The ordinal ε₀, first fixed point of α ↦ ω^α. -/
noncomputable def epsilon_zero : Ord := Ordinal.epsilon 0

/-- Ordinal comparison: α < λ (threshold condition). -/
def below_threshold (α λ : Ord) : Prop := α < λ

/-- Ordinal comparison: α = 0 (exact equality for RH, BSD). -/
def is_zero (α : Ord) : Prop := α = 0

/-- Ordinal comparison: α = ω₁ (no finite blowup for NS). -/
noncomputable def omega_one : Ord := Ordinal.omega1

theorem zero_below_omega : below_threshold zero omega := by
  unfold below_threshold zero omega
  exact Ordinal.pos_iff_ne_zero.mpr (ne_of_gt Ordinal.omega_pos)

theorem omega_below_omega_omega : below_threshold omega omega_omega := by
  unfold below_threshold omega omega_omega
  exact Ordinal.omega_lt_omega_opow Ordinal.one_lt_omega

end HEU.Core
