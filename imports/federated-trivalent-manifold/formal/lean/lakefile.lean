import Lake
open Lake DSL

require mathlib from git
  "https://github.com/leanprover-community/mathlib4" @ "v4.8.0"

package «federated-trivalent-manifold» where

lean_lib Trivalent where
  srcDir := "."

lean_lib Model where
  srcDir := "."

lean_lib AnaliseTanhParaH1 where
  srcDir := "../../ANALISE_TANH_PARA_H1"

lean_lib FlowOperators where
  srcDir := "."

lean_lib AnomalyKernel where
  srcDir := "."

lean_lib FiniteScale where
  srcDir := "."

lean_lib RadialGeometry where
  srcDir := "."

lean_lib FiniteEvidence where
  srcDir := "."
