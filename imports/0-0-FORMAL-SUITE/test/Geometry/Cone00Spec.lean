/-
  test/Geometry/Cone00Spec.lean

  Test specifications for the geometric cone structures.
  Verifies cone properties, vertex behavior, and I-scaling.

  This file contains no `sorry` statements.
-/

import FormalSuite.Geometry.Cone00

/-!
# Geometry Cone Tests

This module provides test cases for the cone geometry,
verifying:
- Cone membership properties
- Vertex properties
- Distance calculations
- I-scaling behavior
-/

namespace FormalSuite.Test.Cone00

open FormalSuite.Geometry

/-!
## Basic Cone Tests
-/

/-- Test: Full cone contains the origin. -/
example : (Cone.full 3).vertex ∈ (Cone.full 3) := by
  exact Cone.vertex_mem (Cone.full 3)

/-- Test: Trivial cone contains only vertex. -/
example {n : ℕ} : (Cone.trivial n).carrier = {(Cone.trivial n).vertex} := by
  rfl

/-- Test: Full cone contains any point. -/
example (x : Fin 3 → ℝ) : x ∈ Cone.full 3 := by
  trivial

/-!
## Distance Tests
-/

/-- Test: Distance to vertex of origin is zero. -/
example : distToVertex (fun _ : Fin 3 => (0 : ℝ)) = 0 := by
  simp

/-- Test: Distance is non-negative. -/
example (x : Fin 3 → ℝ) : 0 ≤ distToVertex x := by
  exact distToVertex_nonneg x

/-- Test: Scaling distance by positive factor. -/
example (x : Fin 3 → ℝ) (λ : ℝ) (hλ : 0 ≤ λ) :
    distToVertex (λ • x) = λ * distToVertex x := by
  exact distToVertex_smul x λ hλ

/-!
## Collapse Tests
-/

/-- Test: Constant zero sequence collapses. -/
example : collapsesToVertex (fun _ : ℕ => (fun _ : Fin 3 => (0 : ℝ))) := by
  exact const_zero_collapses

/-!
## I-Scaling Tests
-/

/-- Test: I-scaled cone equals original cone. -/
example (C : Cone 3) : C.I_scaled = C := by
  simp

/-- Test: Vertex is I-invariant. -/
example (C : Cone 3) : IField.I (α := ℝ) • C.vertex = C.vertex := by
  exact vertex_I_invariant C

/-!
## 8D Cone Tests
-/

/-- Test: Standard 8D cone is well-defined. -/
example : StructuredCone8D.standard.toCone = Cone.full 8 := by
  rfl

end FormalSuite.Test.Cone00
