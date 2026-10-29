import OpenMathMiner.Core

namespace OpenMathMiner

structure Bridge (A B : Signature) where
  mapInput : A.Input → B.Input
  mapOutput : B.Output → A.Output
  admissible_preserved :
    ∀ x : A.Input, A.admissible x → B.admissible (mapInput x)
  closure_transport :
    ∀ (x : A.Input) (y : B.Output),
      A.admissible x →
      B.relation (mapInput x) y →
      A.relation x (mapOutput y)

theorem transportSolved {A B : Signature} (br : Bridge A B) :
    Solved B → Solved A := by
  intro hB x hx
  obtain ⟨y, hy⟩ := hB (br.mapInput x) (br.admissible_preserved x hx)
  exact ⟨br.mapOutput y, br.closure_transport x y hx hy⟩

theorem no_two_outcomes {P : Prop} (hEq : P) (hNe : ¬ P) : False :=
  hNe hEq

end OpenMathMiner
