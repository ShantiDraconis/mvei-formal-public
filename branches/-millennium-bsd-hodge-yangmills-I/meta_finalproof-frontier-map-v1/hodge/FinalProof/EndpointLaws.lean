import Hodge.FinalProof.EndpointProofTarget

namespace Hodge.FinalProof

theorem hodge003_has_R
    (r : Hodge003Requirements) (h : r.closed) :
    r.RealizationOperator_R := h.1

theorem hodge003_has_U
    (r : Hodge003Requirements) (h : r.closed) :
    r.ProducerWitness_U := h.2.1

theorem hodge003_has_surjectivity
    (r : Hodge003Requirements) (h : r.closed) :
    r.general_hodge_class_to_algebraic_cycle_surjectivity := h.2.2

theorem hodge003_all_requirements_iff
    (r : Hodge003Requirements) :
    r.closed ↔
      r.RealizationOperator_R ∧
      r.ProducerWitness_U ∧
      r.general_hodge_class_to_algebraic_cycle_surjectivity := by
  rfl

end Hodge.FinalProof
