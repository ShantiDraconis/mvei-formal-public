/-
Framework.lean

Fundamental categorical structure for TUNS formalization in Lean 4.

A Framework is a structure (X, L, G, loc, glob) where:
- X : Type* (configuration space)
- L : Type* (local observations)
- G : Type* (global invariants)
- loc : X → L (local map)
- glob : X → G (global map)
-/

import Mathlib.CategoryTheory.Category.Basic
import Mathlib.CategoryTheory.Functor.Basic
import Mathlib.Topology.Basic

universe u v w

namespace TUNS

/-- A Framework is the fundamental structure in TUNS -/
structure Framework where
  /-- Configuration space -/
  X : Type u
  /-- Type of local observations -/
  L : Type v
  /-- Type of global invariants -/
  G : Type w
  /-- Local observation map -/
  loc : X → L
  /-- Global invariant map -/
  glob : X → G

namespace Framework

variable (F : Framework)

/-- Apply local map to a configuration -/
def applyLocal (x : F.X) : F.L := F.loc x

/-- Apply global map to a configuration -/
def applyGlobal (x : F.X) : F.G := F.glob x

/-- A Framework morphism is a structure-preserving map -/
structure Morphism (F G : Framework) where
  /-- Map on configuration spaces -/
  mapX : F.X → G.X
  /-- Map on local types -/
  mapL : F.L → G.L
  /-- Map on global types -/
  mapG : F.G → G.G
  /-- Compatibility with local maps -/
  local_compat : ∀ x : F.X, mapL (F.loc x) = G.loc (mapX x)
  /-- Compatibility with global maps -/
  global_compat : ∀ x : F.X, mapG (F.glob x) = G.glob (mapX x)

/-- Identity morphism -/
def idMorphism (F : Framework) : Morphism F F where
  mapX := id
  mapL := id
  mapG := id
  local_compat := fun _ => rfl
  global_compat := fun _ => rfl

/-- Composition of morphisms -/
def Morphism.comp {F G H : Framework} 
    (f : Morphism F G) (g : Morphism G H) : Morphism F H where
  mapX := g.mapX ∘ f.mapX
  mapL := g.mapL ∘ f.mapL
  mapG := g.mapG ∘ f.mapG
  local_compat := by
    intro x
    simp [Function.comp]
    rw [f.local_compat, g.local_compat]
  global_compat := by
    intro x
    simp [Function.comp]
    rw [f.global_compat, g.global_compat]

end Framework

/-- The category of Frameworks (Prob) -/
def CategoryProb : Type (max (u+1) (v+1) (w+1)) := Framework

instance : Category CategoryProb where
  Hom := Framework.Morphism
  id := Framework.idMorphism
  comp := Framework.Morphism.comp

/-- Gap operator on a framework with equipped structure -/
class HasGap (F : Framework) where
  /-- Target local value (ideal) -/
  target : F.L
  /-- Gap measure -/
  gap : F.X → ℝ
  /-- Gap is zero iff local observation equals target -/
  gap_zero_iff : ∀ x : F.X, gap x = 0 ↔ F.loc x = target

/-- A framework satisfies its conjecture if all gaps are zero -/
def Framework.satisfiesConjecture [HasGap F] : Prop :=
  ∀ x : F.X, HasGap.gap x = 0

/-- Universal framework property: factors through all others -/
class UniversalFramework (U : Framework) where
  /-- Universal property: for any framework F, there exists a unique morphism -/
  universal : ∀ (F : Framework), ∃! (f : Framework.Morphism F U), True

end TUNS
