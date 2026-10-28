import HodgeStructuralCore

/-!
HodgeMaterialEndpointProbe.lean

Fail-closed material interface for the Hodge lane.

This file makes the material obligation explicit.  It proves the exact
equivalence between the probe statement and the structural Hodge endpoint,
and provides a canonical inhabitant of the *class type*.  It deliberately
does not manufacture a universal algebraicity proof.
-/

namespace HodgeMaterialEndpointProbe

open HodgeStructuralCore

universe u

variable {𝕜 V : Type u}
variable [Field 𝕜] [AddCommGroup V] [Module 𝕜 V]

/-- A probe class is an actual element of the declared Hodge sector. -/
abbrev ProbeHodgeClass (G : GapData (𝕜 := 𝕜) (V := V)) : Type u :=
  G.hodge

/-- The material endpoint for one Hodge class: it is algebraic. -/
def endpointInvariantHodge
    (G : GapData (𝕜 := 𝕜) (V := V))
    (α : ProbeHodgeClass G) : Prop :=
  (α : V) ∈ G.alg

/-- Universal material statement for a fixed structural Hodge datum. -/
def ProbeHodgeStatement
    (G : GapData (𝕜 := 𝕜) (V := V)) : Prop :=
  ∀ α : ProbeHodgeClass G, endpointInvariantHodge G α

/-- The probe-class type itself is inhabited: zero is always a Hodge class.
This is only a type-level inhabitant and carries no universal algebraicity claim. -/
instance probeHodgeClassInhabited
    (G : GapData (𝕜 := 𝕜) (V := V)) :
    Inhabited (ProbeHodgeClass G) :=
  ⟨⟨0, G.hodge.zero_mem⟩⟩

/-- Explicit canonical inhabitant of the probe-class type. -/
def canonicalHodgeClass
    (G : GapData (𝕜 := 𝕜) (V := V)) :
    ProbeHodgeClass G :=
  default

theorem canonicalHodgeClass_is_algebraic
    (G : GapData (𝕜 := 𝕜) (V := V)) :
    endpointInvariantHodge G (canonicalHodgeClass G) := by
  change (0 : V) ∈ G.alg
  exact G.alg.zero_mem

/-- A genuinely supplied structural endpoint produces every material probe. -/
theorem probe_of_structuralEndpoint
    (G : GapData (𝕜 := 𝕜) (V := V))
    (hMaterial : G.StructuralEndpoint) :
    ProbeHodgeStatement G := by
  intro α
  exact hMaterial α.property

/-- Conversely, closing every material probe is exactly the structural endpoint. -/
theorem structuralEndpoint_of_probe
    (G : GapData (𝕜 := 𝕜) (V := V))
    (hProbe : ProbeHodgeStatement G) :
    G.StructuralEndpoint := by
  intro x hx
  exact hProbe ⟨x, hx⟩

/-- Exact-gap theorem: there is no weaker hidden producer in this interface. -/
theorem probeHodgeStatement_iff_structuralEndpoint
    (G : GapData (𝕜 := 𝕜) (V := V)) :
    ProbeHodgeStatement G ↔ G.StructuralEndpoint := by
  constructor
  · exact structuralEndpoint_of_probe G
  · exact probe_of_structuralEndpoint G

/-- Pointwise material consequence once the universal endpoint is independently supplied. -/
theorem material_apriori_bound_Hodge_from_endpoint
    (G : GapData (𝕜 := 𝕜) (V := V))
    (hMaterial : G.StructuralEndpoint)
    (α : ProbeHodgeClass G) :
    endpointInvariantHodge G α :=
  probe_of_structuralEndpoint G hMaterial α

/-- The missing universal producer has precisely the same strength as the endpoint.
Any future declaration promoted as a material inhabitant must provide this proposition
without importing it as a premise. -/
theorem material_producer_exact_obligation
    (G : GapData (𝕜 := 𝕜) (V := V)) :
    (ProbeHodgeStatement G) ↔ (G.hodge ≤ G.alg) := by
  exact probeHodgeStatement_iff_structuralEndpoint G

end HodgeMaterialEndpointProbe
