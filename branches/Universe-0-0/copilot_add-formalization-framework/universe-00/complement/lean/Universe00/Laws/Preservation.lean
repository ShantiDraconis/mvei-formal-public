/-
  Universe00/Laws/Preservation.lean
  
  Law L — Preservation Law
  
  If continuation violates consistency in a regime,
  the system MUST return a limit state, not a value.
  
  This is the fundamental safety property:
  "When you hit a boundary, return limit, not crash."
-/

import Universe00.Core.Outcome
import Universe00.Core.Regime

namespace Universe00.Laws

open Universe00.Core

/-- 
  Predicate: is it safe to continue an operation in regime D?
  
  This is regime-specific. For example:
  - In Classical regime: SafeToContinue (div a b) ↔ b ≠ 0
  - In Extreme regime: Always check for limit conditions
-/
def SafeToContinue {α β : Type} (D : Regime) (op : α → β → Outcome γ) (a : α) (b : β) : Prop :=
  match D with
  | Regime.Classical => 
      -- Classical: no undefined operations
      ∃ (result : γ), op a b = Outcome.value result
  | Regime.Extreme =>
      -- Extreme: operations can hit limits
      (∃ (result : γ), op a b = Outcome.value result) ∨
      (∃ (ℓ : LimitState), op a b = Outcome.limit ℓ)
  | _ => 
      -- Other regimes: default to existence of some outcome
      True

/--
  Law L — Preservation Law (Axiom)
  
  If it's not safe to continue, the operation MUST return a limit.
  This prevents undefined behavior and crashes.
-/
axiom PreservationLaw {α β γ : Type} :
  ∀ (D : Regime) (op : α → β → Outcome γ) (a : α) (b : β),
  ¬ SafeToContinue D op a b →
  ∃ (ℓ : LimitState), op a b = Outcome.limit ℓ

/-- 
  Corollary: In Classical regime, undefined operations return limits
-/
theorem classical_undefined_returns_limit {α β γ : Type} :
  ∀ (op : α → β → Outcome γ) (a : α) (b : β),
  (∀ (result : γ), op a b ≠ Outcome.value result) →
  ∃ (ℓ : LimitState), op a b = Outcome.limit ℓ := by
  intro op a b h_no_value
  apply PreservationLaw
  intro h_safe
  cases h_safe
  case intro result h_eq =>
    exact h_no_value result h_eq

/--
  Preservation for specific operations:
  If denominator is zero, division must return limit
-/
axiom division_preservation :
  ∀ (div : ℚ → ℚ → Outcome ℚ) (a : ℚ),
  div a 0 = Outcome.limit LimitState.divisionByZero

end Universe00.Laws
