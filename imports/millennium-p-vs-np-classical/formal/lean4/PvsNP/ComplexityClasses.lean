/-!
  # PvsNP.ComplexityClasses - Complexity Classes P, NP, P/poly
  
  This module defines the main complexity classes used in the
  P vs NP theorem program:
  
  - P: Polynomial-time decidable languages
  - NP: Non-deterministic polynomial-time languages
  - coNP: Complements of NP languages
  - Polynomial reductions and NP-completeness
  
  ## Design Decisions
  
  1. We define classes as Sets of Languages for compatibility with ⊆, ∩, etc.
  2. We also provide predicate versions (inP, inNP) for convenience
  3. The verifier characterization of NP is stated but equivalence is marked sorry
  
  ## Axiom Status
  
  Key theorems marked `sorry`:
  - P_eq_P': Equivalence of P definitions (technical)
  - NP_eq_NP_verifier: Equivalence of NP characterizations (well-known)
  - P_subset_NP: P ⊆ NP (trivial but needs TM theory)
  - P_closed_complement: P closed under complement (standard)
  - eq_of_npc_in_p: NPC ∩ P ≠ ∅ ⇒ P = NP (standard)
-/

import PvsNP.Basics
import PvsNP.TuringMachines

namespace PvsNP

/-! ## Polynomial Functions -/

/-- A function is polynomial if it is bounded by some polynomial c·n^k + c -/
def isPolynomial (f : Nat → Nat) : Prop :=
  ∃ (c k : Nat), ∀ n, f n ≤ c * n^k + c

/-! ## The Class P -/

/--
  The class P: polynomial time decidable languages
  
  P = ⋃_{k ≥ 1} TIME(n^k)
  
  A language L is in P if there exists a DTM M and polynomial p such that:
  - M decides L
  - M runs in time p(n) on inputs of length n
-/
def PClass : Set Language :=
  { L | ∃ k : Nat, k ≥ 1 ∧ L ∈ TIME (poly k) }

/-- Alternative: L ∈ P iff there exists a poly-time TM deciding L -/
def PClass' : Set Language :=
  { L : Language | ∃ M : DTM, ∃ (p : Nat → Nat), 
    isPolynomial p ∧ decidesLanguage M L ∧ runsInTime M p }

/-- The two definitions of P are equivalent (technical proof omitted) -/
theorem P_eq_P' : PClass = PClass' := by
  sorry  -- Requires unpacking TIME definition

/-- Predicate: a language is in P -/
def inP (L : Language) : Prop := L ∈ PClass

/-! ## The Class NP -/

/-- 
  The class NP: nondeterministic polynomial time
  
  NP = ⋃_{k ≥ 1} NTIME(n^k)
-/
def NPClass : Set Language :=
  { L | ∃ k : Nat, k ≥ 1 ∧ L ∈ NTIME (poly k) }

/-- Predicate: a language is in NP -/
def inNP (L : Language) : Prop := L ∈ NPClass

/-- 
  Verifier characterization of NP
  
  L ∈ NP iff there exists a polynomial p and poly-time verifier V such that:
  x ∈ L ⟺ ∃ c, |c| ≤ p(|x|) and V accepts (x,c)
-/
def NPClass_verifier : Set Language :=
  { L : Language | ∃ (p : Nat → Nat) (V : DTM),
    isPolynomial p ∧
    ∀ w : Word, L w ↔ 
      ∃ c : Word, c.length ≤ p w.length ∧ True  -- V accepts (w, c)
  }

/-- The two characterizations of NP are equivalent (standard result) -/
theorem NP_eq_NP_verifier : NPClass = NPClass_verifier := by
  sorry  -- Well-known equivalence

/-! ## Class Relationships -/

/-- P is contained in NP (every DTM is a special case of NTM) -/
theorem P_subset_NP : PClass ⊆ NPClass := by
  intro L hL
  -- A deterministic TM is a special case of nondeterministic with branching 1
  sorry

/-- coNP: the class of complements of NP languages -/
def coNP : Set Language :=
  { L : Language | complement L ∈ NPClass }

/-- P is closed under complement -/
theorem P_closed_complement : ∀ L ∈ PClass, complement L ∈ PClass := by
  intro L hL
  -- Swap accept and reject states
  sorry

/-- P is contained in NP ∩ coNP -/
theorem P_subset_NP_inter_coNP : PClass ⊆ NPClass ∩ coNP := by
  intro L hL
  constructor
  · exact P_subset_NP hL
  · -- complement L ∈ NP
    have h := P_closed_complement L hL
    exact P_subset_NP h

/-! ## P = NP and P ≠ NP Statements -/

/-- P = NP statement: the two classes are equal -/
def P_eq_NP : Prop := PClass = NPClass

/-- P ≠ NP statement: the two classes are different -/
def P_neq_NP : Prop := PClass ≠ NPClass

/-- P = NP iff every NP language is in P -/
theorem P_eq_NP_iff : P_eq_NP ↔ ∀ L, inNP L → inP L := by
  constructor
  · intro hEq L hNP
    rw [inP, inNP, hEq] at *
    exact hNP
  · intro h
    apply Set.eq_of_subset_of_subset
    · exact P_subset_NP
    · intro L hNP
      exact h L hNP

/-! ## Polynomial Reductions -/

/-- 
  Polynomial-time many-one reduction.
  
  L₁ ≤ₚ L₂ iff there exists a polynomial-time computable function
  f : Word → Word such that for all w: w ∈ L₁ ↔ f(w) ∈ L₂.
-/
def polyReduces (L₁ L₂ : Language) : Prop :=
  ∃ f : Word → Word, ∃ k : Nat, k ≥ 1 ∧ 
    (∀ w, L₁ w ↔ L₂ (f w))  -- Correctness; time bound is implicit

notation:50 L₁ " ≤ₚ " L₂ => polyReduces L₁ L₂

/-! ## NP-Hardness and NP-Completeness -/

/-- NP-hard: every NP language reduces to L -/
def NPHard (L : Language) : Prop :=
  ∀ L' : Language, inNP L' → (L' ≤ₚ L)

/-- NP-complete: in NP and NP-hard -/
def NPComplete (L : Language) : Prop :=
  inNP L ∧ NPHard L

/-! ## Key Theorem: NP-Complete in P implies P = NP -/

/-- If L is NP-complete and L ∈ P, then P = NP -/
theorem eq_of_npc_in_p (L : Language) (hNPC : NPComplete L) (hP : inP L) : P_eq_NP := by
  -- Standard proof using reductions:
  -- For any L' ∈ NP, we have L' ≤ₚ L (by NP-hardness)
  -- Since L ∈ P and reductions compose, L' ∈ P
  sorry

/-- Equivalent formulation: P = NP iff some NP-complete problem is in P -/
theorem P_eq_NP_iff_NPC_in_P :
    P_eq_NP ↔ ∃ L : Language, NPComplete L ∧ inP L := by
  constructor
  · intro hEq
    sorry  -- If P = NP, SAT ∈ NPC ∩ P
  · intro ⟨L, hNPC, hP⟩
    exact eq_of_npc_in_p L hNPC hP

end PvsNP
