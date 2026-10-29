namespace MillenniumRiemann.Audit.RHG21Mold

/-!
# RH G2.1 negative-formulation mold

Kernel-pure port of the logical mold certified by G2.1:

  A -> A'
  A -> not A'
  -----------
  A -> False

This module falsifies only a formulation for which both premises are proved.
It does not prove or disprove the Riemann Hypothesis.
-/

structure NegativeFormulationMold (A A' : Prop) where
  h_need : A → A'
  h_break : A → ¬ A'

theorem formulation_falsified
    {A A' : Prop}
    (M : NegativeFormulationMold A A') :
    A → False := by
  intro hA
  exact M.h_break hA (M.h_need hA)

theorem formulation_not
    {A A' : Prop}
    (M : NegativeFormulationMold A A') :
    ¬ A :=
  formulation_falsified M

/-- Minimal positive-route obligations. These are explicit propositions;
    this structure does not assert that any of them hold. -/
structure RHPositiveBoundary where
  normalizedSpectrum : Prop
  spectralExclusion : Prop
  axiomFreeEndpoint : Prop
  compactnessUniformity : Prop
  limitInterchange : Prop

def RHRequiredCondition (B : RHPositiveBoundary) : Prop :=
  B.normalizedSpectrum ∧
  B.spectralExclusion ∧
  B.axiomFreeEndpoint ∧
  B.compactnessUniformity ∧
  B.limitInterchange

structure RHRawCandidate where
  zeroCountingInformation : Prop
  directRealCoordinateControl : Prop

def RHRawFormulation (A : RHRawCandidate) : Prop :=
  A.zeroCountingInformation ∧ A.directRealCoordinateControl

abbrev RHFormulationFalsificationWitness
    (A : RHRawCandidate)
    (B : RHPositiveBoundary) :=
  NegativeFormulationMold (RHRawFormulation A) (RHRequiredCondition B)

theorem rh_formulation_falsified
    (A : RHRawCandidate)
    (B : RHPositiveBoundary)
    (W : RHFormulationFalsificationWitness A B) :
    RHRawFormulation A → False :=
  formulation_falsified W

/-- Abstract scale firewall.  A concrete spectral instantiation must provide
    these two facts independently; the contradiction is then kernel-pure. -/
structure ScaleConflict where
  A : Prop
  RawUnitControl : Prop
  raw_requires_unit : A → RawUnitControl
  raw_breaks_unit : A → ¬ RawUnitControl

theorem scale_formulation_falsified
    (S : ScaleConflict) :
    S.A → False := by
  intro hRaw
  exact S.raw_breaks_unit hRaw (S.raw_requires_unit hRaw)

/-- A typed formulation lane is closed negatively exactly when a concrete
    witness supplies both need and break for the same A/A'. -/
structure RHClosedNegativeLane where
  A : Prop
  A' : Prop
  witness : NegativeFormulationMold A A'

theorem closed_negative_lane
    (L : RHClosedNegativeLane) :
    ¬ L.A :=
  formulation_not L.witness

#print axioms formulation_falsified
#print axioms formulation_not
#print axioms rh_formulation_falsified
#print axioms scale_formulation_falsified
#print axioms closed_negative_lane

end MillenniumRiemann.Audit.RHG21Mold
