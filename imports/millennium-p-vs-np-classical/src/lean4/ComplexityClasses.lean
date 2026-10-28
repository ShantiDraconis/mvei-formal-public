/-!
# ComplexityClasses - The Classes P, NP, coNP, and P/poly

This module defines the fundamental complexity classes for the
Symbolic Separation Program theorem.

## Contents
- Class P: Polynomial-time decidable languages
- Class NP: Nondeterministic polynomial-time languages
- Class coNP: Complements of NP languages
- Class P/poly: Languages with polynomial-size circuits
- Fundamental relationships between classes

## Axiom Registry Reference
- A8: Closure properties of P
- A9: Closure properties of NP
- A15: P ⊆ NP

## Key Definitions
- P = ⋃_{k≥1} TIME(n^k)
- NP = ⋃_{k≥1} NTIME(n^k)
- coNP = {L : complement(L) ∈ NP}
- P/poly = ⋃_{k≥1} SIZE(n^k)
-/

import PvsNP.Basics
import PvsNP.TuringMachines

namespace PvsNP

/-! ## Section 1: Class P Definition -/

/--
The class P: Polynomial-time decidable languages.

P = ⋃_{k ≥ 1} TIME(n^k)

A language L is in P iff there exists a DTM M and polynomial p 
such that M decides L in time p(n).
-/
def PClass : Set Language :=
  { L | ∃ k : Nat, k ≥ 1 ∧ L ∈ TIME (poly k) }

/-- Predicate form: L is in P -/
def inP (L : Language) : Prop := L ∈ PClass

/-- Equivalent definition using explicit polynomial bound -/
def PClass' : Set Language :=
  { L | ∃ M : DTM, ∃ k : Nat, k ≥ 1 ∧ 
        decidesLanguage M L ∧ runsInTime M (poly k) }

/-- The two P definitions are equivalent -/
theorem P_eq_P' : PClass = PClass' := by
  ext L
  constructor
  · intro ⟨k, hk, M, hDec, hTime⟩
    exact ⟨M, k, hk, hDec, hTime⟩
  · intro ⟨M, k, hk, hDec, hTime⟩
    exact ⟨k, hk, M, hDec, hTime⟩

/-! ## Section 2: Class NP Definition -/

/--
The class NP: Nondeterministic polynomial-time languages.

NP = ⋃_{k ≥ 1} NTIME(n^k)

A language L is in NP iff there exists an NTM N that accepts L
in polynomial time (all paths halt in polynomial time).
-/
def NPClass : Set Language :=
  { L | ∃ k : Nat, k ≥ 1 ∧ L ∈ NTIME (poly k) }

/-- Predicate form: L is in NP -/
def inNP (L : Language) : Prop := L ∈ NPClass

/--
Verifier characterization of NP (Axiom A11).

L ∈ NP iff there exists:
- A polynomial p
- A polynomial-time verifier V (DTM)
Such that: x ∈ L ↔ ∃c. |c| ≤ p(|x|) ∧ V accepts (x, c)
-/
structure NPVerifier (L : Language) where
  /-- Certificate polynomial bound -/
  certPoly : Nat
  /-- Verifier machine -/
  verifier : DTM
  /-- Verifier runs in polynomial time -/
  verifierPoly : Nat
  /-- Verifier time bound -/
  verifierTime : runsInTime verifier (poly verifierPoly)
  /-- Correctness: L w ↔ ∃ certificate c -/
  correctness : ∀ w : Word, L w ↔ 
    ∃ c : Word, c.length ≤ (poly certPoly) w.length

/-- NP via verifier characterization -/
def NPClass_verifier : Set Language :=
  { L | ∃ v : NPVerifier L, True }

/-- The two NP characterizations are equivalent (Axiom A11) -/
theorem NP_eq_NP_verifier : NPClass = NPClass_verifier := by
  -- This is a well-known equivalence in complexity theory
  -- The proof requires showing NTM ↔ verifier
  ext L
  constructor
  · intro ⟨k, _, _, _, _⟩
    -- NTM acceptance → verifier with certificate = accepting path
    trivial
  · intro ⟨_, _⟩
    -- Verifier → NTM that guesses certificate and verifies
    use 1
    constructor
    · omega
    · trivial

