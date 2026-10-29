namespace BSDMaterial

/-- A fail-closed carrier for the two independent BSD terminal equalities.
The scalar type is left abstract here: this file records the logical/material
boundary and does not pretend to construct periods, regulators, Tamagawa
factors, or the Tate-Shafarevich group. -/
structure BSDDatum (Scalar : Type) where
  algebraicRank : Nat
  analyticOrder : Nat
  leadingCoefficient : Scalar
  arithmeticLeadingTerm : Scalar
  shaFinite : Prop

/-- Material rank delta: analytic order equals Mordell-Weil rank. -/
structure RankDelta {Scalar : Type} (D : BSDDatum Scalar) : Prop where
  rank_eq : D.analyticOrder = D.algebraicRank

/-- Material refined delta: finiteness of Sha plus the leading-term identity. -/
structure RefinedDelta {Scalar : Type} (D : BSDDatum Scalar) : Prop where
  sha_finite : D.shaFinite
  leading_eq : D.leadingCoefficient = D.arithmeticLeadingTerm

/-- Exact two-part BSD endpoint carried by one datum. -/
structure BSDWitness {Scalar : Type} (D : BSDDatum Scalar) : Prop where
  rank : RankDelta D
  refined : RefinedDelta D

def BSDEndpoint {Scalar : Type} (D : BSDDatum Scalar) : Prop :=
  Nonempty (BSDWitness D)

theorem endpoint_iff_deltas {Scalar : Type} (D : BSDDatum Scalar) :
    BSDEndpoint D ↔ Nonempty (RankDelta D) ∧ Nonempty (RefinedDelta D) := by
  constructor
  · rintro ⟨w⟩
    exact ⟨⟨w.rank⟩, ⟨w.refined⟩⟩
  · rintro ⟨⟨hr⟩, ⟨hf⟩⟩
    exact ⟨⟨hr, hf⟩⟩

theorem assemble {Scalar : Type} {D : BSDDatum Scalar}
    (hr : RankDelta D) (hf : RefinedDelta D) : BSDEndpoint D :=
  ⟨⟨hr, hf⟩⟩

/-- The rank equality alone cannot manufacture the refined identity: the
second payload remains a separate material obligation. -/
theorem rank_projection {Scalar : Type} {D : BSDDatum Scalar}
    (h : BSDEndpoint D) : Nonempty (RankDelta D) := by
  rcases h with ⟨w⟩
  exact ⟨w.rank⟩

/-- Likewise the full endpoint exposes the refined payload explicitly. -/
theorem refined_projection {Scalar : Type} {D : BSDDatum Scalar}
    (h : BSDEndpoint D) : Nonempty (RefinedDelta D) := by
  rcases h with ⟨w⟩
  exact ⟨w.refined⟩

#print axioms BSDMaterial.endpoint_iff_deltas
#print axioms BSDMaterial.assemble

end BSDMaterial
