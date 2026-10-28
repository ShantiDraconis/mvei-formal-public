namespace Hodge.FinalProof

structure AlgebraicityFrontier (A P B : Prop) where
  algebraicCycleInfrastructure : A
  missingSurjectivity : ¬ P
  endpointRequires : B → P

theorem algebraicity_endpoint_unreachable
    {A P B : Prop} (f : AlgebraicityFrontier A P B) : ¬ B := by
  intro hB
  exact f.missingSurjectivity (f.endpointRequires hB)

end Hodge.FinalProof
