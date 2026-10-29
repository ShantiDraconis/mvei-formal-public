import Lake
open Lake DSL

package «millennium-hodge» where

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git" @ "v4.19.0"

lean_lib HodgeStructural where
  roots := #[`HodgeStructuralCore]
