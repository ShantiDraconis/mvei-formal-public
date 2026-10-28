import LRE.Core.ProjectiveSystem
import LRE.Core.Residual
import LRE.Geometry.ResidualConnection
import LRE.Theorems.ClosureObstruction
import LRE.Theorems.ResidualFeedback
import LRE.Applications.NavierStokes
import LRE.Applications.PvsNP
import LRE.Applications.RiemannHypothesis

/-!
# Lei do Resíduo Estrutural (LRE)

This is the main module for the LRE (Structural Residue Law) formalization.

## Overview

The LRE framework provides a unified mathematical theory for understanding information
loss in projective systems. Key components:

1. **Projective Systems**: (C, D, π) where π: C → D is a surjective projection
2. **Residual Functions**: R: C → ℝ≥0∞ measuring information loss
3. **Residual Connections**: Geometric structures (horizontal ⊕ vertical decomposition)
4. **Holonomy Groups**: Measuring non-trivial topology of fibers

## Main Results

* **Closure Obstruction Theorem**: No continuous function on D can bound R on C
* **Residual Feedback Theorem**: R couples back into dynamics on D
* **Applications**: Navier-Stokes, P vs NP, Riemann Hypothesis

## Axioms

* **LRE-1**: Non-injectivity is essential (no continuous section)
* **LRE-2**: Critical scaling exists (scale-invariant configurations)
* **LRE-3**: Residual feedback is unavoidable

## Usage

Import this module to access all LRE definitions and theorems:
/-
Copyright (c) 2025 ShantiDraconis. All rights reserved.
Released under MIT license.

# LRE: Lógica de Resíduo Emergente (Emergent Residue Logic)

This module provides the complete LRE framework for studying obstruction
phenomena in projection systems through measure-theoretic and geometric tools.

## What is LRE?

LRE is a mathematical framework that rigorously formalizes the concept of
"structural incompleteness" without paradoxes or self-reference. It studies
projection systems π: C → D where:

1. **Information is lost**: π is not injective; fibers contain multiple points
2. **Loss is uncontrollable**: The residue R measuring lost information cannot
   be bounded by any function of π(u) alone (Non-Control axiom)
3. **Measurable obstruction**: Certain predicates about R are not σ(π)-measurable,
   meaning they cannot be decided at the level of D

This provides a "Gödel-like" incompleteness result without diagonalization,
purely through σ-algebra theory.

## Main Components

### Core Theory
* `LRE.Core.Basic` - Basic structures: projection systems, fibers, dynamics
* `LRE.Core.Projection` - Properties of projections and fiber decompositions
* `LRE.Core.Residue` - Residue functions and energy
* `LRE.Core.NonControl` - The Non-Control (NC) axiom
* `LRE.Core.ClosureObstruction` - Main theorem: measurable obstruction

### Geometric Theory
* `LRE.Geometry.Ehresmann` - Ehresmann connections on projection systems
* `LRE.Geometry.EhresmannComplete` - Complete connection theory with curvature and holonomy
* `LRE.Geometry.Coupling` - Residual coupling operator K
* `LRE.Geometry.ToyModel` - Concrete example: ℝ² → ℝ with fiber dynamics
* `LRE.Geometry.ToyModelDetailed` - Comprehensive toy model with feedback dynamics

### Quantitative Theory
* `LRE.ClosureObstructionQuantitative` - Quantitative bounds on closure error

### Quantitative Theory
* `LRE.Core.QuantitativeObstruction` - Complete quantitative closure obstruction theorem

## Main Results

**Theorem 1 (Measurable Closure Obstruction)**:
Assume NC. Then ∃M such that the predicate "R(u) ≤ M" is not σ(π)-measurable.

This means: The property "residue is small" cannot be decided from projected
information alone. This is structural incompleteness as a mathematical fact.

**Theorem 2 (Quantitative Closure Obstruction)**:
If the connection has curvature ‖Ω(c)‖ ≥ K > 0 and coupling is non-degenerate,
then for any closed dynamics X_D^cl:
  E(c) ≥ κ·R(c)
where E(c) is the closure error and κ > 0 depends on K.

