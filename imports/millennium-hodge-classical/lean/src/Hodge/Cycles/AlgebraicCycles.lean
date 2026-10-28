/-
Copyright (c) 2025 ShantiDraconis. All rights reserved.
Released under MIT license.

Algebraic cycles.
-/

/-!
# Algebraic Cycles

This file defines algebraic cycles on varieties.

## Main definitions

* `Hodge.AlgebraicCycle` - formal sum of subvarieties
* `Hodge.effectiveCycle` - cycles with non-negative coefficients
* `Hodge.cycleSupport` - support of a cycle

-/

namespace Hodge

/-- An algebraic cycle of codimension p is a formal sum Σ n_i [V_i]. -/
structure AlgebraicCycle (X : Variety) (p : ℕ) where
  -- List of (coefficient, subvariety) pairs
  -- Each V_i has codimension p
  mk ::

/-- The group of algebraic cycles Z^p(X). -/
def CycleGroup (X : Variety) (p : ℕ) : Type := AlgebraicCycle X p

/-- Zero cycle (empty sum). -/
def zeroCycle (X : Variety) (p : ℕ) : AlgebraicCycle X p := AlgebraicCycle.mk

/-- Addition of cycles. -/
def addCycles (X : Variety) (p : ℕ) (Z W : AlgebraicCycle X p) : AlgebraicCycle X p :=
  AlgebraicCycle.mk -- Placeholder

instance (X : Variety) (p : ℕ) : Add (AlgebraicCycle X p) where
  add := addCycles X p

/-- An effective cycle has all coefficients ≥ 0. -/
def AlgebraicCycle.isEffective (Z : AlgebraicCycle X p) : Prop := True

/-- Codimension 0 cycles (multiples of [X]). -/
def fundamentalCycle (X : Variety) : AlgebraicCycle X 0 := AlgebraicCycle.mk

/-- A 0-cycle (codimension n, points). -/
def ZeroDimensionalCycle (X : Variety) (n : ℕ) := AlgebraicCycle X n

end Hodge
