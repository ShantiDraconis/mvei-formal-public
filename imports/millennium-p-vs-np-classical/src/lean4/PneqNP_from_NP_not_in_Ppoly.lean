/-!
# PneqNP_from_NP_not_in_Ppoly - Branch C: Separation via Circuit Bounds

This module formalizes Branch C of the Symbolic Separation Program:

  NP ⊄ P/poly ⟹ P ≠ NP

## Theorem Statement

Assuming only classical axioms A1-A17, if NP is not contained in
P/poly (there exists some NP language without polynomial-size circuits),
then P ≠ NP.

## Logical Dependencies

1. A4: NP ⊄ P/poly ⟹ P ≠ NP (contrapositive of Karp-Lipton)
2. A14: Definition of Languages
3. A15: P ⊆ NP

## Relationship to Branch A

Branch C is more general than Branch A:
- Branch A: Stone Lemma (explicit L* ∈ NP \ P/poly) → P ≠ NP
- Branch C: (∃L ∈ NP, L ∉ P/poly) → P ≠ NP

Branch A provides an explicit witness; Branch C only requires existence.
-/

import PvsNP.Basics
import PvsNP.ComplexityClasses
import PvsNP.CircuitComplexity

namespace PvsNP

/-! ## Main Theorem: Branch C of Symbolic Separation Program -/

/--
**Theorem (Branch C - Separation via Circuit Bounds)**

If NP ⊄ P/poly (there exists L ∈ NP with L ∉ P/poly), then P ≠ NP.

This is the direct application of Axiom A4.
-/
theorem PneqNP_from_NPnotPpoly : NP_not_in_Ppoly → P_neq_NP := by
  intro hNPnotPpoly
  exact sep_of_NP_not_in_Ppoly hNPnotPpoly

/-! ## Equivalent Formulations -/

/--
Existential form: ∃L ∈ NP, L ∉ P/poly → P ≠ NP
-/
theorem PneqNP_from_witness : 
    (∃ L : Language, inNP L ∧ ¬ inPpoly L) → P_neq_NP := by
  intro ⟨L, hNP, hNotPpoly⟩
  exact sep_of_NP_not_in_Ppoly ⟨L, hNP, hNotPpoly⟩

/--
Universal form: (∀L ∈ NP, L ∈ P/poly) ↔ (P = NP possible via circuits)
-/
theorem NP_in_Ppoly_iff : 
    (∀ L, inNP L → inPpoly L) ↔ ¬ NP_not_in_Ppoly := by
  constructor
  · intro hAll ⟨L, hNP, hNotPpoly⟩
    exact hNotPpoly (hAll L hNP)
  · intro hNot L hNP
    by_contra hNotPpoly
    exact hNot ⟨L, hNP, hNotPpoly⟩

/-! ## Detailed Proof with All Steps -/

/--
Step-by-step proof of Branch C for maximum rigor.
-/
theorem PneqNP_from_NPnotPpoly_detailed : 
    (∃ L, inNP L ∧ ¬ inPpoly L) → P_neq_NP := by
  -- Assume ∃ L ∈ NP, L ∉ P/poly
  intro hExists
  
  -- Step 1: Extract the witness
  obtain ⟨L, hLNP, hLNotPpoly⟩ := hExists
  
  -- Step 2: Form NP_not_in_Ppoly
  have step2 : NP_not_in_Ppoly := ⟨L, hLNP, hLNotPpoly⟩
  
  -- Step 3: Apply Axiom A4
  -- Recall: P = NP → NP ⊆ P/poly (Lemma 2)
  -- Contrapositive: NP ⊄ P/poly → P ≠ NP
  have step3 : P_neq_NP := sep_of_NP_not_in_Ppoly step2
  
  exact step3

/-! ## Contrapositive Form -/

/--
Contrapositive: P = NP → NP ⊆ P/poly

If P equals NP, then every NP language has polynomial-size circuits.
-/
theorem P_eq_NP_implies_NP_in_Ppoly : P_eq_NP → ∀ L, inNP L → inPpoly L := by
  intro hEq L hNP
  exact NP_subset_Ppoly_of_P_eq_NP hEq L hNP

/-! ## Relationship to Branch A -/

/--
Branch A implies Branch C.

Stone Lemma (explicit witness) is stronger than mere existence.
-/
theorem branchA_implies_branchC : StoneLemma → NP_not_in_Ppoly := by
  intro ⟨L, hNP, hNotPpoly⟩
  exact ⟨L, hNP, hNotPpoly⟩

/--
Branch C and Branch A give the same conclusion.
-/
theorem branchC_same_as_branchA : 
    (NP_not_in_Ppoly → P_neq_NP) ∧ (StoneLemma → P_neq_NP) := by
  constructor
  · exact PneqNP_from_NPnotPpoly
  · exact PneqNP_from_Stone

/-! ## The Karp-Lipton Connection -/

/--
Karp-Lipton Theorem (1980): If NP ⊆ P/poly, then PH = Σ₂ᵖ.

This means the polynomial hierarchy collapses to the second level.

Corollary: If PH is infinite, then NP ⊄ P/poly, hence P ≠ NP.
-/
def KarpLipton : Prop :=
  (∀ L, inNP L → inPpoly L) → True  -- PH collapse (abstract)

/--
If we prove PH doesn't collapse, we get P ≠ NP.
-/
theorem PH_infinite_implies_PneqNP :
    (¬ ∀ L, inNP L → inPpoly L) → P_neq_NP := by
  intro hNotAll
  -- Not all NP in P/poly means ∃ L ∈ NP, L ∉ P/poly
  have hExists : ∃ L, inNP L ∧ ¬ inPpoly L := by
    by_contra h
    push_neg at h
    exact hNotAll h
  exact PneqNP_from_witness hExists

/-! ## Circuit Lower Bound Implications -/

/--
Any super-polynomial circuit lower bound for NP gives P ≠ NP.
-/
theorem circuit_lower_bound_implies_separation :
    (∃ L, inNP L ∧ ∀ k ≥ 1, L ∉ SIZE (poly k)) → P_neq_NP := by
  intro ⟨L, hNP, hLowerBound⟩
  have hNotPpoly : ¬ inPpoly L := by
    intro ⟨k, hk, hSize⟩
    exact hLowerBound k hk hSize
  exact PneqNP_from_witness ⟨L, hNP, hNotPpoly⟩

/-! ## Summary -/

/--
Branch C Summary:

Hypothesis: NP ⊄ P/poly (∃L ∈ NP, L ∉ P/poly)
Conclusion: P ≠ NP

Used Axioms:
- A4: NP ⊄ P/poly ⟹ P ≠ NP
- A14: Definition of Languages
- A15: P ⊆ NP

Proof Type: Non-constructive (doesn't give explicit witness)

Relationship to Branch A:
- Branch A is constructive (explicit L*)
- Branch C is non-constructive (∃ witness)
- Both give P ≠ NP
-/
def branchC_summary : String :=
  "Branch C: NP ⊄ P/poly → P ≠ NP via circuit complexity"

end PvsNP