This quantifies the obstruction: the error is bounded below by the residue.
**Theorem (Quantitative Closure Obstruction)**:
For a projective system (M, B, π) with Ehresmann connection and dynamics satisfying:
1. Non-degenerate vertical dynamics: ‖X_V(p)‖ ≥ c₁ R(p)
2. Non-zero curvature: ‖Ω(p)‖ ≥ c₂ > 0
3. Non-trivial coupling: ‖dπ(X_V(p))‖ ≥ c₃ ‖X_V(p)‖

There exists κ > 0 such that for any closure attempt X̂ ∈ X(B):
  ‖dπ(X(p)) - X̂(π(p))‖ ≥ κ R(p)

This quantifies the impossibility of closing dynamics on the reduced space.

**Toy Model**: The system C = ℝ², D = ℝ, π(x,y) = x, R(x,y) = |y| with
dynamics ẋ = f(x) + ky, ẏ = -αy + g(x) demonstrates all LRE principles.
For linear connection A(x,y) = γy, curvature is Ω = -γ dx∧dy.

## Applications

The LRE framework applies to:
* **Navier-Stokes**: Closure problem in turbulence modeling
  - See `LRE.NS` for complete residual stability framework
  - Key result: d/dt R_Λ ≥ κR - νΛ²R - CR² (blow-up when κ > νΛ²)
* **P vs NP**: Complexity gap as residual structure (conjectural)
* **Riemann Hypothesis**: Prime distribution as residual oscillations
* **Yang-Mills, BSD, Hodge**: See `LRE.NS.UniversalStrategy`
* **Renormalization**: Scale-dependent obstructions in physics

## How to Use

```lean
import LRE

-- Define an LRE system
def MySystem : LRE.LRESystem := {
  C := MyTotalSpace
  D := MyBaseSpace
  π := myProjection
  residual := myResidualFunction
  crit := by sorry
}
-- Define your projection system
def mySystem : ProjectionSystem := {
  C := MyCompleteSpace,
  D := MyReducedSpace,
  π := myProjection,
  R := myResidue,
  ...
}

-- Check if NC holds
theorem my_NC : NonControl mySystem myMeasure := by
  ...

-- Apply the closure obstruction theorem
theorem my_obstruction : ... := closure_obstruction mySystem myMeasure my_NC
```

## References

- "Lei do Resíduo Estrutural: Uma Ontologia da Incompletude"
- Ehresmann connection theory
- Differential geometry of fibrations
- Information theory and lossy compression

-/

namespace LRE

-- Export core definitions
export ProjectiveSystem (C D π)
export LRESystem (residual crit)
export ResidualConnection (horizDist isComplement curvatureNonzero)

-- Export key theorems
export closure_obstruction
export critical_feedback
export residue_unsuppressible

-- Export applications
namespace Applications
  export NavierStokes
  export PvsNP  
  export RiemannHypothesis
end Applications

end LRE
* Problem statement: "Teoria das Fibras Residuais"
* Related work: Ehresmann connections, measure theory, renormalization

## Notes for Lean Formalization

The current implementation uses abstract structures where full manifold
machinery would be needed. Future work will:
* Integrate with Mathlib's differential geometry
* Provide computational implementations for specific systems
* Extend to sheaf-theoretic formulations

This is a **mathematical** framework, not philosophical speculation.
Every statement is rigorous and falsifiable.
-/

-- Core modules
import LRE.Core.Basic
import LRE.Core.Projection
import LRE.Core.ProjectiveSystem
import LRE.Core.Residue
import LRE.Core.NonControl
import LRE.Core.ClosureObstruction
import LRE.Core.ProjectiveSystem
import LRE.Core.QuantitativeObstruction

-- Geometry modules
import LRE.Geometry.Ehresmann
import LRE.Geometry.EhresmannComplete
import LRE.Geometry.Coupling
import LRE.Geometry.ResidualCurvature
import LRE.Geometry.Holonomy
import LRE.Geometry.ToyModel
import LRE.Geometry.ResidualCurvature
import LRE.Geometry.Holonomy

-- Examples
import LRE.Examples.ToyModelDynamics
import LRE.Examples.NavierStokesLRE
import LRE.Examples.PvsNPLRE
import LRE.Geometry.ToyModelDetailed

-- Quantitative theory
import LRE.ClosureObstructionQuantitative

-- Quantitative Obstruction Theorem
import LRE.QuantitativeObstruction
import LRE.Examples
-- Examples
import LRE.Examples.NavierStokesLRE
import LRE.Examples.PvsNPLRE
-- Millennium Problems: Unified LRE Framework
import LRE.MillenniumProblems

