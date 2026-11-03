import BSD.FinalProof.EndpointProofTarget

namespace BSD.FinalProof

theorem bsd003_has_Z
    (r : BSD003Requirements) (h : r.closed) :
    r.IdentificationOperator_Z := h.1

theorem bsd003_has_normalization
    (r : BSD003Requirements) (h : r.closed) :
    r.canonical_normalization_identification := h.2.1

theorem bsd003_has_endpoint
    (r : BSD003Requirements) (h : r.closed) :
    r.full_bsd_endpoint := h.2.2

theorem bsd003_all_requirements_iff
    (r : BSD003Requirements) :
    r.closed ↔
      r.IdentificationOperator_Z ∧
      r.canonical_normalization_identification ∧
      r.full_bsd_endpoint := by
  rfl

end BSD.FinalProof
