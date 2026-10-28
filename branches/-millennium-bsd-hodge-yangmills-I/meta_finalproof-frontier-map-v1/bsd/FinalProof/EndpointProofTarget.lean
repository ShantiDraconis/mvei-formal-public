namespace BSD.FinalProof

structure BSD003Requirements where
  IdentificationOperator_Z : Prop
  canonical_normalization_identification : Prop
  full_bsd_endpoint : Prop

def BSD003Requirements.closed (r : BSD003Requirements) : Prop :=
  r.IdentificationOperator_Z ∧
  r.canonical_normalization_identification ∧
  r.full_bsd_endpoint

theorem bsd003_closes_from_requirements
    (r : BSD003Requirements)
    (h : r.closed) :
    r.closed := h

theorem bsd003_assemble
    (r : BSD003Requirements)
    (h1 : r.IdentificationOperator_Z)
    (h2 : r.canonical_normalization_identification)
    (h3 : r.full_bsd_endpoint) :
    r.closed :=
  ⟨h1, h2, h3⟩


end BSD.FinalProof