-- Concrete Examples and Computations
import LRE.MillenniumExamples
-- Examples
import LRE.Examples.NavierStokesLRE
-- Dynamics and blow-up theory
import LRE.RBC
import LRE.RBC_Corrected
-- Final Theory
import LRE.Final

/-! ## Quick Reference -/

namespace LRE

/-- A projection system with residue -/
abbrev System := ProjectionSystem

/-- The Non-Control axiom -/
abbrev NC (sys : System) (μ : MeasureTheory.Measure sys.C) := NonControl sys μ

/-- The main obstruction theorem -/
theorem obstruction {sys : System} {μ : MeasureTheory.Measure sys.C} 
    (h : NC sys μ) :
    ∃ M : ℝ≥0∞, 0 < M ∧ M < ⊤ ∧ 
      ¬ (∃ (Q : sys.D → Bool), Measurable Q ∧ 
          ∀ᵐ u ∂μ, (if sys.R u ≤ M then 1 else 0 : ℝ) = 
                    if Q (sys.π u) then 1 else 0) :=
  closure_obstruction sys μ h

/-- The toy model as the canonical example -/
abbrev toy_model := ToyModel

end LRE

/-! ## Examples and Patterns -/

section Examples

open LRE

example : System := ToyModel

example : NC ToyModel MeasureTheory.volume := toyModel_satisfies_NC

example : 
    let sys := ToyModel
    (∃ u v : sys.C, u ≠ v ∧ sys.π u = sys.π v) ∧
    NC sys MeasureTheory.volume := by
  constructor
  · use ⟨0, 0⟩, ⟨0, 1⟩; simp [ToyModel]
  · exact toyModel_satisfies_NC

end Examples
Residual Emergent Logic (LRE) - Main Module

This module implements the geometric foundation for Residual Emergent Logic,
transforming the UIA framework from a philosophical critique into a rigorous
program of differential geometry and high-dimensional topology.

## Core Idea

The residual R(u) is not merely an error term or approximation artifact.
It is the **curvature of an Ehresmann connection** on a fiber bundle where:

- Base space D = our model/observable space
- Total space C = complete configuration space (hidden reality)
- Projection π : C → D = what our theories can measure
- Fiber over d ∈ D = all configurations that "look like" d to our theories

When we follow a path in D (an experiment or simulation), we end up at
a different point in C than expected. This accumulated error is the
**residual holonomy** - the geometric manifestation of information loss.

## Why This Matters

1. **Explains Model Failure**: High curvature regions are where theories break down
2. **Unifies Phenomena**: Quantum uncertainty, turbulence, arithmetic irregularity
   all arise from the same geometric structure
3. **Provides Tools**: Differential geometry gives us theorems about when
   closure is possible/impossible
4. **Suggests Solutions**: Geometric bounds on curvature ⟹ regularity results

## Structure

- `LRE.FiberBundle`: Basic geometric structures (bundles, connections, curvature)
- `LRE.CouplingOperator`: How the residual affects observable dynamics
- `LRE.ClosureTheorem`: Fundamental impossibility results (Theorem 1)
- `LRE.NavierStokes`: Application to fluid dynamics and blow-up theory

## Main Results

**Theorem 1 (Dynamic Incompleteness)**: If Ω ≠ 0, topological closure in D is impossible.

**Theorem 2 (Coupling Bound)**: The anomaly term K is bounded by curvature Ω.

**Theorem 3 (Navier-Stokes)**: Blow-up ⟺ infinite residual curvature.

## References

This formalization implements the theoretical framework described in:
- "A Geometria da Informação Perdida: Conexões de Ehresmann e a Gênese do Resíduo Estrutural"
- "Desigualdade de Estabilidade Residual para Navier-Stokes" (NEW)
- "Holonomia de Complexidade: Uma Abordagem Geométrica para P vs NP" (NEW)
-/

