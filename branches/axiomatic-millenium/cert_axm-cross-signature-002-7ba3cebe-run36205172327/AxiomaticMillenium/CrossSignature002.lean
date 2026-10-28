import AxiomaticMillenium.AreaBoundaryMap

namespace AxiomaticMillenium

/-- Refines the broad F-pattern into semantically distinct negative-route kinds. -/
inductive FRouteKind where
  | formulation
  | transfer
  deriving Repr, DecidableEq, BEq

/-- Abstract negative theorem shape: A rejects A', and any claimed endpoint
would require A'.  This is the reusable logical mold behind a closed
formulation-level falsification. -/
structure NegativeFormulationTemplate
    (A Aprime Pclaimed : Prop) where
  rejects : A → ¬ Aprime
  claimedRequires : A → Pclaimed → Aprime

theorem negative_template_refutes_claim
    {A Aprime Pclaimed : Prop}
    (T : NegativeFormulationTemplate A Aprime Pclaimed)
    (hA : A) :
    ¬ Pclaimed := by
  intro hClaim
  exact T.rejects hA (T.claimedRequires hA hClaim)

/-- Source-verified negative evidence.  This structure records provenance and
scope; it does not re-prove the external theorem. -/
structure NegativeControl where
  id : String
  kind : FRouteKind
  sourceRepository : String
  sourceBranch : String
  sourcePath : String
  sourceTheorem : String
  sourceBlobSha : String
  sourceRun : Option Nat
  sourceVerified : Bool
  deriving Repr, DecidableEq

def g21LiteralFixedPointControl : NegativeControl :=
  { id := "PNP_G21_LITERAL_FIXED_POINT"
    kind := .formulation
    sourceRepository := "ShantiDraconis/m-core-p-vs-np"
    sourceBranch :=
      "cert/p02-g2-1-final-negative-4a95dd2f-run36204860440"
    sourcePath := "lean/MCore/Real/P02G21FinalNegative.lean"
    sourceTheorem :=
      "MCore.Real.P02G21FinalNegative.G21_literal_fixed_point_falsified"
    sourceBlobSha := "9f19b2c23aa45fd65969b7927da5622b7e456df3"
    sourceRun := some 36204860440
    sourceVerified := true }

def nsAmplitudeFixedDeltaControl : NegativeControl :=
  { id := "NS_AMPLITUDE_FIXED_DELTA"
    kind := .transfer
    sourceRepository := "ShantiDraconis/navier-stokes-critical-barrier-audit"
    sourceBranch := "open-math/ns-final-empty"
    sourcePath :=
      "open-math/navier-stokes/logic-refutation/AmplitudeInvariantFixedDeltaNoGo.lean"
    sourceTheorem :=
      "NSAmplitudeInvariantNoGo.no_fixed_delta_from_amplitude_invariant_certificate"
    sourceBlobSha := "20faecf29700f974255180e59f19a9bcbb3c454e"
    sourceRun := some 36199495752
    sourceVerified := true }

def exactFKindCompatible (source target : NegativeControl) : Bool :=
  source.kind == target.kind

/-- Fail-closed transfer candidate corresponding to:
D_struct < 0.2 AND exact hypothesis compatibility AND exact operator
instantiation.  distanceBelow20 is supplied by the structural calculator;
exact F-subtype compatibility is additionally mandatory. -/
def transferCandidateFromG21
    (target : NegativeControl)
    (distanceBelow20 hypothesisCompatible operatorInstantiated : Bool) : Bool :=
  g21LiteralFixedPointControl.sourceVerified &&
  target.sourceVerified &&
  distanceBelow20 &&
  exactFKindCompatible g21LiteralFixedPointControl target &&
  hypothesisCompatible &&
  operatorInstantiated

theorem g21_to_ns_blocked_by_F_subtype
    (hDistance hHyp hOp : Bool) :
    transferCandidateFromG21 nsAmplitudeFixedDeltaControl hDistance hHyp hOp = false := by
  cases hDistance <;> cases hHyp <;> cases hOp <;> rfl

theorem distance_gate_blocks_G21_transfer
    (target : NegativeControl)
    (hHyp hOp : Bool) :
    transferCandidateFromG21 target false hHyp hOp = false := by
  simp [transferCandidateFromG21]

theorem operator_gate_blocks_G21_transfer
    (target : NegativeControl)
    (hDistance hHyp : Bool) :
    transferCandidateFromG21 target hDistance hHyp false = false := by
  simp [transferCandidateFromG21]

/-- Broad F similarity is negative-control evidence only; it is not sufficient
for theorem reuse across formulation and transfer falsifications. -/
theorem broad_F_similarity_does_not_override_kind :
    exactFKindCompatible g21LiteralFixedPointControl nsAmplitudeFixedDeltaControl = false := by
  rfl

end AxiomaticMillenium
