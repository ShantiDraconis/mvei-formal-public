/-
Copyright (c) 2025 ShantiDraconis. All rights reserved.
Released under MIT license.

# Unified: Main Export Module

This is the main entry point for the Unified framework.
It exports all core components for the Universal Emergent Logic approach
to the Millennium Prize Problems.

## Overview

The Unified framework provides:

1. **Mathematical Foundation** (`Kernel`)
   - 38-dimensional parameter space Θ = Fin 38 → ℝ
   - Coupling matrix C with stability conditions
   - Quadratic energy V(θ) = 1/2 ⟪θ, C·θ⟫
   - StableModel structure

2. **Semantic Layer** (`Indices`)
   - Named access to all 38 parameters
   - Parameter organization by problem domain
   - Validation and constraint checking

3. **Coupling Matrix** (`Coupling`)
   - Matrix definitions and properties
   - Positive definiteness certificates
   - Block structure for different domains

4. **Bridge Theorems**
   - Axioms connecting stability to problem solutions
   - Unification theorem: StableModel → AllSolved
   - Path to replace axioms with proofs

## Quick Start

```lean
import Unified

open Unified

-- Access the core types
#check Θ                    -- Parameter space
#check Coupling             -- Matrix type
#check StableModel          -- Stable configuration

-- Use named parameters
#check idx_α_RH             -- Riemann Hypothesis parameter
#check idx_ν                -- Navier-Stokes viscosity
#check idx_m_gap            -- Yang-Mills mass gap

-- Main theorem
example (M : StableModel) : AllSolved θ₀ := unification M
```

## Module Organization

- `Unified.Kernel`: Core mathematical definitions
- `Unified.Indices`: Named parameter access
- `Unified.Coupling.Definition`: Coupling matrix structure
- `Unified.Coupling.PosDefCert`: Positive definiteness certificates

## Design Philosophy

This implementation follows key principles:

1. **Compile First**: Framework compiles immediately, proofs come later
2. **Native Types**: Use Fin n → ℝ instead of custom manifolds
3. **Separation**: Core math separate from problem-specific content
4. **Bridges**: Problems connected via explicit axioms → theorems
5. **Incrementality**: Each piece can be refined independently

## Status

✅ **Implemented**:
- Core type definitions
- Parameter space structure
- Energy and stability conditions
- Named parameter indices
- Coupling matrix framework
- Certificate infrastructure
- Unification theorem (via bridges)

🔄 **In Progress**:
- Actual coupling matrix coefficients
- Positive definiteness certificate
- Refined problem predicates

⏳ **Future Work**:
- Replace bridge axioms with theorems
- Numerical validation
- Connection to classical formulations
- Extended problem coverage

-/

-- Core framework
import Unified.Kernel
import Unified.Indices

-- Coupling matrix
import Unified.Coupling.Definition
import Unified.Coupling.PosDefCert

-- Problem-specific modules
import Unified.Problems.RH
import Unified.Problems.NS
import Unified.Problems.PNP
import Unified.Problems.YM
import Unified.Problems.Hodge
import Unified.Problems.BSD

-- Integration
import Unified.Unification

/-!
## Re-exports

Make key definitions available at top level for convenience.
-/

namespace Unified

-- Export main types (already in Kernel)
-- These are automatically available via `import Unified.Kernel`

end Unified

/-!
## Documentation

### For Users

Start with `Unified.Kernel` to understand the core types and theorems.
Then use `Unified.Indices` for named parameter access.

### For Developers

1. **Adding Parameters**: Update N in Kernel.lean, add indices in Indices.lean
2. **Refining Predicates**: Edit problem predicates in Kernel.lean
3. **Proving Bridges**: Replace axioms with theorems, citing Mathlib results
4. **Coupling Matrix**: Update Definition.lean or provide certificate in PosDefCert.lean

### For Reviewers

The key innovation is the bridge architecture:
```
StableModel → bridge_RH → RH_holds
StableModel → bridge_NS → NS_regular
...
StableModel → unification → AllSolved
```

Each bridge is a mathematical debt that can be paid independently.

## References

- Problem Statement: See repository documentation
- Mathlib: https://leanprover-community.github.io/mathlib4_docs/
- Lean 4: https://lean-lang.org/

## License

Released under MIT license. See LICENSE file.
-/
