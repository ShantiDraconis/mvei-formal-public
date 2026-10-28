import TState.Outcome
import TState.Operators

namespace TState

/-- A collapse event keeps pre-state, observed outcome, post-state and residual
as separate typed data. No information-conservation law is assumed. -/
structure CollapseEvent (α : Type*) where
  pre : StateSet α
  observed : Outcome α
  post : StateSet α
  residual : StateSet α

namespace CollapseEvent

def observedExact {α : Type*} (c : CollapseEvent α) : Prop :=
  ∃ x, c.observed = .exact x

def observedFamily {α : Type*} (c : CollapseEvent α) : Prop :=
  ∃ A, c.observed = .family A

def observedUndefined {α : Type*} (c : CollapseEvent α) : Prop :=
  c.observed = .undefined

/-- Coverage is a candidate law: every pre-state is either retained post-collapse
or explicitly recorded in the residual. -/
def CoversPre {α : Type*} (c : CollapseEvent α) : Prop :=
  ∀ x, c.pre x → c.post x ∨ c.residual x

/-- Separation is another candidate law: post-state and residual do not overlap. -/
def Separates {α : Type*} (c : CollapseEvent α) : Prop :=
  ∀ x, ¬ (c.post x ∧ c.residual x)

/-- A conservative collapse is defined by coverage plus separation.
This is a structural notion, not a physical conservation theorem. -/
def Conservative {α : Type*} (c : CollapseEvent α) : Prop :=
  c.CoversPre ∧ c.Separates

theorem conservative_covers {α : Type*} {c : CollapseEvent α}
    (h : c.Conservative) : c.CoversPre := h.1

theorem conservative_separates {α : Type*} {c : CollapseEvent α}
    (h : c.Conservative) : c.Separates := h.2

end CollapseEvent
end TState
