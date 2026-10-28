/-
Copyright (c) 2025 ShantiDraconis. All rights reserved.
Released under MIT license.

# LRE Core: Closure

Closure families and closure error. A "closure" is a candidate dynamics
on the reduced space D that attempts to approximate the true projected dynamics.

## Main Definitions

* `ClosureFamily` - Family of candidate closures for dynamics on D
* `ClosureError` - Measures how badly a closure fails to match reality

## References

* Problem statement: Section 1.1 - Estruturas centrais
-/

import LRE.Core.Projective
import Mathlib.Data.Real.ENNReal

namespace LRE

universe u v w

/-- 
A closure family is a collection of candidate "closed theories" on the reduced space D.

Each closure Cl tries to describe dynamics on D without reference to C.
The key question: can any closure accurately capture the projected dynamics?

Examples:
- Navier-Stokes: Cl = parameterized eddy viscosity models
- P vs NP: Cl = polynomial-time algorithms attempting to solve NP problems
- Yang-Mills: Cl = effective gauge theories at fixed energy scale
-/
class ClosureFamily (D : Sort v) where
  /-- The type of closure models -/
  Cl : Sort w
  /-- Each closure defines dynamics/evolution on D -/
  eval : Cl → D → D

/--
Extract the closure type from the typeclass.
-/
def ClosureType (D : Sort v) [ClosureFamily D] : Sort w :=
  ClosureFamily.Cl

/--
Apply a closure to a point in D.
-/
def applyClosure {D : Sort v} [ClosureFamily D] (cl : ClosureFamily.Cl) (d : D) : D :=
  ClosureFamily.eval cl d

/-- 
Closure error measures the discrepancy between:
1. The true dynamics on C projected to D
2. A closure model operating on D

This is the fundamental "error of dimensional reduction".

The closure error E must be provided by the problem domain because
it depends on the specific notion of "dynamics" and "distance" in each context.

Examples:
- Navier-Stokes: E ~ ‖∂_t π(u) - X_cl(π(u))‖ (difference in velocities)
- P vs NP: E ~ failure probability or runtime excess of the algorithm
- Riemann: E ~ deviation from exact formula using only analytic data
-/
class ClosureError {C : Sort u} {D : Sort v} (π : C → D) (Cl : Sort w) where
  /--
  The error functional E(trueProj, cl, c) measures how badly closure cl
  fails to match the true projected dynamics at configuration c.
  
  Parameters:
  - trueProj: the true dynamics on C projected to D
  - cl: the candidate closure model
  - c: the configuration in C where we measure the error
  -/
  E : (trueProj : C → D) → Cl → C → ℝ≥0∞

/--
Extract the error function from the typeclass.
-/
def closureError {C : Sort u} {D : Sort v} {π : C → D} {Cl : Sort w} 
    [ClosureError π Cl] 
    (trueProj : C → D) (cl : Cl) (c : C) : ℝ≥0∞ :=
  ClosureError.E trueProj cl c

/--
A closure is perfect (no error) at a configuration if E = 0.
-/
def PerfectClosureAt {C : Sort u} {D : Sort v} {π : C → D} {Cl : Sort w} 
    [ClosureError π Cl] 
    (trueProj : C → D) (cl : Cl) (c : C) : Prop :=
  ClosureError.E trueProj cl c = 0

/--
A closure has bounded error if E is finite.
-/
def BoundedClosureErrorAt {C : Sort u} {D : Sort v} {π : C → D} {Cl : Sort w} 
    [ClosureError π Cl] 
    (trueProj : C → D) (cl : Cl) (c : C) : Prop :=
  ClosureError.E trueProj cl c < ⊤

end LRE
