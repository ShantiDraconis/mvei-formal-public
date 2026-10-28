import Lake
open Lake DSL

package «heu7» where
  -- Package configuration
  leanOptions := #[
    ⟨`autoImplicit, false⟩,
    ⟨`relaxedAutoImplicit, false⟩
  ]

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git"

@[default_target]
lean_lib «HEU» where
  srcDir := "HEU"
  roots := #[`HEU_Main]
