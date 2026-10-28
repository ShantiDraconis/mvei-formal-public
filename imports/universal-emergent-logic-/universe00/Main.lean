/-
  Main.lean
  
  Entry point for the Universe00 framework.
  
  This file imports all core components and provides a unified interface.
-/

-- Core framework
import Universe00.Core.Parameter
import Universe00.Core.Error
import Universe00.Core.Vector
import Universe00.Core.Aggregation
import Universe00.Core.Status
import Universe00.Core.Ledger
import Universe00.Core.Monotonicity

-- Millennium Prize Problems
import Universe00.Problems.Riemann
import Universe00.Problems.NavierStokes
import Universe00.Problems.PvsNP
import Universe00.Problems.YangMills
import Universe00.Problems.Hodge
import Universe00.Problems.BSD
import Universe00.Problems.Poincare

-- Examples
import Universe00.Examples.RH_Ledger
import Universe00.Examples.NS_Ledger
import Universe00.Examples.BSD_Ledger

/-!
# Universe00: Classical Error-Based Framework

This is the main entry point for the Universe00 framework.

## Quick Start

```lean
-- Access the Riemann Hypothesis ledger
#check RiemannHypothesis.ledger

-- Display current error
#eval RiemannHypothesis.current_error

-- Check Poincaré conjecture (solved)
#check PoincareConjecture.ledger
```

## Core Principle

> In this system, the error does not measure the failure of the proof.
> It is the proof's own coordinate.

## Framework Summary

- **7 Core modules**: Parameter, Error, Vector, Aggregation, Status, Ledger, Monotonicity
- **7 Problems**: Riemann, Navier-Stokes, P vs NP, Yang-Mills, Hodge, BSD, Poincaré
- **3 Examples**: Complete ledger demonstrations

## Error Measurements (Current)

| Problem | Error | Status |
|---------|-------|--------|
| Poincaré | 0% | PROVED |
| Riemann | ~56% | OPEN |
| Hodge | ~59.5% | OPEN |
| BSD | ~59% | OPEN |
| Navier-Stokes | ~67.5% | OPEN |
| Yang-Mills | ~78.5% | OPEN |
| P vs NP | ~84.5% | OPEN |

## Key Theorems

- **Monotonicity**: Error can only decrease
- **Proof Equivalence**: status = PROVED ⟺ totalError = 0
- **Terminal State**: E = 0 is minimal

## Usage

See `README.md` for complete documentation and examples.

-/

def main : IO Unit := do
  IO.println "Universe00: Classical Error-Based Framework"
  IO.println "==========================================="
  IO.println ""
  IO.println "Millennium Prize Problems - Error Summary:"
  IO.println ""
  IO.println "  Poincaré Conjecture:     0.0%  (PROVED)"
  IO.println "  Riemann Hypothesis:     ~56.0% (OPEN)"
  IO.println "  Hodge Conjecture:       ~59.5% (OPEN)"
  IO.println "  BSD Conjecture:         ~59.0% (OPEN)"
  IO.println "  Navier-Stokes:          ~67.5% (OPEN)"
  IO.println "  Yang-Mills:             ~78.5% (OPEN)"
  IO.println "  P vs NP:                ~84.5% (OPEN)"
  IO.println ""
  IO.println "Core Principle:"
  IO.println "  'The error is not a failure—it is a coordinate.'"
  IO.println "  'Proof = navigation to E = 0.'"
  IO.println ""
  IO.println "Framework: Complete and operational."
  IO.println "See README.md for documentation."
