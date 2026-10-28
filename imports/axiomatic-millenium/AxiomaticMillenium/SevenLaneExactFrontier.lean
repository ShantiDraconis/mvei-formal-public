import AxiomaticMillenium.SevenLaneClosureArchitecture

namespace AxiomaticMillenium

/-- Exact OPEN material layer.  A lane is not closed until one of these
positive/negative material requirements is genuinely inhabited. -/
structure ExactFrontierLane where
  lane : String
  positiveProducers : List String
  negativeProducer : String
  closureRequirement : String
  materialAtoms : Nat
  state : MaterialClosureStatus
  buildState : String
  deriving Repr, DecidableEq

def exactFrontierOf (L : LaneClosureArchitecture) : ExactFrontierLane :=
  { lane := L.lane
    positiveProducers := L.exactOpenProducer
    negativeProducer := L.exactNegativeProducer
    closureRequirement := L.closureRequirement
    materialAtoms := L.materialAtoms
    state := .openMath
    buildState := L.buildState }

def sevenLaneExactFrontiers : List ExactFrontierLane :=
  sevenLaneArchitectures.map exactFrontierOf

def refinedOpenMaterialCount : Nat :=
  sevenLaneExactFrontiers.foldl
    (fun n F => if F.state == .openMath then n + 1 else n) 0

def refinedMaterialAtomCount : Nat :=
  sevenLaneExactFrontiers.foldl (fun n F => n + F.materialAtoms) 0

theorem exact_frontier_has_seven_lanes :
    sevenLaneExactFrontiers.length = 7 := by
  decide

theorem exact_frontier_all_open :
    refinedOpenMaterialCount = 7 := by
  decide

/--
Refined current cut: PNP is represented by one material dichotomy
RangeFailureLaw versus a real PerfectFlip, while BSD remains a three-atom bound
package.  Hence 1+1+1+1+3+1+1 = 9 atoms.
-/
theorem refined_exact_material_atom_count :
    refinedMaterialAtomCount = 9 := by
  decide

theorem bsd_refined_frontier_has_three_atoms :
    (sevenLaneExactFrontiers.get ⟨4, by decide⟩).materialAtoms = 3 := by
  decide

theorem pnp_refined_frontier_has_one_material_dichotomy :
    (sevenLaneExactFrontiers.get ⟨1, by decide⟩).materialAtoms = 1 := by
  decide

#print axioms AxiomaticMillenium.exact_frontier_has_seven_lanes
#print axioms AxiomaticMillenium.exact_frontier_all_open
#print axioms AxiomaticMillenium.refined_exact_material_atom_count
#print axioms AxiomaticMillenium.bsd_refined_frontier_has_three_atoms
#print axioms AxiomaticMillenium.pnp_refined_frontier_has_one_material_dichotomy

end AxiomaticMillenium
