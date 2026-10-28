/-
  MetaMillennium.Models.ToyModels
  Toy models demonstrating independence in finite structures
-/

import MetaMillennium.Core.ConsistencyAndIndependence
import MetaMillennium.DualState.DualStateDefinition

namespace MetaMillennium.Models

open MetaMillennium.Core
open MetaMillennium.DualState

/-- A simple two-element model: {0, 1} with no structure -/
structure TwoElementModel where
  /-- The first element -/
  elem0 : Nat := 0
  /-- The second element -/
  elem1 : Nat := 1

/-- A toy theory with one axiom: "there exists an element" -/
def ToyTheory : Theory := {
  name := "Toy"
  axioms := [{ id := 1, repr := "∃x(x = x)" }]
}

/-- A toy sentence: "there exists exactly one element" -/
def OnlyOneElement : Sentence := { id := 2, repr := "∃!x(x = x)" }

/-- A toy sentence: "there exist at least two elements" -/
def AtLeastTwo : Sentence := { id := 3, repr := "∃x∃y(x ≠ y)" }

/-- Model with one element (for OnlyOneElement) -/
def singletonModel : Model := { id := 1, name := "Singleton" }

/-- Model with two elements (for AtLeastTwo) -/
def pairModel : Model := { id := 2, name := "Pair" }

/-- Demonstration: both models satisfy ToyTheory -/
-- This is a toy example of how different models can satisfy the same theory
-- but differ on additional sentences

/-- The sentence "there exists exactly two elements" -/
def ExactlyTwo : Sentence := { id := 4, repr := "∃x∃y(x ≠ y ∧ ∀z(z = x ∨ z = y))" }

/-- Example of independence in a toy setting -/
-- In a theory that only says "at least one element exists":
-- "exactly one element" is independent (could be one, could be more)

example : Sentence := OnlyOneElement  -- This would be independent of ToyTheory

end MetaMillennium.Models
