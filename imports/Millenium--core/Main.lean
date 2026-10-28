-- Main.lean
-- Entry point for the Millenium-core project.
-- Imports all core modules and application modules.

import Core.Types
import Core.State
import Core.Theorems
import Core.Rewriting
import Modules.PvsNP
import Modules.Riemann
import Modules.NavierStokes
import Modules.BSD
import Modules.Hodge
import Modules.YangMills

/-- Summarise the project structure. -/
def main : IO Unit := do
  IO.println "Millenium-core: The Indeterminate Framework (TIF)"
  IO.println "=================================================="
  IO.println ""
  IO.println "Core modules loaded:"
  IO.println "  · Core.Types      – Indeterminate expression syntax"
  IO.println "  · Core.State      – Meta-arithmetic state and collapse"
  IO.println "  · Core.Theorems   – Fundamental theorems (consistency, conservativity, collapse criterion)"
  IO.println "  · Core.Rewriting  – Reduction relation →_R and normal forms"
  IO.println ""
  IO.println "Application modules loaded:"
  IO.println "  · Modules.PvsNP        – P vs NP"
  IO.println "  · Modules.Riemann      – Riemann Hypothesis"
  IO.println "  · Modules.NavierStokes – Navier-Stokes (3D incompressible)"
  IO.println "  · Modules.BSD          – Birch-Swinnerton-Dyer"
  IO.println "  · Modules.Hodge        – Hodge Conjecture"
  IO.println "  · Modules.YangMills    – Yang-Mills Mass Gap"
  IO.println ""
  IO.println "All theorems are stated; proofs deferred to Papers 1-9 (see BLUEPRINT.md)."
