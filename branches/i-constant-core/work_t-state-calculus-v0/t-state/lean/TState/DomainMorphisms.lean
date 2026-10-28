import TState.Outcome

namespace TState

universe u v

/-- Open interface for an arbitrary mathematical domain.
The theory does not require every domain to be a field, ordered, or topological. -/
structure DomainModel where
  Carrier : Type u
  admissible : Carrier → Prop

/-- A typed map between domain models. -/
structure DomainMorphism (A : DomainModel) (B : DomainModel) where
  map : A.Carrier → B.Carrier
  preservesAdmissible :
    ∀ x, A.admissible x → B.admissible (map x)

namespace DomainMorphism

def id (A : DomainModel) : DomainMorphism A A where
  map := fun x => x
  preservesAdmissible := fun _ hx => hx

def comp {A B C : DomainModel}
    (g : DomainMorphism B C) (f : DomainMorphism A B) :
    DomainMorphism A C where
  map := fun x => g.map (f.map x)
  preservesAdmissible := by
    intro x hx
    exact g.preservesAdmissible _ (f.preservesAdmissible _ hx)

@[simp] theorem id_map (A : DomainModel) (x : A.Carrier) :
    (id A).map x = x := rfl

@[simp] theorem comp_map {A B C : DomainModel}
    (g : DomainMorphism B C) (f : DomainMorphism A B) (x : A.Carrier) :
    (comp g f).map x = g.map (f.map x) := rfl

end DomainMorphism

/-- Optional arithmetic package for a domain. Partial and multivalued
operations are represented with Outcome rather than forced totality. -/
structure ArithmeticModel extends DomainModel where
  add : Carrier → Carrier → Outcome Carrier
  mul : Carrier → Carrier → Outcome Carrier
  div : Carrier → Carrier → Outcome Carrier

end TState
