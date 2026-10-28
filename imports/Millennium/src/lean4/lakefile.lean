import Lake
open Lake DSL

package RhPnp where
  -- Package configuration
  leanOptions := #[
    ⟨`pp.unicode.fun, true⟩,
    ⟨`autoImplicit, false⟩
  ]

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git"

@[default_target]
lean_lib RhPnp where
  -- Library configuration
  roots := #[`RhPnp]
package millennium where
  -- add package configuration options here

lean_lib Millennium where
  -- add library configuration options here
  srcDir := "."

@[default_target]
lean_exe «millennium» where
  root := `Main

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git" @ "v4.3.0"
-- Lakefile for Millennium Delta-Unified Framework
-- Formal verification of the Δ-Unified Theorem structure

import Lake
open Lake DSL

package Millennium where
  leanOptions := #[
    ⟨`pp.unicode.fun, true⟩,
    ⟨`pp.proofs.withType, false⟩
  ]

@[default_target]
lean_lib Millennium where
  globs := #[.submodules `Millennium]
  srcDir := "Millennium"
