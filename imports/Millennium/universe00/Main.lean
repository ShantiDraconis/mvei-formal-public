/-
# Main Entry Point

Demonstrates the universe00 error-based mathematical framework.
-/

import Universe00.Examples.RH_Ledger
import Universe00.Examples.NS_Ledger
import Universe00.Examples.BSD_Ledger

def main : IO Unit := do
  IO.println "╔═══════════════════════════════════════════════════════════════╗"
  IO.println "║         universe00 — Error-Based Mathematical Framework        ║"
  IO.println "╚═══════════════════════════════════════════════════════════════╝"
  IO.println ""
  IO.println "Core Principle: Each parameter is inseparable from its error."
  IO.println "The error is the coordinate of proof itself."
  IO.println ""
  IO.println "═══════════════════════════════════════════════════════════════"
  IO.println ""
  
  -- Riemann Hypothesis examples
  Examples.RH.analyzeAllExamples
  IO.println "═══════════════════════════════════════════════════════════════"
  IO.println ""
  Examples.RH.demonstrateMonotoneProgress
  IO.println ""
  IO.println "═══════════════════════════════════════════════════════════════"
  IO.println ""
  
  -- Navier-Stokes examples
  Examples.NS.analyzeAllExamples
  IO.println "═══════════════════════════════════════════════════════════════"
  IO.println ""
  Examples.NS.demonstrateMultiParameterProgress
  IO.println ""
  IO.println "═══════════════════════════════════════════════════════════════"
  IO.println ""
  
  -- BSD examples
  Examples.BSD.analyzeAllExamples
  IO.println "═══════════════════════════════════════════════════════════════"
  IO.println ""
  Examples.BSD.compareErrorProfiles
  IO.println ""
  IO.println "═══════════════════════════════════════════════════════════════"
  IO.println ""
  IO.println "Framework Summary:"
  IO.println "- All mathematics is classical (ZFC-compatible)"
  IO.println "- All parameters have explicit errors in [0,1]"
  IO.println "- Proof = complete collapse of error vector to zero"
  IO.println "- Progress is monotone (errors never increase)"
  IO.println "- Everything is typed, measurable, and auditable"
  IO.println ""
  IO.println "This framework does NOT claim to solve any problems."
  IO.println "It quantifies exactly what is missing."
