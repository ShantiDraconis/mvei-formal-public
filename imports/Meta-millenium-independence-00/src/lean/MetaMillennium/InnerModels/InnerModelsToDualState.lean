/-
  MetaMillennium.InnerModels.InnerModelsToDualState
  Using inner models to establish Dual-State
-/

import MetaMillennium.InnerModels.L_InnerModel
import MetaMillennium.DualState.DualStateDefinition
import MetaMillennium.Models.ZFCAbstract

namespace MetaMillennium.InnerModels

open MetaMillennium.Core
open MetaMillennium.DualState
open MetaMillennium.Models

/-- Inner model bridge -/
theorem inner_model_creates_bimodel
    (M : Model) (N : InnerModel)
    (φ : Sentence)
    (hM : M ⊨ₜ ZFC_full)
    (hN : N.satisfies_ZFC)
    (hPhi_M : M ⊨ φ.neg)
    (hPhi_N : N.toModel ⊨ φ) :
    DualState.nonEmpty ZFC_full φ := by
  use {
    model_plus := N.toModel
    model_minus := M
    plus_models_theory := hN
    minus_models_theory := hM
    plus_models_phi := hPhi_N
    minus_models_neg_phi := hPhi_M
  }

/-- L provides one side of BiModels -/
-- For sentences true in L but potentially false in V
def L_as_bimodel_source (φ : Sentence) (hL : L.toModel ⊨ φ) : String :=
  "L provides M⁺ for φ. If we can show M⁻ ⊨ T + ¬φ for some M, " ++
  "then DS(T, φ) ≠ ∅."

/-- The inner model bridge -/
def inner_model_bridge (T : Theory) (φ : Sentence) : String :=
  "To show DS(T, φ) ≠ ∅ via inner models: " ++
  "1. Check value of φ in L " ++
  "2. Find extension V where φ has opposite value " ++
  "3. Get BiModel (L, V) or (V, L)"

end MetaMillennium.InnerModels
