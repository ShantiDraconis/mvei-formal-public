import Mathlib

namespace Riemann.refutedRoutes

inductive ZeroDirection where
  | K0 | RHO | ETA
  deriving DecidableEq, Repr

structure MCoreSystem where
  baseVal : ℝ
  amplitude : ℝ → ℝ
  scale : ℝ → ℝ
  zeroLimit : ZeroDirection → ℝ
  hasEdge : String → String → Prop
  phiObserved : ℝ → Prop

def A1_prop (sys : MCoreSystem) : Prop :=
  0 < sys.baseVal ∧
  ∀ δ : ℝ, 0 < δ → ∃ A : ℝ, 0 < A ∧ sys.amplitude A > 1 - δ

def A2_cycleDetected (sys : MCoreSystem) : Prop :=
  sys.hasEdge "G1" "G4" ∧ sys.hasEdge "G4" "G1"

def A3_pathDependent (sys : MCoreSystem) : Prop :=
  ∃ d₁ d₂ : ZeroDirection, d₁ ≠ d₂ ∧ sys.zeroLimit d₁ ≠ sys.zeroLimit d₂

def A4_scaleInvariant (sys : MCoreSystem) : Prop :=
  ∀ s : ℝ, 0 < s → sys.scale s = sys.baseVal

def A14Signature (sys : MCoreSystem) : Prop :=
  A1_prop sys ∧ A2_cycleDetected sys ∧ A3_pathDependent sys ∧ A4_scaleInvariant sys

structure NBObservation where
  coveringDecay : Prop
  testDefectDecay : Prop

def CompatibleObservation (sys : MCoreSystem) (_obs : NBObservation) : Prop :=
  A14Signature sys

def witnessSystem : MCoreSystem where
  baseVal := 1
  amplitude := fun _ => 1
  scale := fun _ => 1
  zeroLimit := fun d =>
    match d with
    | .K0 => 0
    | .RHO => 1
    | .ETA => 2
  hasEdge := fun a b => (a = "G1" ∧ b = "G4") ∨ (a = "G4" ∧ b = "G1")
  phiObserved := fun _ => False

theorem witness_A1 : A1_prop witnessSystem := by
  constructor
  · norm_num [witnessSystem]
  · intro delta hdelta
    refine ⟨1, by norm_num, ?_⟩
    simp [witnessSystem]
    linarith

theorem witness_A2 : A2_cycleDetected witnessSystem := by
  constructor <;> simp [witnessSystem]

theorem witness_A3 : A3_pathDependent witnessSystem := by
  refine ⟨ZeroDirection.K0, ZeroDirection.RHO, by decide, ?_⟩
  norm_num [witnessSystem]

theorem witness_A4 : A4_scaleInvariant witnessSystem := by
  intro s _hs
  rfl

theorem witness_A14 : A14Signature witnessSystem := by
  exact ⟨witness_A1, witness_A2, witness_A3, witness_A4⟩

def goodObservation : NBObservation :=
  { coveringDecay := True, testDefectDecay := True }

def badObservation : NBObservation :=
  { coveringDecay := False, testDefectDecay := False }

theorem good_is_compatible :
    CompatibleObservation witnessSystem goodObservation := by
  exact witness_A14

theorem bad_is_compatible :
    CompatibleObservation witnessSystem badObservation := by
  exact witness_A14

theorem good_covering : goodObservation.coveringDecay := by
  trivial

theorem good_testDefect : goodObservation.testDefectDecay := by
  trivial

theorem bad_not_covering : ¬ badObservation.coveringDecay := by
  simp [badObservation]

theorem bad_not_testDefect : ¬ badObservation.testDefectDecay := by
  simp [badObservation]

theorem compatible_counterexample_blocks_universal
    (P : NBObservation → Prop)
    (obs : NBObservation)
    (hcompat : CompatibleObservation witnessSystem obs)
    (hnot : ¬ P obs) :
    ¬ (∀ x : NBObservation, CompatibleObservation witnessSystem x → P x) := by
  intro hall
  exact hnot (hall obs hcompat)

theorem A14_alone_not_sufficient_for_covering :
    ¬ (∀ obs : NBObservation,
        CompatibleObservation witnessSystem obs → obs.coveringDecay) := by
  exact compatible_counterexample_blocks_universal
    (fun obs => obs.coveringDecay) badObservation bad_is_compatible bad_not_covering

theorem A14_alone_not_sufficient_for_testDefect :
    ¬ (∀ obs : NBObservation,
        CompatibleObservation witnessSystem obs → obs.testDefectDecay) := by
  exact compatible_counterexample_blocks_universal
    (fun obs => obs.testDefectDecay) badObservation bad_is_compatible bad_not_testDefect

theorem A14_alone_not_sufficient_for_joint_decay :
    ¬ (∀ obs : NBObservation,
        CompatibleObservation witnessSystem obs →
          obs.coveringDecay ∧ obs.testDefectDecay) := by
  intro hall
  have h := hall badObservation bad_is_compatible
  exact bad_not_covering h.1

#print axioms A14_alone_not_sufficient_for_covering
#print axioms A14_alone_not_sufficient_for_testDefect
#print axioms A14_alone_not_sufficient_for_joint_decay

def classification : String := "CLOSED_BY_COUNTERMODEL"

end Riemann.refutedRoutes
