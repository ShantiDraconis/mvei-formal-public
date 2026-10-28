/-
  MetaMillennium.DualState.BiModel
  BiModel: the pair (M⁺, M⁻)
-/

import MetaMillennium.DualState.DualStateDefinition

namespace MetaMillennium.DualState

open MetaMillennium.Core

/-- A BiModel is an ordered pair of models for a Dual-State -/
structure BiModel where
  /-- The positive model (φ true) -/
  Mplus : Model
  /-- The negative model (φ false) -/
  Mminus : Model
  deriving Repr

/-- Create a BiModel from a Dual-State -/
def BiModel.fromDualState {T : Theory} {φ : Sentence} (ds : DualState T φ) : BiModel :=
  { Mplus := ds.model_plus, Mminus := ds.model_minus }

/-- Extract the positive model -/
def BiModel.positive (bm : BiModel) : Model := bm.Mplus

/-- Extract the negative model -/
def BiModel.negative (bm : BiModel) : Model := bm.Mminus

/-- Project the set of all M⁺ from Dual-State -/
def projectPlus (T : Theory) (φ : Sentence) : Set Model :=
  { m | ∃ ds : DualState T φ, ds.model_plus = m }

/-- Project the set of all M⁻ from Dual-State -/
def projectMinus (T : Theory) (φ : Sentence) : Set Model :=
  { m | ∃ ds : DualState T φ, ds.model_minus = m }

/-- BiModel equality -/
theorem bimodel_eq_iff (bm1 bm2 : BiModel) :
    bm1 = bm2 ↔ (bm1.Mplus = bm2.Mplus ∧ bm1.Mminus = bm2.Mminus) := by
  constructor
  · intro h
    constructor <;> simp [h]
  · intro ⟨hp, hm⟩
    cases bm1; cases bm2
    simp at hp hm
    simp [hp, hm]

/-- The meta-level: reasoning about BiModels -/
-- At the meta-level, we assert existence of BiModels
-- This corresponds to proving consistency of both T+φ and T+¬φ

structure MetaLevel where
  /-- Theory for meta-reasoning -/
  metaTheory : Theory
  /-- Assertion that BiModels exist for various sentences -/
  bimodels_exist : List (Theory × Sentence)

end MetaMillennium.DualState
