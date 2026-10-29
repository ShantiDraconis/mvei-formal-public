-- =============================================================================
-- Universal Millennium Framework - Lean 4 Lake Configuration
-- =============================================================================
-- This file configures the Lean 4 project for formal mathematical proofs
-- related to the Millennium Prize Problems and Theory of Everything.
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
    `Core,           -- Core mathematical structures
    `Geometry,       -- Calabi-Yau and differential geometry
    `Physics,        -- String theory and particle physics
    `Audit           -- Proof verification and audit
  ]

-- Simple test executable
lean_exe «universal» where
  srcDir := "lean4"
  root := `Main
