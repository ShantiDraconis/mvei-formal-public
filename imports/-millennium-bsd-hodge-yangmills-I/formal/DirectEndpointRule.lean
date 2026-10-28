/-
ATK-DIRECT-ENDPOINT-v1
Universal fail-closed rule: SOURCE -> WITNESS -> VERIFIED WITNESS -> ENDPOINT.

This file proves only the abstract rule. It does not close any problem-specific
OPEN_MATH by itself.
-/

namespace DirectEndpointRule

universe u

structure Rule (Source : Prop) (Witness : Type u) (Endpoint : Prop) where
  Valid : Witness → Prop

  /-- The witness must be produced from the source. -/
  produce : Source → ∃ w : Witness, Valid w

  /--
  Endpoint closure consumes only a concrete witness plus its independent
  validity proof. Endpoint is not an input to witness construction.
  -/
  close : ∀ w : Witness, Valid w → Endpoint

theorem direct_endpoint
    {Source : Prop} {Witness : Type u} {Endpoint : Prop}
    (r : Rule Source Witness Endpoint)
    (hSource : Source) :
    Endpoint := by
  obtain ⟨w, hw⟩ := r.produce hSource
  exact r.close w hw

/-- A progress measure used to reject parameter inflation. -/
structure StrictProgress (State : Type u) where
  rank : State → Nat
  step : State → State
  decreases : ∀ s, rank (step s) < rank s

/--
No infinite sequence can justify closure by endlessly introducing new states
whose natural-number rank strictly decreases.
-/
theorem no_infinite_descent
    {State : Type u}
    (p : StrictProgress State) :
    WellFounded (fun a b => p.rank a < p.rank b) :=
  InvImage.wf p.rank Nat.lt_wfRel

/-- Explicit dependency discipline for source/witness/endpoint nodes. -/
inductive Stage
  | source
  | witness
  | verified
  | endpoint
deriving DecidableEq, Repr

def stageRank : Stage → Nat
  | .source => 3
  | .witness => 2
  | .verified => 1
  | .endpoint => 0

def forwardDependency (a b : Stage) : Prop :=
  stageRank a < stageRank b

theorem forwardDependency_wellFounded : WellFounded forwardDependency :=
  InvImage.wf stageRank Nat.lt_wfRel

end DirectEndpointRule
