/-
  test/All.lean

  Master test file that imports all test modules.
  Running this file verifies all tests in the FormalSuite project.

  This file contains no `sorry` statements.
-/

import FormalSuite.I.Foundations
import FormalSuite.I.OperatorAlgebra
import FormalSuite.Zeta.ZetaIFormal
import FormalSuite.Zeta.CollapseLemmaRH
import FormalSuite.NavierStokes.CollapseLemmaNS
import FormalSuite.NavierStokes.PDEEnergyInequalities
import FormalSuite.Geometry.Cone00

/-!
# FormalSuite Test Runner

This module imports all components of the FormalSuite project,
ensuring that all proofs compile and are verified.

## Modules Tested

1. **I/Foundations**: IField typeclass and I = 1 theorem
2. **I/OperatorAlgebra**: I-parameterized operators and projections
3. **Zeta/ZetaIFormal**: I-normalized zeta structures
4. **Zeta/CollapseLemmaRH**: Collapse lemmas for RH
5. **NavierStokes/CollapseLemmaNS**: Collapse lemmas for NS
6. **NavierStokes/PDEEnergyInequalities**: Energy inequalities
7. **Geometry/Cone00**: Cone structures and collapse geometry

## Usage

```bash
lake build FormalSuiteTest
```

or

```bash
lake exe test
```
-/

namespace FormalSuite.Test.All

/-!
## Verification Examples

These examples verify that key theorems are accessible.
-/

open FormalSuite.IConstant
open FormalSuite.Zeta
open FormalSuite.NavierStokes
open FormalSuite.Geometry

/-- The fundamental theorem: I = 1. -/
example : IField.I (α := ℝ) = 1 := IField.I_eq_one

/-- Critical line subset of critical strip. -/
example : CriticalLine ⊆ CriticalStrip := criticalLine_subset_strip

/-- Reflection is an involution. -/
example (s : ℂ) : reflection (reflection s) = s := reflection_reflection s

/-- Energy is bounded by initial energy. -/
example (ei : NSEnergyInequality) : ei.E_t.energy ≤ ei.E_initial.energy :=
  energy_bounded_by_initial ei

/-- Vertex is in any cone. -/
example (C : Cone 3) : C.vertex ∈ C := C.vertex_mem

/-- I-scaling is identity on cones. -/
example (C : Cone 3) : C.I_scaled = C := by simp

#check IField.I_eq_one
#check CriticalLine
#check reflection
#check EnergyFunctional
#check Cone

end FormalSuite.Test.All
