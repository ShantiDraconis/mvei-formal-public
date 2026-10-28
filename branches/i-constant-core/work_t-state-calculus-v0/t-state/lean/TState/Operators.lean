import TState.Outcome

namespace TState

/-- Projection operator, denoted conceptually by Pi. -/
def PiOp {α β : Type*} (f : α → β) (x : α) : β := f x

/-- Superposition/union operator, denoted conceptually by Sigma. -/
def SigmaOp {α : Type*} (A B : StateSet α) : StateSet α :=
  fun x => A x ∨ B x

/-- Total state set, denoted conceptually by Omega. -/
def OmegaOp {α : Type*} : StateSet α :=
  fun _ => True

/-- A collapse operator is not assumed deterministic. -/
abbrev CollapseOp (α : Type*) := StateSet α → Outcome α

/-- Apply a supplied collapse rule, denoted conceptually by Delta. -/
def DeltaOp {α : Type*} (collapse : CollapseOp α) (A : StateSet α) : Outcome α :=
  collapse A

/-- States present in A but not in B. -/
def Residual {α : Type*} (A B : StateSet α) : StateSet α :=
  fun x => A x ∧ ¬ B x

@[simp] theorem sigma_comm {α : Type*} (A B : StateSet α) :
    SigmaOp A B = SigmaOp B A := by
  funext x
  apply propext
  simp [SigmaOp, or_comm]

@[simp] theorem sigma_assoc {α : Type*} (A B C : StateSet α) :
    SigmaOp (SigmaOp A B) C = SigmaOp A (SigmaOp B C) := by
  funext x
  apply propext
  simp [SigmaOp, or_assoc]

@[simp] theorem sigma_omega {α : Type*} (A : StateSet α) :
    SigmaOp A (OmegaOp : StateSet α) = OmegaOp := by
  funext x
  apply propext
  simp [SigmaOp, OmegaOp]

end TState
