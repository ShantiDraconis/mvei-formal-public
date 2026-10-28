/-
  PvsNP - Lean 4 Formalization of P vs NP Symbolic Separation Program
  
  This is the lakefile for building the formalization.
  
  Build with: lake build
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
  roots := #[
    `Basics, 
    `TuringMachines, 
    `ComplexityClasses, 
    `Reductions,
    `CircuitComplexity, 
    `SAT_NPCompleteness, 
    `StoneLemma,
    `HierarchyTheorems,
    `Barriers,
    `PneqNP_from_Stone,
    `PeqNP_from_SAT,
    `PneqNP_from_NP_not_in_Ppoly,
    `MasterTheorem
  ]
