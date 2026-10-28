namespace YangMills.FinalProof

structure YM003Requirements where
  regulated_YM4 : Prop
  reflection_positive : Prop
  Hilbert_Hamiltonian_reconstruction : Prop
  uniform_clustering : Prop
  YM_semigroup_Laplace : Prop
  SpectralExclusion_GREEN : Prop
  K30 : Prop
  K14MassGap : Prop
  exact_YM_endpoint : Prop
  axiom_creep_clean : Prop

def YM003Requirements.closed (r : YM003Requirements) : Prop :=
  r.regulated_YM4 ∧
  r.reflection_positive ∧
  r.Hilbert_Hamiltonian_reconstruction ∧
  r.uniform_clustering ∧
  r.YM_semigroup_Laplace ∧
  r.SpectralExclusion_GREEN ∧
  r.K30 ∧
  r.K14MassGap ∧
  r.exact_YM_endpoint ∧
  r.axiom_creep_clean

theorem ym003_closes_from_requirements
    (r : YM003Requirements)
    (h : r.closed) :
    r.closed := h

theorem ym003_assemble
    (r : YM003Requirements)
    (h1 : r.regulated_YM4)
    (h2 : r.reflection_positive)
    (h3 : r.Hilbert_Hamiltonian_reconstruction)
    (h4 : r.uniform_clustering)
    (h5 : r.YM_semigroup_Laplace)
    (h6 : r.SpectralExclusion_GREEN)
    (h7 : r.K30)
    (h8 : r.K14MassGap)
    (h9 : r.exact_YM_endpoint)
    (h10 : r.axiom_creep_clean) :
    r.closed :=
  ⟨h1, h2, h3, h4, h5, h6, h7, h8, h9, h10⟩


end YangMills.FinalProof
