import OpenMathMiner.DualState

namespace OpenMathMiner.PNP

structure EqualLaws (Claim : Prop) where
  satSolverExists : Prop
  satSolverSound : Prop
  satSolverComplete : Prop
  polynomialBound : Prop
  closure :
    satSolverExists →
    satSolverSound →
    satSolverComplete →
    polynomialBound →
    Claim

structure SeparateLaws (Claim : Prop) where
  universalObstructionExists : Prop
  obstructionSound : Prop
  polynomialFailure : Prop
  closure :
    universalObstructionExists →
    obstructionSound →
    polynomialFailure →
    ¬ Claim

def EqualWorld {Claim : Prop} (L : EqualLaws Claim)
    (h1 : L.satSolverExists)
    (h2 : L.satSolverSound)
    (h3 : L.satSolverComplete)
    (h4 : L.polynomialBound) :
    OpenMathMiner.ConditionalWorld Claim where
  Laws := L.satSolverExists ∧ L.satSolverSound ∧ L.satSolverComplete ∧ L.polynomialBound
  laws_hold := ⟨h1, h2, h3, h4⟩
  closes := by
    intro h
    exact L.closure h.1 h.2.1 h.2.2.1 h.2.2.2

def SeparateWorld {Claim : Prop} (L : SeparateLaws Claim)
    (h1 : L.universalObstructionExists)
    (h2 : L.obstructionSound)
    (h3 : L.polynomialFailure) :
    OpenMathMiner.ConditionalWorld (¬ Claim) where
  Laws := L.universalObstructionExists ∧ L.obstructionSound ∧ L.polynomialFailure
  laws_hold := ⟨h1, h2, h3⟩
  closes := by
    intro h
    exact L.closure h.1 h.2.1 h.2.2

end OpenMathMiner.PNP
