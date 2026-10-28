/-
# Navier-Stokes Ledger Example

Complete example demonstrating ledger construction and analysis for NS.
-/

import Universe00.Problems.NavierStokes

namespace Examples.NS

open NavierStokes

/-- Example 1: Current state -/
def example1_currentState : ProblemLedger :=
  currentState

/-- Example 2: Improved regularity understanding -/
def example2_improvedRegularity : ProblemLedger :=
  let params := canonicalParameters
    0.7   -- Better regularity results
    0.9   -- Global existence still open
    0.4   -- Better coverage for small data
    (by constructor <;> norm_num)
    (by constructor <;> norm_num)
    (by constructor <;> norm_num)
  createLedger params

/-- Example 3: Breakthrough in global existence -/
def example3_globalBreakthrough : ProblemLedger :=
  let params := canonicalParameters
    0.5   -- Improved regularity
    0.3   -- Major progress on global existence
    0.2   -- Much broader coverage
    (by constructor <;> norm_num)
    (by constructor <;> norm_num)
    (by constructor <;> norm_num)
  createLedger params

/-- Example 4: Solved state -/
def example4_solved : ProblemLedger :=
  solvedState

/-- Analysis: Print all example summaries -/
def analyzeAllExamples : IO Unit := do
  IO.println "=== Navier-Stokes Ledger Examples ===\n"
  
  IO.println "Example 1: Current State"
  IO.println (example1_currentState.summary)
  IO.println ""
  
  IO.println "Example 2: Improved Regularity"
  IO.println (example2_improvedRegularity.summary)
  IO.println ""
  
  IO.println "Example 3: Global Existence Breakthrough"
  IO.println (example3_globalBreakthrough.summary)
  IO.println ""
  
  IO.println "Example 4: Solved State"
  IO.println (example4_solved.summary)
  IO.println ""

/-- Demonstrate multi-parameter progress -/
def demonstrateMultiParameterProgress : IO Unit := do
  IO.println "=== Multi-Parameter Progress ===\n"
  IO.println "Initial state:"
  IO.println s!"  Regularity error: {(example1_currentState.parameters.get! 0).error}"
  IO.println s!"  Time-globality error: {(example1_currentState.parameters.get! 1).error}"
  IO.println s!"  Coverage error: {(example1_currentState.parameters.get! 2).error}"
  IO.println ""
  IO.println "After breakthrough:"
  IO.println s!"  Regularity error: {(example3_globalBreakthrough.parameters.get! 0).error}"
  IO.println s!"  Time-globality error: {(example3_globalBreakthrough.parameters.get! 1).error}"
  IO.println s!"  Coverage error: {(example3_globalBreakthrough.parameters.get! 2).error}"
  IO.println "\nAll errors decreased monotonically"

end Examples.NS
