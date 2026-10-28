/-
Copyright (c) 2025 ShantiDraconis. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ShantiDraconis

# Main Entry Point

This is the main entry point that imports all modules and can be used
to verify the complete formalization.
-/

import Millennium.Riemann

-- Demonstrate that RH is proven in the framework
namespace Main

open Riemann.CollapseProof
open Riemann.Zeros

-- The main theorem: Riemann Hypothesis
#check RH_by_I_collapse

-- Corollaries
#check all_nontrivial_zeros_on_critical_line
#check all_nontrivial_zeros_real_part_half
#check no_nontrivial_zero_off_critical_line

-- Display the proof
#print RH_by_I_collapse

end Main

def main : IO Unit := do
  IO.println "Millennium Riemann I - I-Collapse Framework"
  IO.println "============================================"
  IO.println ""
  IO.println "This formalization proves the Riemann Hypothesis"
  IO.println "in the CollapseComplex extended number system"
  IO.println "using the I-Collapse contradiction method."
  IO.println ""
  IO.println "Main theorem: RH_by_I_collapse : RiemannHypothesis"
  IO.println ""
  IO.println "DISCLAIMER: This is a SYMBOLIC proof in an EXTENDED"
  IO.println "number system. It does NOT constitute a classical proof"
  IO.println "of the Riemann Hypothesis over standard complex numbers."
