import Lake
open Lake DSL

package teoriaMishkan

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git" @ "v4.19.0"

-- Fechamento/Formal.lean importa proofs/FORMAL_VERIFICATIONS.lean do autor (imports/mishkan-iii-core, com os patches
-- de correcoes/): fica fora do alvo padrão
@[default_target] lean_lib TeoriaMishkan where
  globs := #[.submodules `MveiEstrutura, .submodules `archaeology]