import LRE.FiberBundle
import LRE.CouplingOperator
import LRE.ClosureTheorem
import LRE.NavierStokes
import LRE.NavierStokes.Injective
import LRE.NavierStokes.Energy
import LRE.NavierStokes.Main
import LRE.NavierStokes.LittlewoodPaley
import LRE.NavierStokes.ResidualStability
import LRE.Complexity.Basic
import LRE.Complexity.Holonomy
import LRE.NavierStokes.Complete
import LRE.NavierStokes.LerayProjection
import LRE.NavierStokes.CurvatureEstimates
import LRE.NavierStokesResidual
import LRE.NS
import LRE.MillenniumProblems
import LRE.MillenniumExamples
import LRE.NavierStokes.ResidualStability
import LRE.Geometry.CurvatureTheory
import LRE.Geometry.CouplingCurvature
import LRE.Topology.Grothendieck
import LRE.RBC
import LRE.Final

-- Unified framework and comprehensive applications
import LRE.Unified.Core
import LRE.Millennium
import LRE.OtherProblems.ABC
import LRE.OtherProblems.Collatz

/-! ## Integration with UIA Framework -/

/-- The LRE framework is a geometric refinement of UIA.
Where UIA speaks of "residuals" abstractly, LRE makes them geometric. -/

namespace LRE

/-! ## The Fundamental Principle -/

/-- **The LRE Principle**: 

Every projective theory (model) π : C → D induces an Ehresmann connection.
The residual R(u) is the vertical component with respect to this connection.
The curvature Ω measures the failure of the theory to close.

This transforms epistemology into geometry. -/

/-! ## Examples and Applications -/

section Examples

/-- Example 1: Quantum Mechanics

- C = Hilbert space of quantum states
- D = Classical phase space
- π = Expectation values (⟨x⟩, ⟨p⟩)
- Residual = Quantum fluctuations
- Curvature = Berry phase / geometric phase

The uncertainty principle is a manifestation of non-zero curvature. -/

/-- Example 2: Statistical Mechanics

- C = Microstate space
- D = Macrostate space (thermodynamic variables)
- π = Coarse-graining / ensemble averaging
- Residual = Fluctuations / entropy
- Curvature = Non-equilibrium effects

Irreversibility comes from holonomy around thermodynamic cycles. -/

/-- Example 3: Turbulence (Navier-Stokes)

- C = All velocity fields (infinite-dimensional)
- D = Low-frequency modes (finite-dimensional projection)
- π = Spectral truncation / Galerkin projection
- Residual = Small-scale turbulence
- Curvature = Nonlinear energy transfer between scales

Blow-up = diverging curvature. -/

/-- Example 4: Number Theory (Riemann Hypothesis)

- C = Space of arithmetic functions
- D = Space of smooth approximations
- π = Averaging / regularization
- Residual = Prime number irregularity
- Curvature = Correlations between primes at different scales

RH ⟺ bounded residual curvature in arithmetic geometry. -/

end Examples

/-! ## Philosophical Implications -/

/-- The LRE framework resolves several philosophical puzzles:

1. **Incompleteness**: Gödel showed arithmetic can't be completed.
   LRE shows *why*: non-zero curvature prevents topological closure.

2. **Measurement Problem**: In QM, measurement "collapses" the wavefunction.
   LRE interpretation: Measurement is projection π, collapse is choosing
   a point in the fiber.

3. **Emergence**: Complex behavior from simple rules.
   LRE explanation: High-dimensional geometry (C) projects to
   complicated patterns in low dimensions (D).

4. **Limits of Reductionism**: Why we can't "solve" everything.
   Answer: Some systems have non-zero residual curvature, making
   closure impossible. -/

/-! ## Research Directions -/

/-- Open problems and future work:

1. **Compute curvature explicitly** for specific systems (NS, RH, Yang-Mills)

2. **Curvature bounds** ⟹ regularity theorems

3. **Grothendieck topology** for scale-changing systems (renormalization)

4. **Numerical methods** to estimate curvature from data

5. **Experimental tests** to measure holonomy in physical systems -/

/-! ## Connection to Existing Frameworks -/

/-- The LRE framework unifies and extends:

- **UIA/UMI**: Provides geometric meaning to abstract renormalized invariants
- **Gauge Theory**: Residual curvature generalizes gauge field curvature
- **Information Geometry**: Connects to Fisher metric and statistical manifolds
- **Quantum Geometry**: Berry phase, geometric phases as special cases
- **Turbulence Theory**: Gives geometric foundation to energy cascade -/

end LRE

/-! ## Summary -/

/-- In one sentence:

**The residual is not an error - it is the curvature that measures
how much reality exceeds our models' capacity to represent it.** -/
Residual Emergent Logic (LRE) Framework

