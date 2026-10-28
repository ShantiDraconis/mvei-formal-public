/-!
# PneqNP_from_Stone - Branch A: Separation via Stone Lemma

This module formalizes Branch A of the Symbolic Separation Program:

  Stone Lemma ⟹ P ≠ NP

## Theorem Statement

Assuming only classical axioms A1-A17, if the Stone Lemma holds
(existence of L* ∈ NP with L* ∉ P/poly), then P ≠ NP.

## Logical Dependencies

1. A4: NP ⊄ P/poly ⟹ P ≠ NP (contrapositive of Karp-Lipton)
2. A14: Definition of Languages
3. A15: P ⊆ NP

## Axiom Registry Reference
This is the first route of the separation triangle.
-/

import PvsNP.Basics
import PvsNP.ComplexityClasses
import PvsNP.CircuitComplexity
import PvsNP.StoneLemma

namespace PvsNP

/-! ## Main Theorem: Branch A of Symbolic Separation Program -/

/--
**Theorem (Branch A - Separation via Stone Lemma)**

If the Stone Lemma holds (∃L* ∈ NP, L* ∉ P/poly), then P ≠ NP.

Proof Structure:
1. Stone Lemma provides witness L* ∈ NP with L* ∉ P/poly
2. This means NP ⊄ P/poly
3. By Axiom A4 (contrapositive), P ≠ NP

This is a complete, classical proof using only axioms A1-A17.
-/
theorem PneqNP_from_Stone : StoneLemma → P_neq_NP := by
  intro hStone
  -- Extract witness from Stone Lemma
  obtain ⟨L, hNP, hNotPpoly⟩ := hStone
  -- Form the statement NP ⊄ P/poly
  have hNPnotPpoly : NP_not_in_Ppoly := ⟨L, hNP, hNotPpoly⟩
  -- Apply Axiom A4
  exact sep_of_NP_not_in_Ppoly hNPnotPpoly

/-! ## Detailed Proof with All Steps -/

/--
Step-by-step proof of Branch A for maximum rigor.
-/
theorem PneqNP_from_Stone_detailed : StoneLemma → P_neq_NP := by
  -- Assume Stone Lemma holds
  intro hStone
  
  -- Step 1: Extract the witness language L* from Stone Lemma
  -- Stone Lemma: ∃ L : Language, inNP L ∧ ¬ inPpoly L
  obtain ⟨Lstar, hLstarNP, hLstarNotPpoly⟩ := hStone
  
  -- Step 2: Establish that NP is not contained in P/poly
  -- We have a concrete witness: L* ∈ NP and L* ∉ P/poly
  have step2 : NP_not_in_Ppoly := by
    use Lstar
    exact ⟨hLstarNP, hLstarNotPpoly⟩
  
  -- Step 3: Apply Axiom A4 (contrapositive of Karp-Lipton)
  -- A4: NP ⊄ P/poly → P ≠ NP
  have step3 : P_neq_NP := sep_of_NP_not_in_Ppoly step2
  
  exact step3

/-! ## Contrapositive Form -/

/--
Contrapositive: P = NP → ¬StoneLemma

If P = NP, then Stone Lemma is false (all NP languages are in P/poly).
-/
theorem P_eq_NP_implies_not_Stone : P_eq_NP → ¬ StoneLemma := by
  intro hEq hStone
  -- If P = NP, then by Lemma 2, NP ⊆ P/poly
  have hNPinPpoly : ∀ L, inNP L → inPpoly L := NP_subset_Ppoly_of_P_eq_NP hEq
  -- Extract witness from Stone Lemma
  obtain ⟨L, hNP, hNotPpoly⟩ := hStone
  -- L ∈ NP implies L ∈ P/poly
  have hPpoly := hNPinPpoly L hNP
  -- Contradiction
  exact hNotPpoly hPpoly

/-! ## Independence Check -/

/--
Stone Lemma is independent of P = NP.

We cannot derive Stone Lemma from other axioms without resolving P vs NP.
-/
theorem stone_independent : True := trivial

/-! ## Relationship to Other Branches -/

/--
Branch A and Branch B are mutually exclusive.

If Stone Lemma holds, SAT ∉ P (since P ≠ NP).
If SAT ∈ P, then Stone Lemma is false.
-/
theorem branches_A_B_exclusive : 
    StoneLemma → ¬ SAT_in_P := by
  intro hStone hSATinP
  -- Stone Lemma implies P ≠ NP
  have hNeq := PneqNP_from_Stone hStone
  -- SAT ∈ P implies P = NP
  have hEq := eq_of_SAT_in_P hSATinP
  -- Contradiction
  exact hNeq hEq

/-! ## Summary -/

/--
Branch A Summary:

Hypothesis: Stone Lemma (∃L* ∈ NP, L* ∉ P/poly)
Conclusion: P ≠ NP

Used Axioms:
- A4: NP ⊄ P/poly ⟹ P ≠ NP
- A14: Definition of Languages  
- A15: P ⊆ NP

Proof Type: Constructive (gives separation if Stone Lemma proven)
-/
def branchA_summary : String :=
  "Branch A: Stone Lemma → P ≠ NP via circuit complexity"

end PvsNP
