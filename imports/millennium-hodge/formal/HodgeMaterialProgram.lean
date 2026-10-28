import formal.HodgeMaterialEndpointProbe

/-!
HodgeMaterialProgram.lean

Material, fail-closed contract for the Hodge lane.

The endpoint probe only asks whether a Hodge class belongs to the declared
algebraic sector.  This file strengthens that endpoint by requiring an actual
geometric witness: an admissible cycle whose cycle class is the Hodge class.

No universal producer is assumed here.
-/

namespace HodgeMaterialProgram

open HodgeStructuralCore
open HodgeMaterialEndpointProbe

universe u

variable {𝕜 V : Type u}
variable [Field 𝕜] [AddCommGroup V] [Module 𝕜 V]

/-- Concrete realization interface for algebraic classes.  The two directions
make the declared algebraic submodule extensionally equal to classes represented
by admissible cycles. -/
structure CycleRealization
    (G : GapData (𝕜 := 𝕜) (V := V)) where
  Cycle : Type u
  admissible : Cycle → Prop
  cycleClass : Cycle → V
  class_mem_alg :
    ∀ z : Cycle, admissible z → cycleClass z ∈ G.alg
  alg_has_cycle :
    ∀ v : V, v ∈ G.alg → ∃ z : Cycle, admissible z ∧ cycleClass z = v

namespace CycleRealization

variable {G : GapData (𝕜 := 𝕜) (V := V)}
variable (R : CycleRealization G)

/-- A material witness for a specific Hodge class is an actual admissible cycle
with exactly that cohomology class. -/
def MaterialWitness (α : ProbeHodgeClass G) : Prop :=
  ∃ z : R.Cycle, R.admissible z ∧ R.cycleClass z = (α : V)

/-- Universal material producer: every Hodge class receives a concrete cycle. -/
def UniversalCycleProducer : Prop :=
  ∀ α : ProbeHodgeClass G, R.MaterialWitness α

/-- Any concrete cycle witness certifies the pointwise endpoint. -/
theorem witness_closes_point
    {α : ProbeHodgeClass G}
    (h : R.MaterialWitness α) :
    endpointInvariantHodge G α := by
  rcases h with ⟨z, hz, hclass⟩
  change (α : V) ∈ G.alg
  rw [← hclass]
  exact R.class_mem_alg z hz

/-- A universal cycle producer closes the Hodge endpoint. -/
theorem universalCycleProducer_closes_probe
    (h : R.UniversalCycleProducer) :
    ProbeHodgeStatement G := by
  intro α
  exact R.witness_closes_point (h α)

/-- Conversely, once the endpoint is known, the realization completeness field
extracts a cycle for every Hodge class. -/
theorem probe_builds_universalCycleProducer
    (h : ProbeHodgeStatement G) :
    R.UniversalCycleProducer := by
  intro α
  have ha : (α : V) ∈ G.alg := h α
  rcases R.alg_has_cycle (α : V) ha with ⟨z, hz, hclass⟩
  exact ⟨z, hz, hclass⟩

/-- Exact material characterization: with an honest cycle realization, producing
cycles for all Hodge classes is equivalent to the Hodge endpoint. -/
theorem universalCycleProducer_iff_probe :
    R.UniversalCycleProducer ↔ ProbeHodgeStatement G := by
  constructor
  · exact R.universalCycleProducer_closes_probe
  · exact R.probe_builds_universalCycleProducer

/-- Therefore the concrete cycle-producing formulation is also exactly equivalent
to the structural endpoint. -/
theorem universalCycleProducer_iff_structuralEndpoint :
    R.UniversalCycleProducer ↔ G.StructuralEndpoint := by
  rw [R.universalCycleProducer_iff_probe]
  exact probeHodgeStatement_iff_structuralEndpoint G

end CycleRealization

/-- Two reverse material bridges.  These are the exact directions not contained
in GapData.  If both are independently proved, the endpoint follows. -/
structure TwoMaterialBridges
    (G : GapData (𝕜 := 𝕜) (V := V)) where
  hodge_to_motivated : G.hodge ≤ G.mot
  motivated_to_algebraic : G.mot ≤ G.alg

