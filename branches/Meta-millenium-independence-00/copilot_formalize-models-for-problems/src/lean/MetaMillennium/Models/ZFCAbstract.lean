/-
  MetaMillennium/Models/ZFCAbstract.lean

  Abstract representation of ZFC as a theory in the framework.
  This provides the base theory for discussing the Millennium Problems.
-/

import MetaMillennium.Core.TheoryAndModel

namespace MetaMillennium

/-- ZFC as an abstract theory. -/
def ZFC : Theory := ⟨"ZFC"⟩

/-- Abstract provability instance for ZFC. -/
instance : Provable ZFC where
  proves := fun _ => True   -- placeholder
  refutes := fun _ => False -- placeholder
  consistent := by
    intro ⟨_, h⟩
    exact h.2

/-- The standard model of ZFC (abstract representation). -/
def V : Model ZFC := ⟨"V"⟩

/-- Axiom: V is a model of ZFC. -/
axiom V_models_ZFC : V ⊨ (⟨"ZFC_axioms"⟩ : Sentence ZFC)

end MetaMillennium
