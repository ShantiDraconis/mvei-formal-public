import FormalSuite.I.Universal.Semantics

namespace FormalSuite.I.Universal

structure FundamentalILaws : Prop where
  tractionRetraction : ∀ x : IState, retraction (traction x) = x
  retractionTraction : ∀ x : IState, traction (retraction x) = x
  stabilizationIdempotent : ∀ x : IState, stabilize (stabilize x) = stabilize x
  tractionProjection : ∀ x : IState, projection (traction x) = projection x
  retractionProjection : ∀ x : IState, projection (retraction x) = projection x
  twistProjection : ∀ x : IState, projection (twist x) = projection x
  informationNonCollapse : ∃ x y : IState, x ≠ y ∧ projection x = projection y
  realEmbeddingInjective : Function.Injective embedReal
  realAddConservative : ∀ a b : ℝ, iAdd (embedReal a) (embedReal b) = embedReal (a + b)
  realMulConservative : ∀ a b : ℝ, iMul (embedReal a) (embedReal b) = embedReal (a * b)

theorem concreteFundamentalILaws : FundamentalILaws := by
  refine ⟨retraction_traction, traction_retraction, stabilize_idempotent,
    traction_preserves_projection, retraction_preserves_projection,
    twist_preserves_projection, informationNonCollapse, embedReal_injective,
    embedReal_add, embedReal_mul⟩

#print axioms concreteFundamentalILaws

end FormalSuite.I.Universal
