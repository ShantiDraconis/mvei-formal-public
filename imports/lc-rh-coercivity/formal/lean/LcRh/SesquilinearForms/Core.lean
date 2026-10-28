/-
Sesquilinear form placeholders supporting coercivity estimates.
-/
import Mathlib.Data.Complex.Basic

namespace LcRh.SesquilinearForms

structure SesqForm (α : Type) where
  form : α → α → ℂ

def conj_linear_left {α} (F : SesqForm α) : Prop := True

def linear_right {α} (F : SesqForm α) : Prop := True

def positive_definite {α} (F : SesqForm α) : Prop := True

end LcRh.SesquilinearForms
