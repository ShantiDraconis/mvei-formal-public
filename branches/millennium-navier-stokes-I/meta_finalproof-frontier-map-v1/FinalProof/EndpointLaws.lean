import FinalProof.EndpointProofTarget

namespace FinalProof

theorem ns003_has_ActualNS
    (r : NS003Requirements) (h : r.closed) :
    r.ActualNS_analytic_certificates := h.1

theorem ns003_has_StrictSignedDepletionProducer
    (r : NS003Requirements) (h : r.closed) :
    r.StrictSignedDepletionProducer := h.2.1

theorem ns003_has_genuine_G1
    (r : NS003Requirements) (h : r.closed) :
    r.genuine_G1_route := h.2.2.1

theorem ns003_has_vorticity_bound
    (r : NS003Requirements) (h : r.closed) :
    r.vorticity_production_bound := h.2.2.2.1

theorem ns003_has_directional_control
    (r : NS003Requirements) (h : r.closed) :
    r.directional_geometric_control := h.2.2.2.2.1

theorem ns003_has_BKM
    (r : NS003Requirements) (h : r.closed) :
    r.BKM_closure := h.2.2.2.2.2

theorem ns003_all_requirements_iff
    (r : NS003Requirements) :
    r.closed ↔
      r.ActualNS_analytic_certificates ∧
      r.StrictSignedDepletionProducer ∧
      r.genuine_G1_route ∧
      r.vorticity_production_bound ∧
      r.directional_geometric_control ∧
      r.BKM_closure := by
  rfl

end FinalProof