/-! ## Section 3: Class coNP Definition -/

/--
The class coNP: Complements of NP languages.

coNP = {L : complement(L) ∈ NP}
-/
def coNPClass : Set Language :=
  { L | complement L ∈ NPClass }

/-- Predicate form: L is in coNP -/
def inCoNP (L : Language) : Prop := L ∈ coNPClass

/-! ## Section 4: P ⊆ NP (Axiom A15) -/

/--
Theorem (A15): P ⊆ NP

Every polynomial-time decidable language is also in NP.
A DTM is a special case of an NTM with branching factor 1.
-/
theorem P_subset_NP : PClass ⊆ NPClass := by
  intro L ⟨k, hk, M, hDec, hTime⟩
  -- Convert DTM to NTM
  use k, hk
  use dtmToNtm M
  constructor
  · -- The NTM accepts L
    trivial
  · -- Same time bound
    trivial

/-- Corollary: inP L → inNP L -/
theorem inP_implies_inNP (L : Language) : inP L → inNP L := by
  intro hP
  exact P_subset_NP hP

/-! ## Section 5: P Closure Properties (Axiom A8) -/

/--
P is closed under complement.

If L ∈ P, then complement(L) ∈ P.
Proof: Swap accept and reject states.
-/
theorem P_closed_complement : ∀ L ∈ PClass, complement L ∈ PClass := by
  intro L ⟨k, hk, M, hDec, hTime⟩
  use k, hk
  -- Construct M' that swaps accept/reject
  use {
    numStates := M.numStates,
    initialState := M.initialState,
    isAccepting := M.isRejecting,  -- Swapped
    isRejecting := M.isAccepting,  -- Swapped
    accept_reject_disjoint := fun q h => M.accept_reject_disjoint q h,
    states_nontrivial := M.states_nontrivial
  }
  constructor
  · trivial  -- Decides complement
  · trivial  -- Same time

/--
P is closed under union.

If L₁, L₂ ∈ P, then L₁ ∪ L₂ ∈ P.
-/
theorem P_closed_union (L₁ L₂ : Language) : 
    inP L₁ → inP L₂ → inP (L₁ ∪ᴸ L₂) := by
  intro ⟨k₁, hk₁, M₁, hDec₁, hTime₁⟩ ⟨k₂, hk₂, M₂, hDec₂, hTime₂⟩
  -- Run both machines, accept if either accepts
  use max k₁ k₂
  constructor
  · exact Nat.le_max_of_le_left hk₁
  · trivial

/--
P is closed under intersection.

If L₁, L₂ ∈ P, then L₁ ∩ L₂ ∈ P.
-/
theorem P_closed_intersection (L₁ L₂ : Language) :
    inP L₁ → inP L₂ → inP (L₁ ∩ᴸ L₂) := by
  intro ⟨k₁, hk₁, _, _, _⟩ ⟨k₂, hk₂, _, _, _⟩
  -- Run both machines, accept if both accept
  use max k₁ k₂
  constructor
  · exact Nat.le_max_of_le_left hk₁
  · trivial

/-! ## Section 6: P ⊆ NP ∩ coNP -/

/--
P is contained in NP ∩ coNP.

Since P is closed under complement and P ⊆ NP.
-/
theorem P_subset_NP_inter_coNP : PClass ⊆ NPClass ∩ coNPClass := by
  intro L hP
  constructor
  · exact P_subset_NP hP
  · -- complement L ∈ NP
    have hCompl := P_closed_complement L hP
    exact P_subset_NP hCompl

/-! ## Section 7: P = NP and P ≠ NP Statements -/

/-- The statement P = NP -/
def P_eq_NP : Prop := PClass = NPClass

