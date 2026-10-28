import FormalSuite.I.Universal.Transitions

namespace FormalSuite.I.Universal

/-- Two-valued endpoints used only to classify closure transitions.
They do not redefine Lean truth or ordinary equality. -/
inductive LogicalEndpoint where
  | F
  | T
deriving DecidableEq

structure ClosureSemantic where
  before : LogicalEndpoint
  after : LogicalEndpoint
deriving DecidableEq

def IFF : ClosureSemantic := ⟨.F, .F⟩
def IFV : ClosureSemantic := ⟨.F, .T⟩
def IVF : ClosureSemantic := ⟨.T, .F⟩
def IVV : ClosureSemantic := ⟨.T, .T⟩

theorem closure_semantic_exhaustive (c : ClosureSemantic) :
    c = IFF ∨ c = IFV ∨ c = IVF ∨ c = IVV := by
  rcases c with ⟨b, a⟩
  cases b <;> cases a <;> simp [IFF, IFV, IVF, IVV]

/-- Semantic equality is internal-state equality, not ordinary arithmetic equality. -/
def SameProjection (x y : IState) : Prop := projection x = projection y

theorem information_refines_projection :
    ∃ x y : IState, x ≠ y ∧ SameProjection x y := by
  simpa [SameProjection] using informationNonCollapse

end FormalSuite.I.Universal
