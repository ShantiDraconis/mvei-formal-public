/-
  MetaMillennium.DualState.DualStateDefinition
  The Dual-State DS(T, φ) definition
-/

import MetaMillennium.Core.ConsistencyAndIndependence

namespace MetaMillennium.DualState

open MetaMillennium.Core

/-- The Dual-State: a pair of models witnessing independence -/
structure DualState (T : Theory) (φ : Sentence) where
  /-- Model where φ is true -/
  model_plus : Model
  /-- Model where φ is false (¬φ is true) -/
  model_minus : Model
  /-- model_plus satisfies T -/
  plus_models_theory : model_plus ⊨ₜ T
  /-- model_minus satisfies T -/
  minus_models_theory : model_minus ⊨ₜ T
  /-- model_plus satisfies φ -/
  plus_models_phi : model_plus ⊨ φ
  /-- model_minus satisfies ¬φ -/
  minus_models_neg_phi : model_minus ⊨ φ.neg

/-- Notation for Dual-State -/
notation "DS(" T ", " φ ")" => DualState T φ

/-- The Dual-State set is non-empty iff φ is independent -/
def DualState.nonEmpty (T : Theory) (φ : Sentence) : Prop :=
  Nonempty (DS(T, φ))

/-- Existence of Dual-State characterizes independence -/
theorem dual_state_iff_independent (T : Theory) (φ : Sentence) :
    DualState.nonEmpty T φ ↔ (Con(T + φ) ∧ Con(T + φ.neg)) := by
  constructor
  · intro ⟨ds⟩
    constructor
    · -- Con(T + φ)
      use ds.model_plus
      intro ψ hψ
      cases hψ with
      | head => exact ds.plus_models_phi
      | tail _ h => exact ds.plus_models_theory ψ h
    · -- Con(T + ¬φ)
      use ds.model_minus
      intro ψ hψ
      cases hψ with
      | head => exact ds.minus_models_neg_phi
      | tail _ h => exact ds.minus_models_theory ψ h
  · intro ⟨⟨mPlus, hPlus⟩, ⟨mMinus, hMinus⟩⟩
    use {
      model_plus := mPlus
      model_minus := mMinus
      plus_models_theory := fun ψ hψ => hPlus ψ (List.mem_append.mpr (Or.inl hψ))
      minus_models_theory := fun ψ hψ => hMinus ψ (List.mem_append.mpr (Or.inl hψ))
      plus_models_phi := hPlus φ (List.mem_append.mpr (Or.inr (List.mem_singleton.mpr rfl)))
      minus_models_neg_phi := hMinus φ.neg (List.mem_append.mpr (Or.inr (List.mem_singleton.mpr rfl)))
    }

end MetaMillennium.DualState
