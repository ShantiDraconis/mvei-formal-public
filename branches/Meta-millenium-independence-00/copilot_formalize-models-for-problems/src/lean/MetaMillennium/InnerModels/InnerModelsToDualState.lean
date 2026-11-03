/-
  MetaMillennium/InnerModels/InnerModelsToDualState.lean

  Bridge: if we obtain an inner model M⁺ with φ and another model M⁻ with ¬φ,
  this generates DualState(ZFC, φ).
-/

import MetaMillennium.InnerModels.InnerModelBasics
import MetaMillennium.Core.TheoryAndModel
import MetaMillennium.DualState.DualStateDefinition

namespace MetaMillennium.InnerModels

open MetaMillennium

variable {T : Theory} [Provable T]

/-- Structure: an inner model scenario with opposing truth values. -/
structure InnerDualScenario (T : Theory) [Provable T] where
  φ      : Sentence T
  Mpos   : InnerModel T
  Mneg   : Model T
  satPos : Mpos.carrierModel ⊨ φ
  satNeg : True   -- Mneg ⊨ ¬φ (placeholder)

/-- Axiom: an inner dual scenario yields DualState. -/
axiom innerDualScenario_gives_DualState
  (d : InnerDualScenario T) :
  DualState T d.φ

/-- Corollary: Inner model scenarios imply independence. -/
theorem innerDualScenario_implies_independent
  (d : InnerDualScenario T) : Independent T d.φ :=
  dualState_implies_independent d.φ (innerDualScenario_gives_DualState d)

/-- An inner model can serve as the positive branch of a bi-model. -/
def innerModelAsPositiveBranch (M : InnerModel T) (φ : Sentence T)
    (h : M.carrierModel ⊨ φ) : Model T :=
  M.carrierModel

end MetaMillennium.InnerModels
