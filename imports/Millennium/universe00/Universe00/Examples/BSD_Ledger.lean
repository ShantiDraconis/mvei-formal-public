/-
# BSD Ledger Example

Complete example demonstrating ledger construction and analysis for BSD.
-/

import Universe00.Problems.BSD

namespace Examples.BSD

open BSD

/-- Example 1: Current state -/
def example1_currentState : ProblemLedger :=
  currentState

/-- Example 2: Progress on rank equality -/
def example2_rankProgress : ProblemLedger :=
  let params := canonicalParameters
    0.3   -- Improved rank results
    0.7   -- Formula still unproven
    0.8   -- Sha still open
    (by constructor <;> norm_num)
    (by constructor <;> norm_num)
    (by constructor <;> norm_num)
  createLedger params

/-- Example 3: Breakthrough on Sha finiteness -/
def example3_shaBreakthrough : ProblemLedger :=
  let params := canonicalParameters
    0.2   -- Further rank progress
    0.5   -- Partial formula results
    0.3   -- Major Sha progress
    (by constructor <;> norm_num)
    (by constructor <;> norm_num)
    (by constructor <;> norm_num)
  createLedger params

/-- Example 4: Solved state -/
def example4_solved : ProblemLedger :=
  solvedState

/-- Analysis: Print all example summaries -/
def analyzeAllExamples : IO Unit := do
  IO.println "=== BSD Conjecture Ledger Examples ===\n"
  
  IO.println "Example 1: Current State"
  IO.println (example1_currentState.summary)
  IO.println ""
  
  IO.println "Example 2: Rank Equality Progress"
  IO.println (example2_rankProgress.summary)
  IO.println ""
  
  IO.println "Example 3: Sha Finiteness Breakthrough"
  IO.println (example3_shaBreakthrough.summary)
  IO.println ""
  
  IO.println "Example 4: Solved State"
  IO.println (example4_solved.summary)
  IO.println ""

/-- Compare error profiles across examples -/
def compareErrorProfiles : IO Unit := do
  IO.println "=== Error Profile Comparison ===\n"
  IO.println "Parameter           | Current | Rank↑   | Sha↓    | Solved"
  IO.println "--------------------|---------|---------|---------|--------"
  IO.println s!"Rank Discrepancy    | 0.50    | 0.30    | 0.20    | 0.00"
  IO.println s!"Leading Term        | 0.70    | 0.70    | 0.50    | 0.00"
  IO.println s!"Sha Control         | 0.80    | 0.80    | 0.30    | 0.00"
  IO.println "--------------------|---------|---------|---------|--------"
  IO.println s!"Total Error         | {example1_currentState.totalError}  | {example2_rankProgress.totalError}  | {example3_shaBreakthrough.totalError}  | 0.00"

end Examples.BSD
