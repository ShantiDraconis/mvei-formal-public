/-
  MetaMillennium/InnerModels/L_InnerModel.lean

  Gödel's constructible universe L as an abstract inner model of ZFC.
-/

import MetaMillennium.InnerModels.InnerModelBasics
import MetaMillennium.Models.ZFCAbstract

namespace MetaMillennium.InnerModels

open MetaMillennium

/-- Constant: an inner model L of ZFC (Gödel's constructible universe). -/
def L : InnerModel ZFC where
  carrierModel := ⟨"L"⟩
  includedInV  := trivial

/-- Axiom: L is a model of ZFC (abstract). -/
axiom L_models_ZFC : L.carrierModel ⊨ (⟨"ZFC_axioms"⟩ : Sentence ZFC)

/-- Axiom: L satisfies the Generalized Continuum Hypothesis. -/
axiom L_models_GCH : L.carrierModel ⊨ (⟨"GCH"⟩ : Sentence ZFC)

/-- Axiom: L satisfies the Axiom of Constructibility (V=L). -/
axiom L_models_V_eq_L : L.carrierModel ⊨ (⟨"V=L"⟩ : Sentence ZFC)

instance : CanonicalInnerModel ZFC L where
  canonical := trivial

/-- L is transitive. -/
theorem L_transitive : IsTransitive L := trivial

/-- L is well-founded. -/
theorem L_wellFounded : IsWellFounded L := trivial

end MetaMillennium.InnerModels
