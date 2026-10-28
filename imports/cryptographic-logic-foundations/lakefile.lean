import Lake
open Lake DSL

package «cryptographic-logic-foundations» where
  -- add package configuration options here

lean_lib «CryptographicLogic» where
  -- add library configuration options here

@[default_target]
lean_exe «cryptographic-logic-foundations» where
  root := `Main

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git"
package «universe-0-0» where
  -- Project metadata
  version := v!"0.0.1"
  
  -- Lean version
  leanOptions := #[
    ⟨`pp.unicode.fun, true⟩,
    ⟨`autoImplicit, false⟩
  ]

@[default_target]
lean_lib «Universe00» where
  roots := #[
    `Universe00.Layer0,
    `Universe00.Microkernel,
    `Universe00.MemoryQuadrants,
    `Universe00.BootSequence
  ]
  globs := #[.submodules `Universe00]

-- Layer 0: Symmetry Kernel
lean_lib Universe00.Layer0 where
  srcDir := "kernel/layer0-symmetry"
  
-- Microkernel
lean_lib Universe00.Microkernel where
  srcDir := "kernel/microkernel"
  
-- Memory Quadrants
lean_lib Universe00.MemoryQuadrants where
  srcDir := "kernel/memory-quadrants"

-- Boot Sequence
lean_lib Universe00.BootSequence where
  srcDir := "formal-proofs/lean4"
