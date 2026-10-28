namespace YangMills.FinalProof

structure MassGapFrontier (A P B : Prop) where
  constructiveInfrastructure : A
  missingPhysicalBridge : ¬ P
  endpointRequires : B → P

theorem mass_gap_endpoint_unreachable
    {A P B : Prop} (f : MassGapFrontier A P B) : ¬ B := by
  intro hB
  exact f.missingPhysicalBridge (f.endpointRequires hB)

end YangMills.FinalProof
