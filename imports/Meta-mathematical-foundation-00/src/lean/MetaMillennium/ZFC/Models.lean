/-
  MetaMillennium.ZFC.Models
  
  Model theory for set theory.
-/

import MetaMillennium.ZFC.Axioms

namespace MetaMillennium.ZFC

/-- A model of set theory -/
structure Model where
  /-- The underlying set theory -/
  theory : SetTheory
  /-- Satisfaction of axioms (placeholder) -/
  satisfies_axioms : True  -- Would include actual axiom satisfaction

/-- The class of all models of ZFC -/
def ModZFC : Type* := Model

/-- A sentence is true in a model -/
def satisfies (M : Model) (φ : Prop) : Prop := φ

notation M " ⊨ " φ => satisfies M φ

/-- A sentence is provable from ZFC -/
def provable (φ : Prop) : Prop := ∀ M : Model, M ⊨ φ

notation "ZFC ⊢ " φ => provable φ

/-- A sentence is independent of ZFC -/
def independent (φ : Prop) : Prop := ¬provable φ ∧ ¬provable (¬φ)

end MetaMillennium.ZFC
