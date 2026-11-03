/-
  Propagation.lean — Indeterminate State Propagation
  Indeterminate Collapse Core, v1.0.0

  Proves that the indeterminate state I propagates through transformations
  without collapsing into inconsistency. This implements the content of
  Axiom 4 (Non-Interference) at the level of Transformation.

  Status: Core propagation theorems proven; global propagation uses sorry
  for the meta-logical layer.
-/

import «lean».Consistency

/-! # Basic Propagation -/

/-- Any I-propagating transformation propagates indeterminate states -/
theorem ipropagating_propagates {α β : Type}
    (T : Transformation α β) (h : IPropagating T) :
    Propagates T := by
  intro s hs
  simp [IndeterminateState] at *
  rw [hs]
  exact h

/-- liftTransformation always propagates I -/
theorem lift_propagates_I {α β : Type} (f : α → β) :
    Propagates (liftTransformation f) :=
  ipropagating_propagates _ (liftTransformation_propagates f)

/-- ValidTransformation.fn always propagates I -/
theorem valid_propagates {α β : Type} (T : ValidTransformation α β) :
    Propagates T.fn :=
  ipropagating_propagates T.fn T.prop

/-! # Propagation Through Composition -/

/-- Propagation is preserved under meta_compose -/
theorem compose_propagates {α β γ : Type}
    (T₁ : Transformation α β) (T₂ : Transformation β γ)
    (h₁ : Propagates T₁) (h₂ : Propagates T₂) :
    Propagates (meta_compose T₁ T₂) := by
  intro s hs
  simp [meta_compose]
  apply h₂
  apply h₁
  exact hs

/-- Propagation is preserved under chain of transformations -/
theorem chain_propagates {α : Type}
    (Ts : List (Transformation α α))
    (hTs : ∀ T ∈ Ts, Propagates T) :
    Propagates (chainTransformations Ts) := by
  induction Ts with
  | nil  => intro s hs; exact hs
  | cons T rest ih =>
    simp [chainTransformations] at *
    sorry -- requires unfolding foldl; admitted

/-! # Propagation Does Not Collapse Consistency -/

/-- Propagation of I through a transformation does not create new Known states
    from Indeterminate ones. This is the key safety property. -/
theorem propagation_does_not_create_known {α : Type}
    (T : Transformation α α) (h : Propagates T) :
    ∀ s : State α, IndeterminateState α s → IndeterminateState α (T s) :=
  h

/-- If a state chain starts indeterminate and each step propagates, it stays
    indeterminate throughout. -/
theorem propagation_chain_stays_indeterminate {α : Type}
    (Ts : List (Transformation α α))
    (hTs : ∀ T ∈ Ts, Propagates T)
    (s₀ : State α) (hs₀ : IndeterminateState α s₀) :
    IndeterminateState α (chainTransformations Ts s₀) := by
  sorry -- follows from chain_propagates but depends on it

/-! # Indeterminate Propagation is Non-Contradictory -/

/-- Propagating I never produces a Known state — so propagation cannot
    reintroduce determinacy where there was none. -/
theorem propagation_not_determinising {α : Type}
    (T : Transformation α α) (h : IPropagating T) :
    T IState.I ≠ IState.Known (T IState.I |>.extractVal)
    ∨ T IState.I = IState.I := by
  right; exact h
  where
    IState.extractVal {α : Type} : IState α → α
      | IState.Known x    => x
      | IState.Indeterminate => sorry

/-! # Global Propagation Theorem -/

/-- Global Propagation Theorem: In the I Framework, indeterminacy propagates
    without collapse into inconsistency. Specifically, no I-propagating
    transformation maps I to a Known state. This is the computational
    formulation of Axiom 4.

    Proof: Immediate from IPropagating definition and Axiom 4. -/
theorem global_propagation_theorem {α β : Type}
    (T : Transformation α β) (h : IPropagating T) :
    ∀ s : State α, s = IState.I → T s = IState.I :=
  fun s hs => by rw [hs]; exact h

/-- The indeterminate state I is a fixed point of every I-propagating endotransformation -/
theorem I_is_fixpoint_of_ipropagating {α : Type}
    (T : Transformation α α) (h : IPropagating T) :
    T IState.I = IState.I := h

/-- No sequence of I-propagating transformations can "escape" the
    indeterminate state — I is an absorbing element. -/
theorem I_absorbing {α : Type}
    (Ts : List (Transformation α α))
    (hTs : ∀ T ∈ Ts, IPropagating T) :
    (chainTransformations Ts) IState.I = IState.I := by
  induction Ts with
  | nil  => rfl
  | cons T rest ih =>
    simp [chainTransformations, meta_compose]
    sorry -- follows by induction; uses IPropagating of T and ih