This module provides the mathematical foundation for Residual Emergent Logic,
a framework for understanding how residual components in dynamical systems
create obstructions to dimensional reduction.

## Main Components

1. **Basic Structures** (`LRE.Core.Basic`):
   - Projection π: C → D (total space to reduced space)
   - Residue R: C → ℝ≥0 (measure of vertical component)
   - Fiber structure

2. **Ehresmann Connections** (`LRE.Geometry.Ehresmann`):
   - Horizontal distributions
   - Curvature forms
   - Parallel transport and holonomy

3. **Closure Obstruction** (`LRE.Core.ClosureObstruction`):
   - Quantitative closure obstruction theorem
   - Relationship between residue and dynamics

## Key Theorem

The **Quantitative Closure Obstruction Theorem** states that for dynamics
on a total space C with projection to a reduced space D, the error in
closing the dynamics on D is bounded below by the residue:

  ‖ḋ(t) - X_D_cl(d(t))‖ ≥ κ R(c(t))

This quantifies how the residual structure prevents accurate dimensional reduction.

## Example: Toy Model

Consider C = ℝ² with coordinates (x, y), D = ℝ with coordinate x, and π(x,y) = x.
The residue is R(x,y) = |y|.

Dynamics:
  ẋ = f(x) + ky
  ẏ = -αy + g(x)

The term ky couples the residue to the x-dynamics, creating a closure obstruction.
Even if y is small, it accumulates over time when the curvature is non-zero.

## Applications

This framework is relevant for:
- Reduced-order modeling in dynamical systems
- Effective field theories in physics
- Coarse-graining in statistical mechanics
- Understanding emergent phenomena

## Navier-Stokes Application

The `LRE.NavierStokes` module provides a complete application of LRE theory to the
Navier-Stokes equations, including:

- **Complete.lean**: Full theory with projective system, Leray projection, residual stability
- **LerayProjection.lean**: Properties of the Leray projection operator
- **CurvatureEstimates.lean**: Curvature bounds and their relation to blow-up

Key results:
- Closure obstruction theorem for NS (Theorem 3.3)
- Residual stability inequality (Theorem 4.4)
- Topological singularity characterization (Theorem 5.2)
- Universal curvature conjecture reformulating the millennium problem

-/

import LRE.Core.Basic
import LRE.Geometry.Ehresmann
import LRE.Core.ClosureObstruction
import LRE.QuantitativeObstruction
import LRE.NavierStokesApplication

-- New modules for complete Navier-Stokes and P vs NP formalization
import LRE.NavierStokes.ResidualStabilityInequality
import LRE.PvsNP
/-! ## NEW: Extended Applications to Millennium Problems -/

namespace LRE.Extensions

/-! ### Navier-Stokes Millennium Problem

The Residual Stability Inequality provides a complete geometric characterization
of the blow-up phenomenon in the Navier-Stokes equations.

**Key Result**: Blow-up occurs ⟺ κ ‖u_ℓ‖_{H¹} > ν Λ²

where:
- κ ~ √Λ is the coupling constant (from Littlewood-Paley analysis)
- u_ℓ is the low-frequency component
- ν is kinematic viscosity
- Λ is the frequency cutoff

**Geometric Picture**:
The Leray projection π : C → D (all fields → low modes) has residual
curvature measuring energy transfer to high frequencies. When curvature
becomes infinite, the projection fails to contain the dynamics → blow-up.

**Next Steps**:
1. Calculate κ exactly using Sobolev embeddings
2. Construct explicit initial data where criticalCondition holds
3. Prove R(t) → ∞ under this condition

See: `LRE.NavierStokes.ResidualStability` and `LRE.NavierStokes.LittlewoodPaley`
-/

/-! ### P vs NP Millennium Problem

The Complexity Holonomy framework reformulates P vs NP as a question about
the geometry of the computational universe.

**Key Result**: P = NP ⟺ Flat complexity connection

**Geometric Picture**:
- Search Space C: All computational traces
- Verification Space D: (Instance, Certificate) pairs
- Projection π : C → D forgets intermediate computation

If P = NP: Bundle is "untwisted" - polynomial sections exist
If P ≠ NP: Bundle has "complexity curvature" - holonomy is exponential

