-- =============================================================================
-- Universal Millennium Framework - Lean 4 Lake Configuration
-- =============================================================================
-- This file configures the Lean 4 project for formal mathematical proofs
-- related to the Millennium Prize Problems.
-- =============================================================================

import Lake
open Lake DSL

package «universal» where
  leanOptions := #[
    ⟨`pp.unicode.fun, true⟩,
    ⟨`autoImplicit, false⟩
  ]

-- Mathlib dependency for mathematical foundations
require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git"

-- Main library target
@[default_target]
lean_lib «Universal» where
  srcDir := "lean4"
  roots := #[
    `Zeta,           -- Riemann Hypothesis
    `BSD,            -- Birch and Swinnerton-Dyer
    `Complexity,     -- P vs NP
    `Fluid,          -- Navier-Stokes
    `YangMills,      -- Yang-Mills Mass Gap
    `Hodge,          -- Hodge Conjecture
    `Gravity,        -- General Relativity and Horizons
    `Horizon,        -- Black Hole Horizons
    `Unified,        -- Unified Framework
    `Core            -- Core mathematical structures
  ]

-- Executable for running examples
lean_exe «universal_check» where
  root := `Main
  srcDir := "lean4"
  -- Package configuration for the Universal Millennium Framework
  -- This is a mathematical framework for the Millennium Prize Problems

-- Require Mathlib as a dependency
require mathlib from git
  "https://github.com/leanprover-community/mathlib4"

-- Main library containing all modules
lean_lib «Universal» where
  srcDir := "lean4"
  roots := #[`BSD, `Complexity, `Core, `Fluid, `Gravity, `Hodge, `Horizon, `Unified, `YangMills, `Zeta]

-- Simple test executable
@[default_target]
lean_exe «universal» where
  srcDir := "lean4"
  root := `Main