namespace TwoMaterialBridges

variable {G : GapData (𝕜 := 𝕜) (V := V)}

/-- The two material bridges close the structural endpoint without any other
assumption. -/
theorem closes_structuralEndpoint
    (B : TwoMaterialBridges G) :
    G.StructuralEndpoint := by
  intro x hx
  exact B.motivated_to_algebraic (B.hodge_to_motivated hx)

/-- The two material bridges therefore prove every pointwise material endpoint. -/
theorem closes_probe
    (B : TwoMaterialBridges G) :
    ProbeHodgeStatement G :=
  probe_of_structuralEndpoint G B.closes_structuralEndpoint

end TwoMaterialBridges

/-- A complete material package contains both the geometric cycle realization
and a producer that constructs a cycle for every Hodge class.  Possessing this
structure is sufficient for honest promotion. -/
structure CompleteMaterialPackage
    (G : GapData (𝕜 := 𝕜) (V := V)) where
  realization : CycleRealization G
  produce : realization.UniversalCycleProducer

namespace CompleteMaterialPackage

variable {G : GapData (𝕜 := 𝕜) (V := V)}

/-- This is the only promotion theorem in this module: promotion follows from
the explicit complete material package. -/
theorem promoted_by_material
    (P : CompleteMaterialPackage G) :
    ProbeHodgeStatement G :=
  P.realization.universalCycleProducer_closes_probe P.produce

theorem promoted_structuralEndpoint
    (P : CompleteMaterialPackage G) :
    G.StructuralEndpoint :=
  structuralEndpoint_of_probe G P.promoted_by_material

end CompleteMaterialPackage

/-- Known-case adapter.  Any independently proved case-specific endpoint can be
converted into a complete cycle producer once a CycleRealization is supplied. -/
def packageOfKnownCase
    (G : GapData (𝕜 := 𝕜) (V := V))
    (R : CycleRealization G)
    (hKnown : ProbeHodgeStatement G) :
    CompleteMaterialPackage G where
  realization := R
  produce := R.probe_builds_universalCycleProducer hKnown

/-- A family packages only the geometric instances that belong to the intended
Hodge problem.  This prevents quantifying over arbitrary synthetic GapData. -/
structure GeometricHodgeFamily where
  Index : Type u
  data : Index → GapData (𝕜 := 𝕜) (V := V)
  realization : ∀ i : Index, CycleRealization (data i)

/-- Material content for the whole declared geometric family. -/
def UniversalGeometricMaterial
    (F : GeometricHodgeFamily (𝕜 := 𝕜) (V := V)) : Prop :=
  ∀ i : F.Index, F.realization i |>.UniversalCycleProducer

/-- A family-level material producer gives the Hodge endpoint at every declared
geometric instance. -/
theorem universalGeometricMaterial_closes
    (F : GeometricHodgeFamily (𝕜 := 𝕜) (V := V))
    (h : UniversalGeometricMaterial F) :
    ∀ i : F.Index, ProbeHodgeStatement (F.data i) := by
  intro i
  exact (F.realization i).universalCycleProducer_closes_probe (h i)

/-- Equivalent family-level formulation in terms of structural endpoints. -/
theorem universalGeometricMaterial_iff_endpoints
    (F : GeometricHodgeFamily (𝕜 := 𝕜) (V := V)) :
    UniversalGeometricMaterial F ↔
      ∀ i : F.Index, (F.data i).StructuralEndpoint := by
  constructor
  · intro h i
    exact structuralEndpoint_of_probe (F.data i)
      ((F.realization i).universalCycleProducer_closes_probe (h i))
  · intro h i
    exact (F.realization i).probe_builds_universalCycleProducer
      (probe_of_structuralEndpoint (F.data i) (h i))

/-
The missing general theorem is intentionally NOT declared:

  the canonical Hodge material producer would have to construct the universal geometric family package

For the genuine family indexed by all smooth projective complex varieties and
all codimensions, constructing that term would be a proof of the general Hodge
conjecture itself.
-/

end HodgeMaterialProgram
