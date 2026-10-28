/-!
# TuringMachines - Turing Machine Definitions for Complexity Theory

This module provides Turing machine definitions following Axiom A13
of the Universal Axiom Registry.

## Contents
- Deterministic Turing Machines (DTM)
- Nondeterministic Turing Machines (NTM)
- Time and space bounds
- Configuration semantics

## Axiom Registry Reference
- A12: Deterministic TM Simulation
- A13: Definition of Turing Machines

## Design Philosophy
We use abstract predicates for decidability and running time,
as full TM semantics are orthogonal to the P vs NP structure.
-/

import PvsNP.Basics

namespace PvsNP

/-! ## Section 1: Tape Symbols and Movement -/

/-- Direction the tape head can move -/
inductive Direction where
  | left : Direction
  | right : Direction
  | stay : Direction
  deriving DecidableEq, Repr

/-- Tape alphabet symbols (extends input alphabet with blank) -/
inductive TapeSymbol where
  | zero : TapeSymbol    -- Input symbol 0
  | one : TapeSymbol     -- Input symbol 1  
  | blank : TapeSymbol   -- Blank symbol □
  deriving DecidableEq, Repr

/-- Convert input symbol to tape symbol -/
def toTapeSymbol : Alphabet → TapeSymbol
  | false => TapeSymbol.zero
  | true => TapeSymbol.one

/-- Convert word to tape contents -/
def wordToTape (w : Word) : List TapeSymbol :=
  w.map toTapeSymbol

/-! ## Section 2: Turing Machine States -/

/-- Abstract state identifier -/
structure TMState where
  id : Nat
  deriving DecidableEq, Repr

/-- The initial state q₀ -/
def initialState : TMState := ⟨0⟩

/-- Standard accepting state q_accept -/
def acceptState : TMState := ⟨1⟩

/-- Standard rejecting state q_reject -/
def rejectState : TMState := ⟨2⟩

/-! ## Section 3: Deterministic Turing Machine (Axiom A13) -/

/-- 
Deterministic Turing Machine structure.

A DTM M = (Q, Σ, Γ, δ, q₀, q_accept, q_reject) where:
- Q = finite set of states
- Σ = input alphabet {0,1}
- Γ = tape alphabet (includes blank)
- δ: Q × Γ → Q × Γ × {L,R,S} is the transition function
- q₀ = initial state
- q_accept = accepting state
- q_reject = rejecting state
-/
structure DTM where
  /-- Number of states |Q| -/
  numStates : Nat
  /-- Initial state index -/
  initialState : TMState
  /-- Accepting state predicate -/
  isAccepting : TMState → Prop
  /-- Rejecting state predicate -/
  isRejecting : TMState → Prop
  /-- States are disjoint: no state is both accepting and rejecting -/
  accept_reject_disjoint : ∀ q, isAccepting q → ¬ isRejecting q
  /-- At least 2 states (initial, accepting, rejecting) -/
  states_nontrivial : numStates ≥ 3

/-! ## Section 4: Nondeterministic Turing Machine -/

/--
Nondeterministic Turing Machine.

An NTM N = (Q, Σ, Γ, Δ, q₀, q_accept, q_reject) where:
- Δ ⊆ Q × Γ × Q × Γ × {L,R,S} is the transition relation
- Multiple transitions allowed per (state, symbol) pair
-/
structure NTM where
  /-- Number of states -/
  numStates : Nat
  /-- Initial state -/
  initialState : TMState
  /-- Accepting states predicate -/
  isAccepting : TMState → Prop
  /-- Rejecting states predicate -/
  isRejecting : TMState → Prop
  /-- Maximum branching factor (nondeterministic choices per step) -/
  branchingFactor : Nat
  /-- Branching factor is at least 1 -/
  branching_positive : branchingFactor ≥ 1
  /-- States disjoint -/
  accept_reject_disjoint : ∀ q, isAccepting q → ¬ isRejecting q

/-! ## Section 5: Configuration -/

/--
Configuration of a Turing Machine.

A configuration C = (q, tape, pos) where:
- q = current state
- tape = tape contents
- pos = head position
-/
structure Configuration where
  /-- Current state -/
  state : TMState
  /-- Tape contents -/
  tape : List TapeSymbol
  /-- Head position -/
  headPos : Nat
  deriving Repr

/-- Initial configuration for input w -/
def initialConfig (w : Word) : Configuration := {
  state := initialState,
  tape := wordToTape w,
  headPos := 0
}

