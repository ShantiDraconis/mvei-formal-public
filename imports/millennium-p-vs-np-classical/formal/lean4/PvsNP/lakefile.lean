/- 
  PvsNP - Lean 4 Formalization of P vs NP Theorem Program
  
  This is the main lakefile for building the P vs NP formalization.
  The project provides:
  - Basic definitions (languages, complexity classes)
  - Classical lemmas (P ⊆ P/poly, implications)
  - Master theorem structure with separation/equality/approximate branches
-/

import Lake
open Lake DSL

package PvsNP where
  leanOptions := #[
    ⟨`pp.unicode.fun, true⟩,
    ⟨`autoImplicit, false⟩
  ]

@[default_target]
lean_lib PvsNP where
  srcDir := "."
  roots := #[`Basics, `TuringMachines, `ComplexityClasses, `CircuitComplexity, 
             `SAT_NPCompleteness, `AverageParameterized, `StoneLemma, `MasterTheorem, `Barriers]
