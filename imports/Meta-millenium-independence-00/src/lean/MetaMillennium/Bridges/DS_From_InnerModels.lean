/-
  MetaMillennium.Bridges.DS_From_InnerModels
  Dual-State from inner models
-/

import MetaMillennium.Bridges.BridgeOverview

namespace MetaMillennium.Bridges

open MetaMillennium.Core
open MetaMillennium.DualState
open MetaMillennium.InnerModels

/-- The inner model bridge theorem -/
theorem inner_model_bridge_theorem
    (T : Theory) (φ : Sentence)
    (N : InnerModel) (M : Model)
    (hN_T : N.satisfies_ZFC)
    (hM_T : M ⊨ₜ ZFC_full)
    (hN_φ : N.toModel ⊨ φ)
    (hM_notφ : M ⊨ φ.neg) :
    DualState.nonEmpty ZFC_full φ := by
  use {
    model_plus := N.toModel
    model_minus := M
    plus_models_theory := hN_T
    minus_models_theory := hM_T
    plus_models_phi := hN_φ
    minus_models_neg_phi := hM_notφ
  }

/-- L as a source of BiModels -/
def L_bimodel_source : String :=
  "L provides a canonical inner model. For sentences φ: " ++
  "If L ⊨ φ and V ⊨ ¬φ, then (L, V) is a BiModel for φ. " ++
  "If L ⊨ ¬φ and V ⊨ φ, then (V, L) is a BiModel for φ."

/-- What L decides -/
def L_decides : List String := [
  "V = L (by definition)",
  "GCH (Gödel)",
  "AC (Gödel)",
  "◇ (Jensen)",
  "□ (Jensen)"
]

/-- What V might differ from L -/
def V_differs_from_L : List String := [
  "V = L vs V ≠ L",
  "CH vs ¬CH (via forcing)",
  "Large cardinals (L has none)",
  "0# existence"
]

end MetaMillennium.Bridges
