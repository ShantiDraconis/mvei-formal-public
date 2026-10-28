/-
  MetaMillennium.ZFC.Independence
  
  Independence concepts for set theory.
-/

import MetaMillennium.ZFC.Models

namespace MetaMillennium.ZFC

/-- Independence witnessed by models -/
theorem independence_iff_models (φ : Prop) :
  independent φ ↔ (∃ M₁ : Model, M₁ ⊨ φ) ∧ (∃ M₂ : Model, M₂ ⊨ ¬φ) := by
  sorry  -- To be proven

/-- Negation preserves independence -/
theorem independence_neg (φ : Prop) :
  independent φ → independent (¬φ) := by
  intro h
  constructor
  · exact h.2
  · push_neg
    exact h.1

end MetaMillennium.ZFC
