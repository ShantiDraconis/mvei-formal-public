/-
Copyright (c) 2025 ShantiDraconis. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ShantiDraconis

# Millennium Riemann Project

Main module file for the symbolic Riemann Hypothesis formalization.

This imports the complete I-Collapse framework for proving the Riemann Hypothesis
in the CollapseComplex extended number system.
Combines the original CollapseComplex framework with the complete I-Collapse framework.

## Numeric Classes

- **CollapseComplex**: Base numeric class with indeterminate I = 0/0
- **HorizonComplex**: Emerges at limit/horizon boundaries  
- **RefutationComplex**: Emerges from proof-refutation dialectic

## Core Theory

- **NumericTransitions**: Rules for transitioning between numeric classes
- **SymbolicZeta**: Symbolic zeta function and Riemann Hypothesis
- **TwoPhaseTheorem**: The central theorem partitioning math into two phases
- **FormalAxioms**: Complete axiomatization (A1-A12, L1-L20, T1-T10)
- **GeometryTheory**: Einstein vs Cone geometry interpretation

## Framework Structure

The framework establishes a complete mathematical system where:

1. **PHASE I (Coherent)**: I ≠ 1
   - RH is TRUE
   - Einstein-like geometry
   - All zeros on critical line

2. **PHASE II (Collapsed)**: I = 1
   - RH may FAIL
   - Cone-like geometry
   - Anomalous zeros possible
   - New numeric class (RefutationComplex) emerges

The Two-Phase Theorem: RH ↔ Universe is in Phase I
-/

-- Original CollapseComplex framework
import Millennium.Riemann.CollapseComplex
import Millennium.Riemann.HorizonComplex
import Millennium.Riemann.RefutationComplex
import Millennium.Riemann.NumericTransitions
import Millennium.Riemann.SymbolicZeta
import Millennium.Riemann.NumericalHierarchy
import Millennium.Riemann.ExtendedZeta

-- New number class hierarchy
import Millennium.Riemann.NumericalHierarchy
import Millennium.Riemann.ExtendedZeta

-- Core Riemann modules
import Millennium.Riemann.Core.ZetaDef
import Millennium.Riemann.Core.FunctionalEquation
import Millennium.Riemann.Core.CriticalStrip
import Millennium.Riemann.Core.ClassicalZeros

-- I-Constant framework
import Millennium.Riemann.IConstant.ICore
import Millennium.Riemann.IConstant.IRegularization
import Millennium.Riemann.IConstant.DeltaCollapse

-- Zero classification
import Millennium.Riemann.Zeros.Basic
import Millennium.Riemann.Zeros.Trivial
import Millennium.Riemann.Zeros.Nontrivial
import Millennium.Riemann.Zeros.Symmetry

-- I-Kernel integral representation
import Millennium.Riemann.IKernel.KernelDef
import Millennium.Riemann.IKernel.ZetaIntegralEq

-- Collapse proof (the main theorem)
import Millennium.Riemann.CollapseProof.Assumptions
import Millennium.Riemann.CollapseProof.ICollapseLogic
import Millennium.Riemann.CollapseProof.Contradiction

-- Simulation support
import Millennium.Sim.Numerics
import Millennium.Sim.Bridges
import Millennium.Riemann.TwoPhaseTheorem
import Millennium.Riemann.FormalAxioms
import Millennium.Riemann.GeometryTheory

-- Core Riemann modules
import Riemann.Core.ZetaDef
import Riemann.Core.FunctionalEquation
import Riemann.Core.CriticalStrip
import Riemann.Core.ClassicalZeros

-- I-Constant framework
import Riemann.IConstant.ICore
import Riemann.IConstant.IRegularization
import Riemann.IConstant.DeltaCollapse

-- Zero classification
import Riemann.Zeros.Basic
import Riemann.Zeros.Trivial
import Riemann.Zeros.Nontrivial
import Riemann.Zeros.Symmetry

-- I-Kernel integral representation
import Riemann.IKernel.KernelDef
import Riemann.IKernel.ZetaIntegralEq

-- Collapse proof (the main theorem)
import Riemann.CollapseProof.Assumptions
import Riemann.CollapseProof.ICollapseLogic
import Riemann.CollapseProof.Contradiction

-- Simulation support
import Sim.Numerics
import Sim.Bridges
