/-
ANTI_CIRCULAR_OPEN_MATH_CERTIFICATE.lean

Purpose:
  A fail-closed certificate schema for a non-circular OPEN_MATH closure.

Design constraints:
  * no axiom
  * no sorry
  * no theorem assumes the final endpoint in order to derive a bridge
  * seven independent bridge claims
  * one aggregate signature
  * one universal endpoint law
  * an explicit well-founded dependency witness

This file DOES NOT assert that the seven mathematical bridges are already proved.
It makes the exact closure condition explicit: OPEN_MATH closes iff an inhabitant
of FinalClosureCertificate is constructed from real proofs.
-/

universe u

namespace AntiCircularOpenMath

inductive BridgeId where
  | pnp
  | riemann
  | yangMills
  | navierStokes
  | bsd
  | hodge
  | beal
deriving DecidableEq, Repr

inductive Node where
  | bridge : BridgeId → Node
  | aggregate : Node
  | endpointLaw : Node
  | endpoint : Node
deriving DecidableEq, Repr

structure DependencyLedger where
  depends : Node → Node → Prop
  wellFounded : WellFounded depends
  bridge_to_aggregate :
    ∀ i : BridgeId, depends (.bridge i) .aggregate
  aggregate_to_law :
    depends .aggregate .endpointLaw
  law_to_endpoint :
    depends .endpointLaw .endpoint

structure MathematicalInterface where
  bridgeClaim : BridgeId → Prop
  Signature : Prop
  Endpoint : Prop

structure FinalClosureCertificate (M : MathematicalInterface) where
  ledger : DependencyLedger
  bridgeProof : ∀ i : BridgeId, M.bridgeClaim i
  aggregate :
    (∀ i : BridgeId, M.bridgeClaim i) → M.Signature
  universalEndpointLaw :
    M.Signature → M.Endpoint

theorem close_open_math
    {M : MathematicalInterface}
    (c : FinalClosureCertificate M) :
    M.Endpoint :=
  c.universalEndpointLaw (c.aggregate c.bridgeProof)

structure RejectedSelfClosure (P : Prop) where
  proposed : P → P
  rejected : ¬ P

inductive ClosureState
  | openMath
  | certified

def stateOf {M : MathematicalInterface}
    (_ : Option (FinalClosureCertificate M)) : ClosureState
  | none   => .openMath
  | some _ => .certified

theorem certified_iff_certificate_exists
    {M : MathematicalInterface}
    (c : Option (FinalClosureCertificate M)) :
    stateOf c = .certified ↔ ∃ cert, c = some cert := by
  cases c with
  | none =>
      constructor
      · intro h
        cases h
      · intro h
        rcases h with ⟨cert, h⟩
        cases h
  | some cert =>
      constructor
      · intro _
        exact ⟨cert, rfl⟩
      · intro _
        rfl

end AntiCircularOpenMath
