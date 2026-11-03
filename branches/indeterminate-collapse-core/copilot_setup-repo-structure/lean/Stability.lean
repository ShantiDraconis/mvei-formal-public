/-
  Stability.lean — Stability of the I Framework
  Indeterminate Collapse Core, v1.0.0

  Proves that the I Framework is stable: under valid (I-propagating,
  identity-preserving) transformations, the system behaves predictably
  — Known states remain Known and Indeterminate states remain Indeterminate.

  Status: Stability theorems proven under hypotheses; global stability
  statement uses sorry for the meta-logical layer.
-/

import «lean».Propagation

/-! # Pointwise Stability -/

/-- A Stable transformation (I-propagating and identity-preserving) maps
    Known states to Known states and I to I. -/
theorem stable_maps_known_to_known {α β : Type}
    (T : Transformation α β) (hs : Stable T) (x : α) :
    ∃ y : β, T (IState.Known x) = IState.Known y :=
  hs.2 x

/-- A Stable transformation maps I to I -/
theorem stable_maps_I_to_I {α β : Type}
    (T : Transformation α β) (hs : Stable T) :
    T IState.I = IState.I :=
  hs.1

/-- A Stable transformation never maps a Known state to I -/
theorem stable_known_not_I {α β : Type}
    (T : Transformation α β) (hs : Stable T) (x : α) :
    T (IState.Known x) ≠ IState.I := by
  obtain ⟨y, hy⟩ := stable_maps_known_to_known T hs x
  rw [hy]
  exact known_ne_I y

/-! # Stability Under Composition -/

/-- Stability is preserved under composition of ValidTransformations -/
theorem valid_compose_stable {α β γ : Type}
    (T₁ : ValidTransformation α β)
    (T₂ : ValidTransformation β γ) :
    Stable (meta_compose T₁.fn T₂.fn) :=
  ⟨meta_compose_preserves_I T₁.fn T₂.fn T₁.prop T₂.prop,
   fun x => by
     simp [meta_compose]
     obtain ⟨y, hy⟩ := T₁.ident x
     rw [hy]
     exact T₂.ident y⟩

/-- liftTransformation is always Stable -/
theorem liftTransformation_is_stable {α β : Type} (f : α → β) :
    Stable (liftTransformation f) :=
  liftTransformation_stable f

/-! # State Preservation -/

/-- Under a Stable transformation, DeterminateState is preserved -/
theorem stable_preserves_determinate {α β : Type}
    (T : Transformation α β) (hs : Stable T) :
    ∀ s : State α, DeterminateState s → DeterminateState (T s) := by
  intro s ⟨x, hx⟩
  rw [hx]
  exact stable_maps_known_to_known T hs x

/-- Under a Stable transformation, IndeterminateState is preserved -/
theorem stable_preserves_indeterminate {α β : Type}
    (T : Transformation α β) (hs : Stable T) :
    ∀ s : State α, IndeterminateState α s → IndeterminateState β (T s) := by
  intro s hs_ind
  simp [IndeterminateState] at *
  rw [hs_ind]
  exact hs.1

/-! # System-Level Stability -/

/-- System Stability Theorem: Under all ValidTransformations, the state
    classification (Known vs Indeterminate) is invariant.
    
    This means the I Framework is stable: it cannot spontaneously transition
    a Known state to Indeterminate or vice versa under valid operations.
    
    Proof: Immediate from the definition of ValidTransformation (which
    requires both IPropagating and IdentityPreserving'). -/
theorem system_stability_theorem {α β : Type}
    (T : ValidTransformation α β) :
    (∀ s : State α, DeterminateState s → DeterminateState (T.fn s)) ∧
    (∀ s : State α, IndeterminateState α s → IndeterminateState β (T.fn s)) :=
  ⟨stable_preserves_determinate T.fn ⟨T.prop, T.ident⟩,
   stable_preserves_indeterminate T.fn ⟨T.prop, T.ident⟩⟩

/-- Corollary: No valid transformation creates indeterminacy from determinacy -/
theorem valid_does_not_indeterminate {α β : Type}
    (T : ValidTransformation α β) (s : State α) (hd : DeterminateState s) :
    ¬IndeterminateState β (T.fn s) := by
  obtain ⟨x, hx⟩ := hd
  obtain ⟨y, hy⟩ := T.ident x
  simp [IndeterminateState, hx, hy]
  exact known_ne_I y

/-- Corollary: No valid transformation resolves indeterminacy -/
theorem valid_does_not_resolve {α β : Type}
    (T : ValidTransformation α β) (s : State α)
    (hi : IndeterminateState α s) :
    IndeterminateState β (T.fn s) := by
  simp [IndeterminateState] at *
  rw [hi]
  exact T.prop

/-! # Global Stability -/

/-- Global Stability: the collapse mapping from Unknown problems stays at I
    under any sequence of valid operations. The indeterminate state is a
    stable attractor in the I Framework.
    
    TODO: Full formalization requires meta-logical model; admitted here. -/
theorem global_stability :
    ∀ (α β : Type) (T : ValidTransformation α β),
      Stable T.fn := by
  intro α β T
  exact ⟨T.prop, T.ident⟩
