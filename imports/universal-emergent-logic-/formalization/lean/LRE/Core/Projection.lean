/-
Copyright (c) 2025 ShantiDraconis. All rights reserved.
Released under MIT license.

# Projection Maps and Properties

This file develops the theory of measurable projection maps
and their relationship to information loss and residual structure.

## Main Results

* Properties of fiber decompositions
* Relationship between projection and information content
-/

import LRE.Core.Basic
import Mathlib.MeasureTheory.Constructions.Prod.Basic

namespace ProjectionSystem

variable (sys : ProjectionSystem)

/-- The fiber over d is measurable as a subset of C -/
theorem fiber_measurable (d : sys.D) : 
    MeasurableSet (FiberOver sys d) := by
  unfold FiberOver
  exact sys.π_meas (MeasurableSet.singleton d)

/-- Fibers partition the space C -/
theorem fibers_partition : 
    ∀ u : sys.C, ∃! d : sys.D, u ∈ FiberOver sys d := by
  intro u
  use sys.π u
  constructor
  · -- u is in the fiber over π(u)
    unfold FiberOver
    simp
  · -- Uniqueness: if u is in fiber over d, then d = π(u)
    intro d' hd'
    unfold FiberOver at hd'
    simp at hd'
    exact hd'.symm

/-- Two points in the same fiber have the same projection -/
theorem same_fiber_same_projection {u v : sys.C} {d : sys.D} 
    (hu : u ∈ FiberOver sys d) (hv : v ∈ FiberOver sys d) :
    sys.π u = sys.π v := by
  unfold FiberOver at hu hv
  simp at hu hv
  rw [hu, hv]

/-- The projection loses information: different points can have same projection -/
axiom projection_not_injective (sys : ProjectionSystem) : 
  ∃ (u v : sys.C), u ≠ v ∧ sys.π u = sys.π v

/-- Information loss is measured by non-trivial fibers -/
theorem information_loss_iff_nontrivial_fibers :
    (∃ (u v : sys.C), u ≠ v ∧ sys.π u = sys.π v) ↔
    (∃ (d : sys.D), ∃ (u v : sys.C), u ≠ v ∧ u ∈ FiberOver sys d ∧ v ∈ FiberOver sys d) := by
  constructor
  · intro ⟨u, v, hne, hπ⟩
    use sys.π u, u, v
    exact ⟨hne, by simp [FiberOver], by simp [FiberOver, hπ]⟩
  · intro ⟨d, u, v, hne, hu, hv⟩
    use u, v
    exact ⟨hne, same_fiber_same_projection sys hu hv⟩

end ProjectionSystem

/-! ## Fiber Structure -/

namespace FiberOver

variable {sys : ProjectionSystem} {d : sys.D}

/-- Fibers are closed under the preimage structure -/
theorem mem_fiber_iff (u : sys.C) : 
    u ∈ FiberOver sys d ↔ sys.π u = d := by
  rfl

/-- Characterization of empty fibers -/
theorem fiber_nonempty_iff_in_range (d : sys.D) :
    (FiberOver sys d).Nonempty ↔ d ∈ Set.range sys.π := by
  constructor
  · intro ⟨u, hu⟩
    use u
    exact mem_fiber_iff u |>.mp hu
  · intro ⟨u, hu⟩
    use u
    exact mem_fiber_iff u |>.mpr hu.symm

end FiberOver

/-! ## Projection of Measures -/

namespace ProjectionSystem

variable (sys : ProjectionSystem) (μ : MeasureTheory.Measure sys.C)

/-- The pushforward measure on D induced by μ via π -/
def pushforwardMeasure : MeasureTheory.Measure sys.D :=
  MeasureTheory.Measure.map sys.π μ

/-- A disintegration of μ would give conditional measures on fibers.
This is a sketch of what such a structure would look like. -/
structure FiberMeasure where
  /-- Conditional measure on each fiber -/
  μ_fiber : ∀ d : sys.D, MeasureTheory.Measure sys.C
  /-- The conditional measure is supported on the fiber -/
  support_on_fiber : ∀ d : sys.D, (μ_fiber d).support ⊆ FiberOver sys d

end ProjectionSystem