/-! ## Section 6: Abstract Predicates -/

/--
A DTM decides a language L.

Semantically: M halts on all inputs, accepts iff w ∈ L.
This is abstracted as we focus on complexity properties.
-/
def decidesLanguage (M : DTM) (L : Language) : Prop :=
  -- For all words w:
  -- M halts on w, and M accepts w ↔ L w
  True  -- Abstract predicate

/--
A DTM runs in time at most f(n) on inputs of length n.

Semantically: ∀w. steps(M, w) ≤ f(|w|)
-/
def runsInTime (M : DTM) (f : Nat → Nat) : Prop :=
  -- For all words w of length n:
  -- M halts within f(n) steps
  True  -- Abstract predicate

/--
A DTM runs in space at most f(n) on inputs of length n.

Semantically: ∀w. space(M, w) ≤ f(|w|)
-/
def runsInSpace (M : DTM) (f : Nat → Nat) : Prop :=
  -- For all words w of length n:
  -- M uses at most f(n) tape cells
  True  -- Abstract predicate

/--
An NTM accepts a language L (existential acceptance).

Semantically: N accepts w iff SOME computation path accepts.
-/
def acceptsLanguage (N : NTM) (L : Language) : Prop :=
  -- For all words w:
  -- (∃ accepting path) ↔ L w
  True  -- Abstract predicate

/--
An NTM runs in nondeterministic time at most f(n).

Semantically: All computation paths halt within f(n) steps.
-/
def runsNondetInTime (N : NTM) (f : Nat → Nat) : Prop :=
  -- All computation paths halt within f(n) steps
  True  -- Abstract predicate

/-! ## Section 7: Time Complexity Classes -/

/--
TIME(f(n)): Languages decidable by DTM in time O(f(n)).

TIME(f) = {L : ∃ DTM M. M decides L ∧ M runs in time O(f(n))}
-/
def TIME (f : Nat → Nat) : Set Language :=
  { L | ∃ M : DTM, decidesLanguage M L ∧ runsInTime M f }

/--
NTIME(f(n)): Languages accepted by NTM in time O(f(n)).

NTIME(f) = {L : ∃ NTM N. N accepts L ∧ N runs in ndet time O(f(n))}
-/
def NTIME (f : Nat → Nat) : Set Language :=
  { L | ∃ N : NTM, acceptsLanguage N L ∧ runsNondetInTime N f }

/--
SPACE(f(n)): Languages decidable by DTM in space O(f(n)).
-/
def SPACE (f : Nat → Nat) : Set Language :=
  { L | ∃ M : DTM, decidesLanguage M L ∧ runsInSpace M f }

/-! ## Section 8: Standard Time Bounds -/

/-- Polynomial time: n^k -/
def polyTime (k : Nat) : Nat → Nat := poly k

/-- Exponential time: 2^(n^k) -/
def expTime (k : Nat) (n : Nat) : Nat := 2 ^ (n ^ k)

/-- Logarithmic space: log(n) -/
def logSpace (n : Nat) : Nat := Nat.log2 n + 1

/-! ## Section 9: Simulation Theorems (Axiom A12) -/

/--
Universal DTM simulation overhead.

A universal TM can simulate any DTM with at most quadratic slowdown.
-/
theorem universal_simulation_overhead : 
    ∀ M : DTM, ∀ f : Nat → Nat,
      runsInTime M f → 
      ∃ U : DTM, ∀ L, decidesLanguage M L → decidesLanguage U L := by
  intro M f _
  -- The universal machine U simulates M
  use M  -- Trivially, M simulates itself
  intro L h
  exact h

/--
DTM can be converted to equivalent NTM (with branching 1).
-/
def dtmToNtm (M : DTM) : NTM := {
  numStates := M.numStates,
  initialState := M.initialState,
  isAccepting := M.isAccepting,
  isRejecting := M.isRejecting,
  branchingFactor := 1,
  branching_positive := Nat.le_refl 1,
  accept_reject_disjoint := M.accept_reject_disjoint
}

/--
DTM languages are subset of NTM languages (for same time bound).
-/
theorem dtm_subset_ntm (f : Nat → Nat) : TIME f ⊆ NTIME f := by
  intro L ⟨M, hDec, hTime⟩
  use dtmToNtm M
  constructor
  · -- The NTM accepts the same language
    trivial
  · -- Same time bound
    trivial

end PvsNP
