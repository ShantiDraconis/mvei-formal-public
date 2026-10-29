import Lake
open Lake DSL

package «umi» where
  version := v!"0.1.0"

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git"

@[default_target]
lean_lib «UMI» where
  roots := #[`UMI]

lean_lib «LRE» where
  roots := #[`LRE]

lean_lib «UniversalisStructuralis» where
  roots := #[`UniversalisStructuralis]
lean_lib «Millennium» where
  roots := #[`Millennium]

lean_lib «Unified» where
  roots := #[`Unified]
lean_lib «StabilityBundle» where
  roots := #[`Millennium.StabilityBundle]