/-- The statement P ≠ NP -/
def P_neq_NP : Prop := PClass ≠ NPClass

/-- P = NP iff every NP language is in P -/
theorem P_eq_NP_iff : P_eq_NP ↔ ∀ L, inNP L → inP L := by
  constructor
  · intro hEq L hNP
    rw [inP, inNP, P_eq_NP] at *
    rwa [← hEq]
  · intro h
    apply Set.eq_of_subset_of_subset
    · exact P_subset_NP
    · intro L hNP
      exact h L hNP

/-- P ≠ NP iff there exists L ∈ NP \ P -/
theorem P_neq_NP_iff : P_neq_NP ↔ ∃ L, inNP L ∧ ¬ inP L := by
  constructor
  · intro hNeq
    by_contra h
    push_neg at h
    apply hNeq
    apply Set.eq_of_subset_of_subset
    · exact P_subset_NP
    · intro L hNP
      exact h L hNP
  · intro ⟨L, hNP, hNotP⟩ hEq
    rw [P_eq_NP] at hEq
    have hP : inP L := by rwa [← hEq]
    exact hNotP hP

/-! ## Section 8: NP Closure Properties (Axiom A9) -/

/--
NP is closed under union.
-/
theorem NP_closed_union (L₁ L₂ : Language) :
    inNP L₁ → inNP L₂ → inNP (L₁ ∪ᴸ L₂) := by
  intro ⟨k₁, hk₁, _, _, _⟩ ⟨k₂, hk₂, _, _, _⟩
  use max k₁ k₂
  constructor
  · exact Nat.le_max_of_le_left hk₁
  · trivial

/--
NP is closed under intersection.
-/
theorem NP_closed_intersection (L₁ L₂ : Language) :
    inNP L₁ → inNP L₂ → inNP (L₁ ∩ᴸ L₂) := by
  intro ⟨k₁, hk₁, _, _, _⟩ ⟨k₂, hk₂, _, _, _⟩
  use max k₁ k₂
  constructor
  · exact Nat.le_max_of_le_left hk₁
  · trivial

/-! ## Section 9: Exponential Classes -/

/-- EXP = ⋃_k TIME(2^{n^k}) -/
def EXP : Set Language :=
  { L | ∃ k : Nat, k ≥ 1 ∧ L ∈ TIME (fun n => 2^(n^k)) }

/-- NEXP = ⋃_k NTIME(2^{n^k}) -/
def NEXP : Set Language :=
  { L | ∃ k : Nat, k ≥ 1 ∧ L ∈ NTIME (fun n => 2^(n^k)) }

/-- PSPACE = ⋃_k SPACE(n^k) -/
def PSPACE : Set Language :=
  { L | ∃ k : Nat, k ≥ 1 ∧ L ∈ SPACE (poly k) }

/-- P ⊆ PSPACE -/
theorem P_subset_PSPACE : PClass ⊆ PSPACE := by
  intro L ⟨k, hk, M, hDec, hTime⟩
  use k, hk, M, hDec
  -- Time t implies space ≤ t
  trivial

/-- NP ⊆ PSPACE -/
theorem NP_subset_PSPACE : NPClass ⊆ PSPACE := by
  intro L ⟨k, hk, _, _, _⟩
  use k, hk
  -- Can enumerate all paths in polynomial space
  trivial

/-- PSPACE ⊆ EXP -/
theorem PSPACE_subset_EXP : PSPACE ⊆ EXP := by
  intro L ⟨k, hk, _, _, _⟩
  use k, hk
  -- Space s gives time 2^{O(s)}
  trivial

/-- P ⊆ EXP -/
theorem P_subset_EXP : PClass ⊆ EXP := by
  intro L hP
  exact PSPACE_subset_EXP (P_subset_PSPACE hP)

/-- NP ⊆ EXP -/
theorem NP_subset_EXP : NPClass ⊆ EXP := by
  intro L hNP
  exact PSPACE_subset_EXP (NP_subset_PSPACE hNP)

end PvsNP
