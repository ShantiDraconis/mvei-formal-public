-- FORMAL/Lean4/Core/ToyModel.lean
-- The two-element toy model M_2 = {0, I}.
-- Cross-reference: FOUNDATIONS/consistency_notes.tex, Section 4.

import Universe
import MillenniumCore.Core.Universe

namespace MillenniumCore.ToyModel

open UI

/-!
# Two-Element Toy Model M₂ = {0, I}

This file defines the minimal toy model for U_I, useful for sanity-checking
the axioms and for illustrating the collapse behaviour of I.

In M₂:
- The only "real" value is 0 (all other reals are collapsed to 0).
- The only other element is I.

This is NOT the intended semantic model; it is a proof-of-concept that the
axiom system is satisfiable.
-/

/-- The two elements of M₂. -/
inductive M₂
  | zero : M₂
  | ind  : M₂

namespace M₂

/-- Addition in M₂. -/
def add : M₂ → M₂ → M₂
  | zero, zero => zero
  | _,    _    => ind

/-- Multiplication in M₂. -/
def mul : M₂ → M₂ → M₂
  | zero, zero => zero
  | _,    _    => ind

/-- Division in M₂: the key collapse rule 0/0 = I. -/
def div : M₂ → M₂ → M₂
  | _, _ => ind   -- all divisions produce I in this toy model

infixl:65 " +₂ " => add
infixl:70 " *₂ " => mul
infixl:70 " /₂ " => div

/-- 0/0 = I in M₂. -/
theorem zero_div_zero_m2 : M₂.zero /₂ M₂.zero = M₂.ind := by
  simp [div]

/-- I absorbs addition in M₂. -/
theorem ind_add_absorb (x : M₂) : M₂.ind +₂ x = M₂.ind := by
  cases x <;> simp [add]

/-- Commutativity of addition in M₂. -/
theorem add_comm (x y : M₂) : x +₂ y = y +₂ x := by
  cases x <;> cases y <;> simp [add]

end M₂
end MillenniumCore.ToyModel
