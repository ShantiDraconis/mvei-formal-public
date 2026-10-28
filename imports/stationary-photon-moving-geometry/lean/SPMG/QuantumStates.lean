namespace SPMG

universe u

/-- Abstract quantum-inspired state space.  This is structural mathematics only. -/
structure QuantumStateSpace where
  Basis : Type u
  State : Type u
  embed : Basis → State
  superpose : State → State → State

/-- Two-state exchange operator. -/
structure Involution (Q : QuantumStateSpace) where
  act : Q.State → Q.State
  squared : ∀ ψ, act (act ψ) = ψ

theorem involution_order_two
    {Q : QuantumStateSpace} (U : Involution Q) (ψ : Q.State) :
    U.act (U.act ψ) = ψ :=
  U.squared ψ

/-- Pair of commuting state symmetries. -/
structure CommutingSymmetries (Q : QuantumStateSpace) where
  A : Involution Q
  B : Involution Q
  commute : ∀ ψ, A.act (B.act ψ) = B.act (A.act ψ)

theorem symmetry_pair_commutes
    {Q : QuantumStateSpace} (S : CommutingSymmetries Q) (ψ : Q.State) :
    S.A.act (S.B.act ψ) = S.B.act (S.A.act ψ) :=
  S.commute ψ

#print axioms involution_order_two
#print axioms symmetry_pair_commutes

end SPMG
