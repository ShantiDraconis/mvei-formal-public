/-
Framework for a mathematical domain (TUNS)

This file defines the basic framework structure for mathematical domains
in Tiago's Universal Novelty Theorem.
-/

/-- A mathematical framework: (X, L, G, loc, glob) -/
structure Framework where
  X : Type
  L : Type
  G : Type
  loc : X → L
  glob : X → G

/-- A morphism between two frameworks -/
structure Morphism (A B : Framework) where
  φL : A.L → B.L
  φG : A.G → B.G
  commutes : ∀ x : A.X, φG (A.glob x) = B.glob (φL (A.loc x))

/-- The identity morphism -/
def Morphism.id (A : Framework) : Morphism A A :=
  { φL := id
    φG := id
    commutes := by intro x; rfl }

/-- Composition of morphisms -/
def Morphism.comp {A B C : Framework} (f : Morphism A B) (g : Morphism B C) : Morphism A C :=
  { φL := g.φL ∘ f.φL
    φG := g.φG ∘ f.φG
    commutes := by
      intro x
      simp [f.commutes, g.commutes] }

/-- Bridge between frameworks exists -/
def HasBridge (F : Framework) : Prop :=
  ∃ Φ : F.L → F.G, ∀ x : F.X, Φ (F.loc x) = F.glob x
