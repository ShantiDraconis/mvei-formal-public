namespace BSD.FinalProof

structure IdentificationFrontier (A P B : Prop) where
  leadingTermInfrastructure : A
  missingCanonicalIdentification : ¬ P
  endpointRequires : B → P

theorem bsd_endpoint_unreachable
    {A P B : Prop} (f : IdentificationFrontier A P B) : ¬ B := by
  intro hB
  exact f.missingCanonicalIdentification (f.endpointRequires hB)

end BSD.FinalProof
