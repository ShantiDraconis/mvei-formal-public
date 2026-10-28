import AxiomaticMillenium.FinalEGC
import AxiomaticMillenium.TaxonomyBoundary

namespace AxiomaticMillenium

/-- One terminal mathematical lane: a material inhabitant type together with
the exact endpoint proposition and the certified map from inhabitant to
endpoint.  No inhabitant is postulated. -/
structure MaterialLane where
  Habitat : Type
  Endpoint : Prop
  close : Habitat → Endpoint

/-- A finite or infinite indexed family of terminal lanes. -/
structure MaterialProgram (ι : Type) where
  lane : ι → MaterialLane

namespace MaterialProgram

variable {ι : Type} (P : MaterialProgram ι)

/-- All terminal inhabitants required by the program. -/
def AllHabitants : Prop :=
  ∀ i : ι, Nonempty (P.lane i).Habitat

/-- Conjunction/root proposition represented extensionally over all lanes. -/
def RootStatement : Prop :=
  ∀ i : ι, (P.lane i).Endpoint

/-- Universal material-closure theorem.
It performs only certified transport: every endpoint must be obtained from an
actual inhabitant of that lane. -/
theorem universal_material_closure
    (h : P.AllHabitants) :
    P.RootStatement := by
  intro i
  rcases h i with ⟨w⟩
  exact (P.lane i).close w

/-- A single missing inhabitant cannot be silently replaced by metadata:
closure requires an explicit inhabitant at every index. -/
theorem lane_endpoint_from_habitant
    (i : ι)
    (h : Nonempty (P.lane i).Habitat) :
    (P.lane i).Endpoint := by
  rcases h with ⟨w⟩
  exact (P.lane i).close w

end MaterialProgram

/-- Root contract specialized to a material program.  The atom model is left
explicit: the contract does not manufacture source atoms or a freeze witness. -/
structure MaterialRootBinding (ι : Type) where
  program : MaterialProgram ι
  contract : RootContract
  root_exact :
    contract.root.statement = program.RootStatement

/-- Exact final-certificate constructor.  It is deliberately strict:
* all material inhabitants must be supplied;
* the root statement must be exactly the material-program root;
* the root freeze witness must already exist.
No OPEN_MATH lane can be bypassed by naming metadata. -/
def final_external_of_material_program
    {ι : Type}
    (B : MaterialRootBinding ι)
    (habitants : B.program.AllHabitants)
    (freeze : RootFreezeWitness B.contract.root)
    (directDeps : List Name)
    (metadataFingerprint : String) :
    FinalExternalGlobalCertificate B.contract := by
  refine
    { freeze := freeze
      term := ?_
      directDeps := directDeps
      metadataFingerprint := metadataFingerprint }
  rw [B.root_exact]
  exact B.program.universal_material_closure habitants

/-- Fail-closed converse at the transport layer: a final certificate yields the
root theorem, but does not retroactively construct per-lane inhabitants.  This
keeps endpoint proof and producer existence logically distinct. -/
theorem final_external_has_root
    {C : RootContract}
    (cert : FinalExternalGlobalCertificate C) :
    C.root.statement :=
  cert.term

#print axioms AxiomaticMillenium.MaterialProgram.universal_material_closure
#print axioms AxiomaticMillenium.MaterialProgram.lane_endpoint_from_habitant
#print axioms AxiomaticMillenium.final_external_of_material_program
/-- Canonical index of the seven still-open Millennium lanes used by the
cross-problem material program. -/
inductive SevenLaneId where
  | riemann
  | pvsnp
  | yangMills
  | hodge
  | bsd
  | beal
  | navierStokes
  deriving DecidableEq, Repr

/-- Explicit seven-lane bundle. Each field is a typed material lane. -/
structure SevenLaneProgram where
  riemann : MaterialLane
  pvsnp : MaterialLane
  yangMills : MaterialLane
  hodge : MaterialLane
  bsd : MaterialLane
  beal : MaterialLane
  navierStokes : MaterialLane

def SevenLaneProgram.toProgram
    (S : SevenLaneProgram) : MaterialProgram SevenLaneId where
  lane
    | .riemann => S.riemann
    | .pvsnp => S.pvsnp
    | .yangMills => S.yangMills
    | .hodge => S.hodge
    | .bsd => S.bsd
    | .beal => S.beal
    | .navierStokes => S.navierStokes

/-- Seven-lane universal theorem: no lane can be omitted from the quantified
root; every endpoint is produced only from the corresponding inhabitant. -/
theorem seven_lane_universal_closure
    (S : SevenLaneProgram)
    (h : S.toProgram.AllHabitants) :
    S.toProgram.RootStatement :=
  S.toProgram.universal_material_closure h

#print axioms AxiomaticMillenium.final_external_has_root
#print axioms AxiomaticMillenium.seven_lane_universal_closure

end AxiomaticMillenium
