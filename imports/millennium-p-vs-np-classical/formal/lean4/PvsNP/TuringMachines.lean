/-!
  # PvsNP.TuringMachines - Turing Machine Definitions
  
  This module provides an abstract model of Turing machines for
  defining complexity classes P and NP.
  
  ## Design Decisions
  
  We use an **abstract/axiomatic** approach rather than fully implementing
  TM semantics because:
  
  1. Full TM formalization is complex and orthogonal to our main goal
  2. The key theorems depend on *properties* of TMs, not implementations
  3. Classical results (P ⊆ NP, reductions) are well-established
  
  ## Axiom Status
  
  - `decidesLanguage`, `runsInTime`, etc. are **placeholders** (`True`)
  - They represent properties that would be defined with full TM semantics
  - Key theorems depending on these are marked with `sorry`
  
  ## Numerical Constants
  
  - Polynomial degree k ≥ 1 for TIME(n^k) bounds
  - Tape alphabet size |Γ| ≥ 2 (at least blank and input symbols)
  - State count |Q| ≥ 2 (at least initial and halting states)
-/

import PvsNP.Basics

namespace PvsNP

/-! ## Tape Head Movement -/

/-- Direction the tape head can move -/
inductive Direction
  | left : Direction
  | right : Direction
  | stay : Direction
  deriving DecidableEq, Repr

/-! ## Tape Symbols -/

/-- Tape alphabet symbols (includes blank) -/
inductive TapeSymbol
  | zero : TapeSymbol   -- Input symbol 0
  | one : TapeSymbol    -- Input symbol 1
  | blank : TapeSymbol  -- Blank symbol
  deriving DecidableEq, Repr

/-! ## Deterministic Turing Machines -/

/-- Abstract state identifier -/
structure TMState where
  id : Nat
  deriving DecidableEq, Repr

/-- 
  Deterministic Turing Machine (abstract representation)
  
  A full formalization would include:
  - Finite state set Q
  - Input alphabet Σ ⊆ Γ (tape alphabet)
  - Transition function δ: Q × Γ → Q × Γ × {L, R}
  - Start state q₀ ∈ Q
  - Accept state qₐ ∈ Q
  - Reject state qᵣ ∈ Q
  
  We abstract this to focus on complexity-relevant properties.
-/
structure DTM where
  /-- Number of states |Q| -/
  numStates : Nat
  /-- Initial state -/
  initialState : TMState
  /-- Accepting states predicate -/
  isAccepting : TMState → Prop
  /-- Rejecting states predicate -/
  isRejecting : TMState → Prop
  /-- Non-trivial: at least 2 states -/
  states_nontrivial : numStates ≥ 2 := by decide

/-! ## Non-Deterministic Turing Machines -/

/-- 
  Non-Deterministic Turing Machine (abstract)
  
  The key difference from DTM is that the transition relation
  allows multiple choices at each step:
  δ ⊆ Q × Γ × Q × Γ × {L, R}
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
  /-- Maximum branching factor (number of transitions per state-symbol pair) -/
  branchingFactor : Nat
  /-- Branching is non-trivial -/
  branching_positive : branchingFactor ≥ 1 := by decide

/-! ## Abstract Predicates (Placeholders) -/

/-- 
  A DTM runs in time bounded by f(n).
  
  **Semantic meaning:**
  For all inputs w of length n, M halts within f(n) steps.
  
  **Placeholder:** We use `True` as this requires full TM semantics.
-/
def runsInTime (M : DTM) (f : Nat → Nat) : Prop := True

/-- 
  A DTM decides a language L.
  
  **Semantic meaning:**
  - M halts on all inputs
  - M accepts w iff w ∈ L
  - M rejects w iff w ∉ L
  
  **Placeholder:** We use `True` as this requires full TM semantics.
-/
def decidesLanguage (M : DTM) (L : Language) : Prop := True

/-- 
  An NTM runs in nondeterministic time bounded by f(n).
  
  **Semantic meaning:**
  All computation paths halt within f(n) steps.
-/
def runsNondetInTime (N : NTM) (f : Nat → Nat) : Prop := True

/-- 
  An NTM accepts a language L (existential acceptance).
  
  **Semantic meaning:**
  - N accepts w iff SOME computation path reaches accept
  - N rejects w iff ALL computation paths reject
  
  This gives NP its characteristic "guess and verify" structure.
-/
def acceptsLanguage (N : NTM) (L : Language) : Prop := True

/-! ## Time Complexity Classes -/

/-- TIME(f(n)): languages decidable in deterministic time O(f(n)) -/
def TIME (f : Nat → Nat) : Set Language :=
  { L | ∃ M : DTM, decidesLanguage M L ∧ runsInTime M f }

/-- NTIME(f(n)): languages decidable in nondeterministic time O(f(n)) -/
def NTIME (f : Nat → Nat) : Set Language :=
  { L | ∃ N : NTM, acceptsLanguage N L ∧ runsNondetInTime N f }

/-! ## Polynomial Bounds -/

/-- Polynomial function n^k -/
def poly (k : Nat) (n : Nat) : Nat := n ^ k

/-- Exponential function 2^n -/
def exp2 (n : Nat) : Nat := 2 ^ n

/-- 
  Sub-exponential function 2^(n^ε) for ε < 1.
  
  Approximated using rational num/denom where num < denom.
  For example, 2^(n^{1/2}) would be subexp 1 2 n.
-/
def subexp (num denom : Nat) (n : Nat) : Nat :=
  if denom > 0 ∧ num < denom then
    -- Approximation: 2^(n * num / denom)
    2 ^ (n * num / denom)
  else
    2 ^ n

/-! ## Configuration (for reference) -/

/-- 
  A configuration of a Turing Machine (simplified).
  
  Full configuration would include:
  - Current state
  - Tape contents
  - Head position
-/
structure Configuration (M : DTM) where
  /-- Current state -/
  state : TMState
  /-- Tape as list of symbols -/
  tape : List TapeSymbol
  /-- Head position on tape -/
  headPos : Nat

/-- A halting configuration -/
def Configuration.isHalting (M : DTM) (c : Configuration M) : Prop :=
  M.isAccepting c.state ∨ M.isRejecting c.state

/-- An accepting configuration -/
def Configuration.isAccepting' (M : DTM) (c : Configuration M) : Prop :=
  M.isAccepting c.state

end PvsNP
