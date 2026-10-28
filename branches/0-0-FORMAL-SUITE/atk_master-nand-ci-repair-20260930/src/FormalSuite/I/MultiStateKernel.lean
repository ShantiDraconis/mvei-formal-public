/-
  FormalSuite/I/MultiStateKernel.lean

  A three-state kernel kept separate from the legacy IField model.

  The legacy IField axioms imply I = 1 inside a field.  This module does
  not modify or reopen that result.  Instead it models the proposed
  Seed -> Transit -> Manifest dynamics as a finite state machine and
  proves a concrete producer/soundness theorem for finite Boolean search.

  No new axioms. No sorry.
-/

import FormalSuite.Core.Prelude

namespace FormalSuite.IMultiState

universe u

/-- The three operational phases of the multistate kernel. -/
inductive Phase where
  | seed
  | transit
  | manifest
  deriving DecidableEq, Repr

open Phase

/-- Pure cyclic rotation of the three phases. -/
def rotate : Phase → Phase
  | seed => transit
  | transit => manifest
  | manifest => seed

@[simp] theorem rotate_seed : rotate seed = transit := rfl
@[simp] theorem rotate_transit : rotate transit = manifest := rfl
@[simp] theorem rotate_manifest : rotate manifest = seed := rfl

/-- Three rotations return to the original phase. -/
theorem rotate_three (p : Phase) :
    rotate (rotate (rotate p)) = p := by
  cases p <;> rfl

/-- One rotation never fixes a phase. -/
theorem rotate_ne_self (p : Phase) :
    rotate p ≠ p := by
  cases p <;> decide

/--
A Boolean readout that is invariant under every phase rotation is forced
to be constant.  Therefore a nontrivial Boolean projection cannot be a
phase-invariant readout of the three-cycle; it must be attached to a
terminal certificate/semantics instead.
-/
theorem rotation_invariant_bool_constant
    (π : Phase → Bool)
    (h : ∀ p : Phase, π (rotate p) = π p) :
    ∀ p q : Phase, π p = π q := by
  have hST : π transit = π seed := h seed
  have hTM : π manifest = π transit := h transit
  intro p q
  cases p <;> cases q <;> simp_all

/--
A small exact Boolean-search producer.  It returns the first candidate
whose checker evaluates to true.
-/
def findFirst {α : Type u} (check : α → Bool) : List α → Option α
  | [] => none
  | x :: xs =>
      if check x then
        some x
      else
        findFirst check xs

/-- Any witness returned by `findFirst` is accepted by the checker. -/
theorem findFirst_sound {α : Type u}
    (check : α → Bool) (xs : List α) (x : α)
    (h : findFirst check xs = some x) :
    check x = true := by
  induction xs with
  | nil =>
      simp [findFirst] at h
  | cons y ys ih =>
      cases hcheck : check y with
      | false =>
          have htail : findFirst check ys = some x := by
            simpa [findFirst, hcheck] using h
          exact ih htail
      | true =>
          have hyx : y = x := by
            simpa [findFirst, hcheck] using h
          simpa [hyx] using hcheck

/--
Operational state: the phase is distinct from the candidate payload and
from the optional produced witness.
-/
structure KernelState (α : Type u) where
  phase : Phase
  candidates : List α
  result : Option α
  deriving Repr

/-- Initial state: Seed, no produced result yet. -/
def init {α : Type u} (xs : List α) : KernelState α where
  phase := seed
  candidates := xs
  result := none

/--
One forward step.

Seed     -> Transit
Transit  -> Manifest and runs the exact finite producer
Manifest -> Manifest (terminal/frozen)
-/
def advance {α : Type u} (check : α → Bool) (s : KernelState α) :
    KernelState α :=
  match s.phase with
  | seed =>
      { s with phase := transit }
  | transit =>
      { s with
        phase := manifest
        result := findFirst check s.candidates }
  | manifest =>
      s

/-- Exactly two forward steps from an initialized state. -/
def runTwo {α : Type u} (check : α → Bool) (xs : List α) :
    KernelState α :=
  advance check (advance check (init xs))

/-- Two steps reach Manifest. -/
@[simp] theorem runTwo_phase {α : Type u}
    (check : α → Bool) (xs : List α) :
    (runTwo check xs).phase = manifest := by
  rfl

/-- The produced result is exactly the finite-search result. -/
@[simp] theorem runTwo_result {α : Type u}
    (check : α → Bool) (xs : List α) :
    (runTwo check xs).result = findFirst check xs := by
  rfl

/--
Terminal soundness: a witness manifested by the kernel is accepted by
the checker.
-/
theorem runTwo_sound {α : Type u}
    (check : α → Bool) (xs : List α) (x : α)
    (h : (runTwo check xs).result = some x) :
    check x = true := by
  have h' : findFirst check xs = some x := by
    simpa using h
  exact findFirst_sound check xs x h'

/--
A terminal certificate contains a concrete witness together with the
checker fact certified by the producer.
-/
structure ManifestCertificate (α : Type u) (check : α → Bool) where
  witness : α
  accepted : check witness = true

/--
Exact certificate producer for the finite kernel.  This does not assume
the desired witness as a hypothesis: it computes `findFirst` and packages
the soundness proof only when a witness was actually produced.
-/
def produceCertificate {α : Type u}
    (check : α → Bool) (xs : List α) :
    Option (ManifestCertificate α check) :=
  match h : findFirst check xs with
  | none => none
  | some x =>
      some {
        witness := x
        accepted := findFirst_sound check xs x h
      }

/-
The kernel therefore provides a proved nontrivial mechanism of the form

  Seed -> Transit -> Manifest -> Boolean certificate

for finite decidable search.  Extending this to any open mathematical
problem still requires a domain-specific producer and a correctness bridge;
those are intentionally not postulated here.
-/

end FormalSuite.IMultiState
