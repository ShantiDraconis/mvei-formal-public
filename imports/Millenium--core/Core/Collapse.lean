/-!
# Core/Collapse.lean
## The Indeterminate Framework (TIF) — Collapse Operator

This file defines the **collapse operator** `Collapse_Σ : Term ⇀ ClassicalScalar`
and states (as axioms or proved lemmas) the core collapse properties A6–A8, T2, T3.

Depends on: `Core.Types`, `Core.Syntax`, `Core.State`, `Core.Eval`
-/

import Core.Types
import Core.Syntax
import Core.State
import Core.Eval

-- ---------------------------------------------------------------------------
-- D17 / A6–A8 : Collapse operator
-- ---------------------------------------------------------------------------

/-- **Collapse result**: either a classical scalar or a *blocked* marker (D17, D16).

    Implementations return `CollapseResult.blocked` instead of being literally
    partial, as noted in D17. -/
inductive CollapseResult : Type where
  /-- The term collapsed to classical scalar `c`. -/
  | value   (c : ClassicalScalar) : CollapseResult
  /-- The term is blocked in the given state. -/
  | blocked                        : CollapseResult
  deriving Repr

/-- **Collapse operator** `Collapse_Σ(t)` (D17).

    Returns `CollapseResult.value c` iff `⟦t⟧_Σ = {c}`;
    returns `CollapseResult.blocked` otherwise. -/
noncomputable def collapse (σ : State) (t : Term) : CollapseResult :=
  if h : ∃! c : ClassicalScalar, c ∈ semValueSet σ t then
    CollapseResult.value (Classical.choose h)
  else
    CollapseResult.blocked

-- ---------------------------------------------------------------------------
-- A6 : State-governed collapse
-- ---------------------------------------------------------------------------

/-- **State-Governed Collapse** (A6): collapse is always relative to an explicit state.
    This is enforced structurally by the signature of `collapse`. -/
theorem collapse_requires_state : True := trivial

-- ---------------------------------------------------------------------------
-- T2 : Collapse soundness
-- ---------------------------------------------------------------------------

/-- **Collapse Soundness** (T2): if `collapse σ t = value c` then `⟦t⟧_Σ = {c}`. -/
theorem collapse_soundness (σ : State) (t : Term) (c : ClassicalScalar)
    (h : collapse σ t = CollapseResult.value c) :
    semValueSet σ t = {c} := by
  unfold collapse at h
  split_ifs at h with huniq
  · -- There exists a unique value; `c` is `Classical.choose huniq`.
    have heq : Classical.choose huniq = c := by
      cases h; rfl
    ext v
    simp only [Set.mem_singleton_iff]
    constructor
    · intro hmem
      have := Classical.choose_spec huniq
      rw [ExistsUnique] at this
      obtain ⟨hmem', hunique⟩ := this
      exact (hunique v hmem).symm ▸ heq
    · intro heqv
      rw [heqv, ← heq]
      exact (Classical.choose_spec huniq).1
  · simp at h

-- ---------------------------------------------------------------------------
-- T3 : Collapse completeness on unique states
-- ---------------------------------------------------------------------------

/-- **Collapse Completeness on Unique States** (T3):
    if `⟦t⟧_Σ = {c}` then `collapse σ t = value c`. -/
theorem collapse_completeness (σ : State) (t : Term) (c : ClassicalScalar)
    (h : semValueSet σ t = {c}) :
    collapse σ t = CollapseResult.value c := by
  unfold collapse
  have huniq : ∃! v : ClassicalScalar, v ∈ semValueSet σ t := by
    exact ⟨c, by simp [h], fun v hv => by simp [h] at hv; exact hv⟩
  simp only [dif_pos huniq]
  congr 1
  have hspec := (Classical.choose_spec huniq).1
  simp [h] at hspec
  exact hspec.symm

-- ---------------------------------------------------------------------------
-- A8 : Non-unique-resolution blocking
-- ---------------------------------------------------------------------------

/-- **Non-Unique-Resolution Blocking** (A8):
    if `⟦t⟧_Σ` is not a singleton then `collapse σ t = blocked`. -/
theorem collapse_blocked_of_non_unique (σ : State) (t : Term)
    (h : ¬ ∃! c : ClassicalScalar, c ∈ semValueSet σ t) :
    collapse σ t = CollapseResult.blocked := by
  unfold collapse
  simp only [dif_neg h]

-- ---------------------------------------------------------------------------
-- A11 : No arbitrary collapse
-- ---------------------------------------------------------------------------

/-- **No Arbitrary Collapse** (A11): a term that contains an indeterminate
    symbol and whose semantic value set is not a singleton cannot be collapsed
    to any classical scalar. -/
theorem no_arbitrary_collapse (σ : State) (t : Term)
    (hind : ¬ t.isClassical)
    (hblocked : ¬ ∃! c : ClassicalScalar, c ∈ semValueSet σ t) :
    collapse σ t = CollapseResult.blocked :=
  collapse_blocked_of_non_unique σ t hblocked
