import Lake
open Lake DSL

package rh_np_equivalence where
  version := v!"0.1.0"

lean_lib Structures where
  srcDir := "Structures"

lean_lib NonUnification where
  srcDir := "NonUnification"

@[default_target]
lean_exe rh_np_equivalence where
  root := `Main
package «DeltaGap44» where
  -- add package configuration options here

lean_lib «DeltaGap44» where
  -- add library configuration options here
  srcDir := "."

@[default_target]
lean_exe «deltagap44» where
  root := `Main
  -- Enables the use of the Lean interpreter by the executable
  supportInterpreter := true

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git" @ "v4.12.0"
package «rh_prime_stability» where
  -- Settings applied to both the package and its dependencies
  leanOptions := #[
    ⟨`pp.unicode.fun, true⟩,
    ⟨`autoImplicit, false⟩
  ]

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git"

@[default_target]
lean_lib «RHPrimeStability» where
  -- add library configuration options here

-- SOF - Structural Obstruction Framework
lean_lib SOF where
  srcDir := "SOF"

-- Universal Unification Framework
lean_lib UniversalUnification where
  srcDir := "UniversalUnification"
-- Universal - TUNS Framework
lean_lib Universal where
  srcDir := "Universal"

-- TUNS - Tiago's Universal Novelty Theorem
lean_lib TUNS where
  srcDir := "TUNS"

-- NavierStokes - Compression Barrier and LRE Framework
lean_lib NavierStokes where
  srcDir := "NavierStokes"

-- Unified - Millennium Prize Problems Unification Framework
lean_lib Unified where
  srcDir := "Unified"
