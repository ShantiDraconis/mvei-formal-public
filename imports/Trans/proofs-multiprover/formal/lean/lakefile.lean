import Lake
open Lake DSL

package «proofs-multiprover» where

@[default_target]
lean_lib ProofsMultiprover where
  -- Main Lean library for multi-prover-certified results

require mathlib from git
  "https://github.com/leanprover-community/mathlib4" @ "master"