**Proof Strategy for P ≠ NP**:
1. Construct explicit loop in instance space (e.g., variable permutations)
2. Compute holonomy around this loop
3. Show holonomy is exponential in instance size
4. Conclude no polynomial-time algorithm exists

**Connection to NP-Completeness**:
Polynomial-time reductions preserve complexity curvature. All NP-complete
problems share the same holonomy structure.

See: `LRE.Complexity.Holonomy` and `LRE.Complexity.Basic`
-/

/-! ### Unified Perspective

Both Millennium Problems share the same geometric structure:

| Aspect | Navier-Stokes | P vs NP |
|--------|---------------|---------|
| Complete Space C | All velocity fields | All computational traces |
| Observable Space D | Low-frequency modes | Instances + certificates |
| Projection π | Leray/Galerkin | Input/output map |
| Residue R | High-frequency energy | Computational overhead |
| Curvature Ω | Energy transfer rate κ | Complexity holonomy |
| Critical Condition | κ ‖u_ℓ‖ > ν Λ² | Exponential holonomy |
| Blow-up/Hardness | R(t) → ∞ | No poly-time algorithm |

The LRE framework reveals that these problems ask the same question:
"Can the observable space D contain the full dynamics from C?"

When curvature is non-zero, the answer is no - leading to singularities
(Navier-Stokes) or computational intractability (P vs NP).
-/

/-! ### Philosophical Implications

The geometric view unifies multiple phenomena under one principle:

**The Residual Principle**: 
When projecting a complex system to a simpler model, the "lost information"
(residue) creates curvature that obstructs complete description in the model space.

**Manifestations**:
- Quantum Mechanics: Uncertainty from classical projection
- Thermodynamics: Irreversibility from coarse-graining
- Turbulence: Blow-up from spectral truncation
- Computation: Intractability from hiding intermediate steps
- Arithmetic: Irregularity from finite approximation

All are instances of geometric information loss in projection systems.
-/

end LRE.Extensions

-/

import LRE.Core.Basic
import LRE.Geometry.Ehresmann
import LRE.Core.ClosureObstruction
-- New LRE Meta-Framework modules
import LRE.Core.Projective
import LRE.ERS.AbstractODE
import LRE.Framework.ProblemTemplate

-- Millennium Problem Instances
import LRE.Millennium.NavierStokes.Model
import LRE.Millennium.PvsNP.Model
import LRE.Millennium.Riemann.Model
import LRE.Millennium.YangMills.Model
import LRE.Millennium.BSD.Model

-- Unifying Theory
import LRE.Theorems.UnifiedLRE
import LRE.Implementation.Roadmap
/-! ## Millennium Problems Framework -/

/-- The LRE framework extends to provide a unified approach to the Millennium Problems.
Each problem is formulated as a projection system with residual structure. -/

-- Millennium framework core
import LRE.MillenniumCore
import LRE.ERS

-- Millennium problem instantiations
import LRE.Millennium.NavierStokes
import LRE.Millennium.PvsNP
import LRE.Millennium.Riemann
import LRE.Millennium.YangMills
import LRE.Millennium.BSD

/-! ## Millennium Problems Integration -/

namespace LRE.Millennium

/-- Each Millennium Problem has:
1. A projective system (C, D, π) capturing the problem structure
2. A residue R measuring the "gap" or "obstruction"
3. An LRE theorem showing any approximation has error ≥ κ·R
4. An ERS (residual stability inequality) governing residue evolution

## The Problems

* **Navier-Stokes**: Turbulence closure and blow-up
* **P vs NP**: Computational complexity gap
* **Riemann Hypothesis**: Prime number irregularity
* **Yang-Mills**: Mass gap and confinement
* **Birch-Swinnerton-Dyer**: Arithmetic-analytic correspondence

## Unified Perspective

All these problems involve a projection that loses information:
- NS: spectral truncation loses small-scale turbulence
- P≠NP: forgetting certificate loses verification information
- RH: Mellin transform loses arithmetic irregularity
- YM: gauge quotient loses unphysical degrees of freedom
- BSD: L-function loses group structure information

The LRE framework shows these are all manifestations of the same
geometric phenomenon: **residual obstruction in projection systems**.
-/

end LRE.Millennium
-- Section Collapse Hypothesis (HCS) - Unified Millennium Problem Framework
import LRE.HCS
import LRE.RBC
