/-
  MetaMillennium.DualState.DualStateDefinition
  
  Core definition of the dual-state function.
-/

import MetaMillennium.ZFC.Models

namespace MetaMillennium.DualState

open MetaMillennium.ZFC

/-- The dual-state of a sentence in a theory -/
structure DualState (φ : Prop) where
  /-- Models where φ is true -/
  models_pos : Set Model
  /-- Models where φ is false -/
  models_neg : Set Model
  /-- Models where φ is undefined (if applicable) -/
  models_und : Set Model
  /-- Partition property -/
  partition : True  -- Placeholder: models_pos ∪ models_neg ∪ models_und = all models

/-- Compute the dual-state for a proposition -/
def DS (φ : Prop) : DualState φ where
  models_pos := { M | M ⊨ φ }
  models_neg := { M | M ⊨ ¬φ }
  models_und := ∅
  partition := trivial

/-- A sentence is provable iff models_neg is empty -/
def is_provable (ds : DualState φ) : Prop := ds.models_neg = ∅

/-- A sentence is refutable iff models_pos is empty -/
def is_refutable (ds : DualState φ) : Prop := ds.models_pos = ∅

/-- A sentence is independent iff both are nonempty -/
def is_independent (ds : DualState φ) : Prop := 
  ds.models_pos.Nonempty ∧ ds.models_neg.Nonempty

/-- Negation duality -/
theorem DS_neg (φ : Prop) : 
  (DS (¬φ)).models_pos = (DS φ).models_neg ∧
  (DS (¬φ)).models_neg = (DS φ).models_pos := by
  constructor
  · ext M; simp [DS]
  · ext M; simp [DS]; push_neg; rfl

end MetaMillennium.DualState
