import Lake
open Lake DSL

package «FormalSuite» where
  version := v!"1.0.0"
  -- Keywords for the package
  keywords := #["formal-verification", "mathematics", "field-theory", "zeta", "navier-stokes"]
  -- Lean options
  leanOptions := #[
    ⟨`pp.unicode.fun, true⟩,  -- Use Unicode for function arrows
    ⟨`autoImplicit, false⟩    -- Disable auto-implicit for clarity
  ]

-- Mathlib dependency
require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git" @ "v4.12.0"

-- Main library
@[default_target]
lean_lib «FormalSuite» where
  srcDir := "src"
  roots := #[`FormalSuite]

-- Test library
lean_lib «FormalSuiteTest» where
  srcDir := "test"
  roots := #[`All]
  -- Tests are not included in the default build
  globs := #[.submodules `All]

-- Test executable
lean_exe «test» where
  root := `All
  srcDir := "test"
