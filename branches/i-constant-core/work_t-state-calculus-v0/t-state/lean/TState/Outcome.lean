import Mathlib

namespace TState

/-- Predicate-valued set, kept deliberately minimal. -/
abbrev StateSet (α : Type*) := α → Prop

/-- Result of an operation in the state calculus.
No operation is forced to return a single scalar. -/
inductive Outcome (α : Type*) where
  | exact (value : α)
  | family (values : StateSet α)
  | undefined

namespace Outcome

def map {α β : Type*} (f : α → β) : Outcome α → Outcome β
  | .exact a => .exact (f a)
  | .family A => .family (fun b => ∃ a, A a ∧ f a = b)
  | .undefined => .undefined

@[simp] theorem map_exact {α β : Type*} (f : α → β) (a : α) :
    map f (.exact a) = .exact (f a) := rfl

@[simp] theorem map_undefined {α β : Type*} (f : α → β) :
    map f (.undefined : Outcome α) = .undefined := rfl

end Outcome
end TState
