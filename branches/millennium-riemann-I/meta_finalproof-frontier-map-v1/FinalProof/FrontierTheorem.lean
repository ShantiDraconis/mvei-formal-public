namespace FinalProof

/-- Riemann endpoint boundary.
If a classical zero-location endpoint requires a real-coordinate-control
obligation P, then an explicit absence of P blocks that endpoint.
This does not assert RH or its negation. -/
structure RHEndpointFrontier (A P B : Prop) where
  analyticPrefix : A
  missingRealCoordinateControl : ¬ P
  endpointRequires : B → P

theorem rh_endpoint_unreachable_without_control
    {A P B : Prop} (f : RHEndpointFrontier A P B) : ¬ B := by
  intro hB
  exact f.missingRealCoordinateControl (f.endpointRequires hB)

end FinalProof
