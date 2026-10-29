namespace PoincareATK

/-!
F7 + F8 compression of the Poincare theorem.

This file separates:
* the mathematical theorem known from Perelman,
* the route architecture C0 -> O -> C2,
* the Lean-kernel inhabitant required for a fully formal certificate.

No axiom, sorry, admit, oracle, or fake theorem inhabitant is introduced.
-/

/-- ATK terminal taxonomy relevant to Poincare. -/
inductive GapShape where
  | F7_limit
  | F8_fixedPointClassification
  deriving DecidableEq, Repr

/-- Three compressed stages C0 -> O -> C2. -/
inductive Stage where
  | C0_topologicalInput
  | O_ricciSurgeryCorridor
  | C2_sphericalClassification
  deriving DecidableEq, Repr

/-- Abstract interface for the geometric objects used by the route.
The actual differential-topological formalization can later instantiate this
without changing the certificate architecture. -/
structure PoincareGeometry where
  Closed3Manifold : Type
  Sphere3 : Closed3Manifold
  SimplyConnected : Closed3Manifold → Prop
  Diffeomorphic : Closed3Manifold → Closed3Manifold → Prop
  RicciFlowWithSurgery : Closed3Manifold → Type
  FiniteTimeExtinction : {M : Closed3Manifold} → RicciFlowWithSurgery M → Prop
  SurgeryControlled : {M : Closed3Manifold} → RicciFlowWithSurgery M → Prop
  Noncollapsed : {M : Closed3Manifold} → RicciFlowWithSurgery M → Prop
  PerelmanMonotone : {M : Closed3Manifold} → RicciFlowWithSurgery M → Prop

namespace PoincareGeometry

/-- C0: closed topological input. -/
structure C0Certificate (G : PoincareGeometry) where
  M : G.Closed3Manifold
  simplyConnected : G.SimplyConnected M

/-- O: the Ricci-flow-with-surgery corridor. -/
structure RicciSurgeryCertificate
    (G : PoincareGeometry)
    (c0 : C0Certificate G) where
  flow : G.RicciFlowWithSurgery c0.M
  surgeryControlled : G.SurgeryControlled flow
  noncollapsed : G.Noncollapsed flow
  entropyMonotone : G.PerelmanMonotone flow

/-- F7 terminal control: the corridor reaches finite extinction. -/
structure ExtinctionCertificate
    (G : PoincareGeometry)
    (c0 : C0Certificate G)
    (ricci : RicciSurgeryCertificate G c0) where
  finiteExtinction : G.FiniteTimeExtinction ricci.flow

/-- C2 / F8 endpoint: topological classification by S^3. -/
def SphericalClassification
    (G : PoincareGeometry)
    (c0 : C0Certificate G) : Prop :=
  G.Diffeomorphic c0.M G.Sphere3

/-- The exact Poincare statement in the abstract geometry interface. -/
def PoincareStatement (G : PoincareGeometry) : Prop :=
  ∀ M : G.Closed3Manifold,
    G.SimplyConnected M →
    G.Diffeomorphic M G.Sphere3

/-- F7 -> F8 transport: controlled Ricci-surgery extinction implies spherical
classification. This is where the topological extraction from the surgery
decomposition belongs. -/
structure ClassificationTransport (G : PoincareGeometry) where
  classify :
    ∀ (c0 : C0Certificate G)
      (ricci : RicciSurgeryCertificate G c0),
      ExtinctionCertificate G c0 ricci →
      SphericalClassification G c0

/-- Perelman producer: for every simply connected closed 3-manifold, produce
the controlled Ricci-surgery corridor and its finite-time extinction. -/
structure PerelmanProducer (G : PoincareGeometry) where
  produce :
    ∀ c0 : C0Certificate G,
      ∃ ricci : RicciSurgeryCertificate G c0,
        ExtinctionCertificate G c0 ricci

/-- Complete F7+F8 certificate. -/
structure PoincareF7F8Certificate (G : PoincareGeometry) where
  producer : PerelmanProducer G
  transport : ClassificationTransport G

/-- Kernel closure theorem for the architecture.
Once a genuine F7+F8 certificate inhabits the interface, the Poincare
classification follows with no remaining logical gap. -/
theorem poincare_classification
    (G : PoincareGeometry)
    (C : PoincareF7F8Certificate G) :
    PoincareStatement G := by
  intro M hSC
  let c0 : C0Certificate G := ⟨M, hSC⟩
  rcases C.producer.produce c0 with ⟨ricci, hExt⟩
  exact C.transport.classify c0 ricci hExt

/-- The Ricci-flow formulation kept separate from the classification endpoint:
the mathematically relevant statement here is finite extinction of a
controlled flow, not literal equality of a time-slice with a fixed round
sphere. -/
def PoincareRicciExtinctionStatement (G : PoincareGeometry) : Prop :=
  ∀ c0 : C0Certificate G,
    ∃ ricci : RicciSurgeryCertificate G c0,
      ExtinctionCertificate G c0 ricci

theorem poincare_ricci_extinction
    (G : PoincareGeometry)
    (P : PerelmanProducer G) :
    PoincareRicciExtinctionStatement G :=
  P.produce

/-- Exact dual-language endpoint used by ATK. -/
abbrev OpenMathProducerPoincare (G : PoincareGeometry) : Type :=
  PoincareF7F8Certificate G

/-- The route is logically closed once the producer exists. -/
theorem openMathProducerPoincare_closes
    (G : PoincareGeometry)
    (P : OpenMathProducerPoincare G) :
    PoincareStatement G :=
  poincare_classification G P

/-- External mathematical status and local kernel status are deliberately
separate.  The first records that the theorem is known in the literature;
the second must only become true when this repository contains a complete
kernel-checkable inhabitant. -/
inductive MathematicalStatus where
  | proven
  | open
  deriving DecidableEq, Repr

inductive KernelStatus where
  | interfaceOnly
  | kernelProven
  deriving DecidableEq, Repr

def mathematicalStatus : MathematicalStatus :=
  .proven

def kernelStatus : KernelStatus :=
  .interfaceOnly

def materialProducerGaps : Nat :=
  0

def coreFormalGaps : Nat :=
  1

def poincareClaims : Nat :=
  1

#print axioms poincare_classification
#print axioms poincare_ricci_extinction
#print axioms openMathProducerPoincare_closes

end PoincareGeometry
end PoincareATK
