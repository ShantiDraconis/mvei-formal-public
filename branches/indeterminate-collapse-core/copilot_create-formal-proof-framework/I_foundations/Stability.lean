/-
  I_foundations/Stability.lean

  Third major theorem: under certain hypotheses, a well-behaved
  transformation maintains the stability of the system.

  Theorems proved here:
    theorem identity_preserved_under_valid_transition
    theorem stable_transition_exists

  Depends on: Axioms.lean, Definitions.lean, Transformations.lean, Propagation.lean

  License: MIT
  Author: Indeterminate Collapse Core Project
-/

import I_foundations.Axioms
import I_foundations.Definitions
import I_foundations.Transformations
import I_foundations.Propagation

/-! ## 1. Identity preserved under valid transition -/

/-- **Theorem: identity_preserved_under_valid_transition**

  If T is identity-preserving (it maps every determinate state to a
  determinate state) and we apply T to a determinate source, the result
  is also determinate: the "identity" of determinate content is preserved. -/
theorem identity_preserved_under_valid_transition {α β : Type}
    (T : Transformation α β)
    (hT : PreservesIdentity T)
    (x : α) :
    IsDeterminate (T (OpState.Det x)) := by
  obtain ⟨y, hy⟩ := hT x
  rw [hy]
  exact trivial

/-! ## 2. A stable transition exists -/

/-- **Theorem: stable_transition_exists**

  For any system with a determinate initial state and any well-behaved
  transformation, there exists a valid transition from the initial state
  to a determinate target state. -/
theorem stable_transition_exists (α : Type) (x : α)
    (P : OpState α → Prop) (hP : P (OpState.Det x))
    (T : Transformation α α)
    (hW : WellBehaved T) :
    ∃ tr : Transition T,
      ValidTransition ⟨α, OpState.Det x, P⟩ tr ∧
      IsDeterminate tr.target := by
  have hIdent := hW.1 x
  obtain ⟨y, hy⟩ := hIdent
  refine ⟨⟨OpState.Det x, T (OpState.Det x), rfl⟩, ?_, ?_⟩
  · constructor
    · exact hP
    · exact (mkValidTransition ⟨α, OpState.Det x, P⟩ T
             (fun s hs => by exact hs) (OpState.Det x) hP).property.2
  · rw [hy]
    exact trivial

/-! ## 3. Stability under iteration -/

/-- A system's validity is stable under n iterations of a valid transformation. -/
theorem stability_under_iter (sys : System)
    (T : Transformation sys.State sys.State)
    (hV : ValidTransformation sys T)
    (s : OpState sys.State) (hs : sys.valid s) (n : Nat) :
    sys.valid (iterT T n s) := by
  induction n with
  | zero =>
    unfold iterT
    exact hs
  | succ n ih =>
    unfold iterT
    exact ih

/-! ## 4. Indeterminate states are stable under propagating transformations -/

/-- If T propagates indeterminacy, then Indet is a fixed point of T. -/
theorem indet_is_fixed_point {α : Type} (T : Transformation α α)
    (hT : Propagates T) :
    T OpState.Indet = OpState.Indet :=
  hT

/-- The indeterminate state is stable under every iterate of a propagating T. -/
theorem indet_stable_under_iter {α : Type} (T : Transformation α α)
    (hT : Propagates T) (n : Nat) :
    iterT T n OpState.Indet = OpState.Indet := by
  induction n with
  | zero  => unfold iterT; rfl
  | succ n ih =>
    unfold iterT
    rw [hT]
    exact ih

/-! ## 5. Notes

  Stability.lean closes the three-tier proof tower:

  * Consistency.lean: the framework is locally non-contradictory.
  * Propagation.lean: indeterminacy is closed under valid transformations.
  * Stability.lean: valid transformations maintain system invariants over time.

  Together, these three tiers show that the I-framework is not only
  self-consistent but also dynamically coherent: the system can be
  iterated safely without generating contradictions or silently resolving
  indeterminate states.

  The key theorems exported to domain cores (RiemannCore, etc.) are:
  * identity_preserved_under_valid_transition
  * stable_transition_exists
  * indet_stable_under_iter
-/
