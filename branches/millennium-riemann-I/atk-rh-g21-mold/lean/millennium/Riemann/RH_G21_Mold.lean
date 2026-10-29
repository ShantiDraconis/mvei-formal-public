import Mathlib

namespace MillenniumRiemann.RHG21Mold

/--
Abstract negative-template used to falsify a candidate formulation.

This structure does not assert that any particular RH formulation is false.
It packages the exact logical obligations required for such a conclusion.
-/
structure FormulationFalsified (A A' : Prop) where
  h_need : A → A'
  h_break : A → ¬ A'

theorem closed
    {A A' : Prop}
    (F : FormulationFalsified A A') :
    A → False := by
  intro hA
  exact F.h_break hA (F.h_need hA)

theorem alleged_endpoint_contradiction
    {A A' P_alegado : Prop}
    (F : FormulationFalsified A A') :
    A ∧ P_alegado → False := by
  intro h
  exact closed F h.1

/--
RH-specific candidate vocabulary for the G2.1 mold.

The four fields in RequiredCondition are intentionally propositions supplied by
the actual RH development. They are not manufactured here.
-/
structure RHRequiredCondition where
  axiom_free_classical_endpoint_proof : Prop
  spectral_normalization_hat_gamma : Prop
  spectral_exclusion_axiom_free : Prop
  compactness_uniformity_limit_interchange : Prop

def RequiredConditionHolds (R : RHRequiredCondition) : Prop :=
  R.axiom_free_classical_endpoint_proof ∧
  R.spectral_normalization_hat_gamma ∧
  R.spectral_exclusion_axiom_free ∧
  R.compactness_uniformity_limit_interchange

structure CandidateRHFormulation where
  candidate : Prop
  requirements : RHRequiredCondition
  h_need : candidate → RequiredConditionHolds requirements
  h_break : candidate → ¬ RequiredConditionHolds requirements

def toFormulationFalsified
    (C : CandidateRHFormulation) :
    FormulationFalsified C.candidate (RequiredConditionHolds C.requirements) where
  h_need := C.h_need
  h_break := C.h_break

theorem RH_formulation_falsified
    (C : CandidateRHFormulation) :
    C.candidate → False := by
  exact closed (toFormulationFalsified C)

theorem RH_formulation_with_alleged_endpoint_falsified
    (C : CandidateRHFormulation)
    (P_alegado : Prop) :
    C.candidate ∧ P_alegado → False := by
  exact alleged_endpoint_contradiction (toFormulationFalsified C)

#print axioms closed
#print axioms alleged_endpoint_contradiction
#print axioms RH_formulation_falsified
#print axioms RH_formulation_with_alleged_endpoint_falsified

end MillenniumRiemann.RHG21Mold
