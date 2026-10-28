import Unified.Kernel
import Unified.Indices
import Unified.Coupling.Definition
import Unified.Coupling.PosDefCert
import Unified.Problems.RH
import Unified.Problems.NS
import Unified.Problems.PNP
import Unified.Problems.YM
import Unified.Problems.Hodge
import Unified.Problems.BSD

namespace Unified

/-
  Main unification module.
  
  This brings together all the pieces:
  - The kernel (parameter space, energy, stability)
  - Named indices for interpretability
  - Coupling matrix definition and positive definiteness
  - Individual problem modules with refined predicates
  - The unification theorem showing how stability implies all problems
-/

/-- 
  Refined version of AllSolved using the refined predicates.
  This provides more structure than the basic version in Kernel.lean.
-/
structure AllSolvedRefined (θ : Θ) : Prop where
  rh : RH_holds_refined θ
  ns : NS_regular_refined θ
  pnp : P_not_NP_refined θ
  ym : YM_gap_refined θ
  hodge : Hodge_refined θ
  bsd : BSD_refined θ

/-- 
  Refined unification theorem: stability implies all refined predicates.
  This uses the individual bridge theorems from each problem module.
-/
theorem unification_refined (M : StableModel) : AllSolvedRefined θ₀ := by
  constructor
  · exact stability_implies_RH M
  · exact stability_implies_NS M
  · exact stability_implies_PNP M
  · exact stability_implies_YM M
  · exact stability_implies_Hodge M
  · exact stability_implies_BSD M

/-- 
  The refined unification implies the basic unification.
  This connects back to the original theorem in Kernel.lean.
-/
theorem refined_implies_basic (M : StableModel) : AllSolved θ₀ := by
  have h := unification_refined M
  constructor
  · exact refined_RH_implies_basic θ₀ h.rh
  · exact refined_NS_implies_basic θ₀ h.ns
  · exact refined_PNP_implies_basic θ₀ h.pnp
  · exact refined_YM_implies_basic θ₀ h.ym
  · exact refined_Hodge_implies_basic θ₀ h.hodge
  · exact refined_BSD_implies_basic θ₀ h.bsd

/-- 
  Main result: both formulations are equivalent given a stable model.
-/
theorem unification_equivalence (M : StableModel) : 
    AllSolved θ₀ ↔ AllSolvedRefined θ₀ := by
  constructor
  · intro _
    exact unification_refined M
  · intro h
    constructor
    · exact refined_RH_implies_basic θ₀ h.rh
    · exact refined_NS_implies_basic θ₀ h.ns
    · exact refined_PNP_implies_basic θ₀ h.pnp
    · exact refined_YM_implies_basic θ₀ h.ym
    · exact refined_Hodge_implies_basic θ₀ h.hodge
    · exact refined_BSD_implies_basic θ₀ h.bsd

end Unified
