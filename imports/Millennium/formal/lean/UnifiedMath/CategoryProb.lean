/-
Category of Mathematical Problems

The category Prob with frameworks as objects and morphisms.
-/

import UnifiedMath.Framework

/-- The category of frameworks -/
class CategoryProb where
  /-- Objects are frameworks -/
  Obj : Type
  /-- Morphisms between frameworks -/
  Hom : Obj → Obj → Type
  /-- Identity morphism -/
  id : ∀ (A : Obj), Hom A A
  /-- Composition of morphisms -/
  comp : ∀ {A B C : Obj}, Hom A B → Hom B C → Hom A C
  /-- Left identity law -/
  id_comp : ∀ {A B : Obj} (f : Hom A B), comp (id A) f = f
  /-- Right identity law -/
  comp_id : ∀ {A B : Obj} (f : Hom A B), comp f (id B) = f
  /-- Associativity -/
  assoc : ∀ {A B C D : Obj} (f : Hom A B) (g : Hom B C) (h : Hom C D),
    comp (comp f g) h = comp f (comp g h)

/-- Functor between framework categories -/
structure Functor (C D : CategoryProb) where
  obj : C.Obj → D.Obj
  map : ∀ {A B : C.Obj}, C.Hom A B → D.Hom (obj A) (obj B)
  map_id : ∀ (A : C.Obj), map (C.id A) = D.id (obj A)
  map_comp : ∀ {A B C : C.Obj} (f : C.Hom A B) (g : C.Hom B C),
    map (C.comp f g) = D.comp (map f) (map g)
