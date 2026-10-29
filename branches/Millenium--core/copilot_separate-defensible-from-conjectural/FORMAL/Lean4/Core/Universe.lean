-- FORMAL/Lean4/Core/Universe.lean
-- Core type definition for the Indeterminate Framework U_I.
-- This file encodes the ontological layer (FOUNDATIONS/ontology.tex)
-- as a Lean 4 inductive type.

import Mathlib.Data.Real.Basic

/-!
# The Universe U_I

We define the extended universe `UI` as an inductive type with four
constructors corresponding to the four ontological categories:
- `Real r` : classical real number
- `Ind`    : the indeterminate element I = 0/0
- `Meta`   : meta-arithmetic states (0_I, ∞_I)
- `Undef`  : undecidable state U
-/

namespace MillenniumCore

/-- Meta-arithmetic states beyond I. -/
inductive MetaState
  | Zero   : MetaState   -- 0_I
  | Infty  : MetaState   -- ∞_I

/-- The extended universe U_I. -/
inductive UI
  | Real  : ℝ → UI          -- classical real numbers
  | Ind   : UI               -- the indeterminate element I
  | Meta  : MetaState → UI   -- meta-arithmetic states
  | Undef : UI               -- undecidable state U

namespace UI

/-- Notations -/
notation "𝕀" => UI.Ind
notation "𝟘ᵢ" => UI.Meta MetaState.Zero
notation "∞ᵢ" => UI.Meta MetaState.Infty

/-- Classical embedding ι : ℝ → UI. -/
def ofReal (r : ℝ) : UI := UI.Real r

instance : Coe ℝ UI := ⟨ofReal⟩

/-- I is not a real number. -/
theorem ind_not_real (r : ℝ) : UI.Ind ≠ UI.Real r := by
  intro h; cases h

/-- Classical elements are distinct from I. -/
theorem real_ne_ind (r : ℝ) : UI.Real r ≠ UI.Ind := by
  intro h; cases h

/-! ## Extended Arithmetic Operations -/

/-- Extended addition. -/
def add : UI → UI → UI
  | Real a,  Real b  => Real (a + b)
  | Ind,     _       => Ind
  | _,       Ind     => Ind
  | Meta m,  _       => Meta m   -- conservative stub
  | _,       Meta m  => Meta m
  | Undef,   _       => Undef
  | _,       Undef   => Undef

/-- Extended multiplication. -/
def mul : UI → UI → UI
  | Real a,  Real b  => Real (a * b)
  | Ind,     _       => Ind
  | _,       Ind     => Ind
  | Meta m,  _       => Meta m
  | _,       Meta m  => Meta m
  | Undef,   _       => Undef
  | _,       Undef   => Undef

/-- Extended division — the key operation.
    0 / 0 = I  (the fundamental collapse rule) -/
def div : UI → UI → UI
  | Real a,  Real b  =>
      if b = 0 then
        if a = 0 then Ind          -- 0/0 = I
        else Meta MetaState.Infty  -- a/0 = ∞_I for a ≠ 0
      else Real (a / b)            -- classical division
  | Ind,     _       => Ind
  | _,       Ind     => Ind
  | Meta m,  _       => Meta m
  | _,       Meta m  => Meta m
  | Undef,   _       => Undef
  | _,       Undef   => Undef

infixl:65 " +ᵢ " => add
infixl:70 " *ᵢ " => mul
infixl:70 " /ᵢ " => div

/-! ## Key Theorems -/

/-- The fundamental collapse: 0/0 = I. -/
theorem zero_div_zero : UI.Real 0 /ᵢ UI.Real 0 = 𝕀 := by
  simp [div]

/-- Classical recovery: for b ≠ 0, Real a / Real b = Real (a/b). -/
theorem classical_div (a b : ℝ) (hb : b ≠ 0) :
    UI.Real a /ᵢ UI.Real b = UI.Real (a / b) := by
  simp [div, hb]

/-- I is not zero. -/
theorem ind_ne_zero : 𝕀 ≠ UI.Real 0 := by
  intro h; cases h

/-- Classical addition is preserved. -/
theorem classical_add (a b : ℝ) :
    UI.Real a +ᵢ UI.Real b = UI.Real (a + b) := by
  simp [add]

end UI
end MillenniumCore
