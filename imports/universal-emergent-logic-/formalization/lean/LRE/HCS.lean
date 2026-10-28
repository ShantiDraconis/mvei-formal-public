/-
Copyright (c) 2025 ShantiDraconis. All rights reserved.
Released under MIT license.
Authors: ShantiDraconis

# HCS: Section Collapse Hypothesis

Main module file that imports all HCS components.

The Section Collapse Hypothesis (HCS) provides a unified framework
for understanding and classifying deep mathematical problems through
the lens of projective systems and residual geometry.

## Modules

* `HCS.Core` - Core definitions and theorems
* `HCS.RiemannHypothesis` - Application to RH
* `HCS.YangMills` - Application to Yang-Mills mass gap
* `HCS.BirchSwinnertonDyer` - Application to BSD
* `HCS.NavierStokes` - Application to NS regularity
* `HCS.PvsNP` - Application to P vs NP

## Usage

```lean
import LRE.HCS

-- Access core definitions
open LRE.HCS

-- Define a projection system for your problem
def myProblem : ProjectionSystem := ...

-- Identify its critical point
def myCriticalPoint : CriticalInjectivityPoint myProblem := ...

-- Classify its regime
theorem myProblem_classification :
    ∃ regime : AdmissibleClosureRegime myProblem, ... := by
  ...
```
-/

-- Core HCS framework
import LRE.HCS.Core

-- Millennium Problem applications
import LRE.HCS.RiemannHypothesis
import LRE.HCS.YangMills
import LRE.HCS.BirchSwinnertonDyer
import LRE.HCS.NavierStokes
import LRE.HCS.PvsNP
import LRE.HCS.HodgeConjecture
