namespace OpenMathMiner

inductive DualState
  | equal
  | separate
  deriving Repr, DecidableEq

structure ConditionalWorld (Claim : Prop) where
  Laws : Prop
  laws_hold : Laws
  closes : Laws → Claim

structure ExclusiveDualWorld (Claim : Prop) where
  state : DualState
  equalWorld : ConditionalWorld Claim
  separateWorld : ConditionalWorld (¬ Claim)
  activeEqual : state = .equal → equalWorld.Laws
  activeSeparate : state = .separate → separateWorld.Laws

theorem equal_branch_closed {Claim : Prop} (W : ExclusiveDualWorld Claim)
    (h : W.state = .equal) : Claim :=
  W.equalWorld.closes (W.activeEqual h)

theorem separate_branch_closed {Claim : Prop} (W : ExclusiveDualWorld Claim)
    (h : W.state = .separate) : ¬ Claim :=
  W.separateWorld.closes (W.activeSeparate h)

theorem dual_exhaustive {Claim : Prop} (W : ExclusiveDualWorld Claim) :
    Claim ∨ ¬ Claim := by
  cases h : W.state with
  | equal =>
      exact Or.inl (equal_branch_closed W h)
  | separate =>
      exact Or.inr (separate_branch_closed W h)

theorem branch_exclusive {Claim : Prop} :
    ¬ (Claim ∧ ¬ Claim) := by
  intro h
  exact h.2 h.1

structure RealizationCertificate (Claim : Prop) (W : ExclusiveDualWorld Claim) where
  realized : W.state = .equal ∨ W.state = .separate

theorem realization_selects_branch
    {Claim : Prop} (W : ExclusiveDualWorld Claim)
    (R : RealizationCertificate Claim W) :
    Claim ∨ ¬ Claim := by
  cases R.realized with
  | inl h => exact Or.inl (equal_branch_closed W h)
  | inr h => exact Or.inr (separate_branch_closed W h)

end OpenMathMiner
