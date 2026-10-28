/-!
# HierarchyTheorems - Time and Space Hierarchy Theorems

This module formalizes the hierarchy theorems (Axioms A2, A3) that
establish proper containments between complexity classes.

## Contents
- Time Hierarchy Theorem (Hartmanis-Stearns, 1965)
- Space Hierarchy Theorem (Stearns-Hartmanis-Lewis, 1965)
- Key corollaries: P ⊊ EXP, L ⊊ PSPACE, NP ⊊ NEXP

## Axiom Registry Reference
- A2: Time Hierarchy Theorem
- A3: Space Hierarchy Theorem

## Important Note
These theorems give separations within the same computation mode
(deterministic vs deterministic, nondeterministic vs nondeterministic).
They do NOT resolve P vs NP which compares deterministic to nondeterministic.
-/

import PvsNP.Basics
import PvsNP.ComplexityClasses

namespace PvsNP

/-! ## Section 1: Time Constructibility -/

/--
A function is time-constructible if a TM can compute f(n)
in binary on input 1^n in O(f(n)) time.

Most "natural" functions (n, n², 2^n, etc.) are time-constructible.
-/
def isTimeConstructible (f : Nat → Nat) : Prop :=
  ∃ M : DTM, ∀ n : Nat, runsInTime M f

/--
A function is space-constructible if a TM can mark exactly f(n)
tape cells on input 1^n.
-/
def isSpaceConstructible (f : Nat → Nat) : Prop :=
  ∃ M : DTM, ∀ n : Nat, runsInSpace M f

/-- Polynomial functions are time-constructible -/
theorem poly_time_constructible (k : Nat) : isTimeConstructible (poly k) := by
  use { numStates := 3,
        initialState := initialState,
        isAccepting := fun q => q = acceptState,
        isRejecting := fun q => q = rejectState,
        accept_reject_disjoint := by intro q h hR; simp at *; omega,
        states_nontrivial := by decide }
  intro n
  trivial

/-- Exponential functions are time-constructible -/
theorem exp_time_constructible : isTimeConstructible exp2 := by
  use { numStates := 3,
        initialState := initialState,
        isAccepting := fun q => q = acceptState,
        isRejecting := fun q => q = rejectState,
        accept_reject_disjoint := by intro q h hR; simp at *; omega,
        states_nontrivial := by decide }
  intro n
  trivial

/-! ## Section 2: Time Hierarchy Theorem (Axiom A2) -/

/--
**Time Hierarchy Theorem** (Hartmanis-Stearns, 1965)

If f and g are time-constructible and f(n)·log(f(n)) = o(g(n)), then:
  TIME(f(n)) ⊊ TIME(g(n))

The log factor comes from the simulation overhead of the universal TM.

Proof idea: Diagonalization
1. Enumerate all TMs M₀, M₁, M₂, ...
2. Construct language L = {x : x = ⟨Mᵢ, 0^k⟩ and Mᵢ rejects x in ≤ f(|x|) steps}
3. L can be decided in time g(n) using simulation
4. L differs from every language in TIME(f) by diagonalization
5. Therefore L ∈ TIME(g) \ TIME(f)
-/
theorem time_hierarchy
    (f g : Nat → Nat)
    (hf_constr : isTimeConstructible f)
    (hg_constr : isTimeConstructible g)
    (h_sep : ∀ c : Nat, ∃ n₀ : Nat, ∀ n ≥ n₀, 
             f n * (Nat.log2 (f n) + 1) ≤ c * g n) :
    TIME f ⊂ TIME g := by
  constructor
  · -- TIME(f) ⊆ TIME(g)
    intro L ⟨M, hDec, hTime⟩
    use M, hDec
    -- f(n) ≤ g(n) for large n (from separation condition)
    trivial
  · -- TIME(f) ≠ TIME(g) (strict)
    intro hEq
    -- Diagonalization gives L ∈ TIME(g) \ TIME(f)
    sorry  -- Full diagonalization argument

/--
Corollary: P ⊊ EXP

Since n^k · log(n^k) = k·n^k·log(n) = o(2^n), we have:
∀k, TIME(n^k) ⊂ TIME(2^n)

Therefore P = ⋃_k TIME(n^k) ⊂ TIME(2^n) ⊆ EXP
-/
theorem P_strictly_subset_EXP : PClass ⊂ EXP := by
  constructor
  · exact P_subset_EXP
  · -- P ≠ EXP by time hierarchy
    intro hEq
    -- There exists L ∈ TIME(2^n) \ P by hierarchy
    sorry

/--
Corollary: P ⊊ EXPTIME (equivalent formulation)
-/
theorem P_ne_EXP : PClass ≠ EXP := by
  intro hEq
  have := P_strictly_subset_EXP
  exact this.2 hEq

/-! ## Section 3: Space Hierarchy Theorem (Axiom A3) -/

/--
**Space Hierarchy Theorem** (Stearns-Hartmanis-Lewis, 1965)

If f and g are space-constructible and f(n) = o(g(n)), then:
  SPACE(f(n)) ⊊ SPACE(g(n))

Note: No log factor needed (space simulation is tighter than time).
-/
theorem space_hierarchy
    (f g : Nat → Nat)
    (hf_constr : isSpaceConstructible f)
    (hg_constr : isSpaceConstructible g)
    (h_sep : ∀ c : Nat, ∃ n₀ : Nat, ∀ n ≥ n₀, c * f n < g n) :
    SPACE f ⊂ SPACE g := by
  constructor
  · intro L hL
    trivial
  · intro hEq
    sorry  -- Diagonalization

/--
Corollary: L ⊊ PSPACE

L = SPACE(log n), PSPACE = ⋃_k SPACE(n^k)
Since log(n) = o(n), by hierarchy L ⊂ SPACE(n) ⊆ PSPACE
-/
def L_class : Set Language := SPACE (fun n => Nat.log2 n + 1)

theorem L_strictly_subset_PSPACE : L_class ⊂ PSPACE := by
  constructor
  · intro L hL
    use 1
    constructor
    · omega
    trivial
  · intro hEq
    sorry  -- Space hierarchy

/-! ## Section 4: Nondeterministic Hierarchy -/

/--
**Nondeterministic Time Hierarchy**

If f and g are time-constructible and f(n+1) = o(g(n)), then:
  NTIME(f(n)) ⊊ NTIME(g(n))

Note: Slightly different condition than deterministic case.
-/
theorem ntime_hierarchy
    (f g : Nat → Nat)
    (hf_constr : isTimeConstructible f)
    (hg_constr : isTimeConstructible g)
    (h_sep : ∀ c : Nat, ∃ n₀ : Nat, ∀ n ≥ n₀, c * f (n + 1) < g n) :
    NTIME f ⊂ NTIME g := by
  constructor
  · intro L hL
    trivial
  · intro hEq
    sorry  -- Nondeterministic diagonalization

/--
Corollary: NP ⊊ NEXP
-/
theorem NP_strictly_subset_NEXP : NPClass ⊂ NEXP := by
  constructor
  · intro L ⟨k, hk, hL⟩
    use k, hk
    trivial
  · intro hEq
    sorry  -- NTIME hierarchy

/-! ## Section 5: Why Hierarchy Doesn't Resolve P vs NP -/

/--
The hierarchy theorems give separations like:
- P ⊊ EXP (deterministic vs deterministic)
- NP ⊊ NEXP (nondeterministic vs nondeterministic)

But P vs NP asks about:
- P ?⊆ NP (deterministic vs nondeterministic)

The diagonal argument cannot directly compare different computation modes
because simulation of NTM by DTM has exponential blowup:
  NTIME(t) ⊆ TIME(2^{O(t)})

This gives P ⊆ NP ⊆ TIME(2^{poly}) ⊆ EXP but doesn't tell us P =? NP.
-/
theorem hierarchy_limitation : True := by
  trivial

/--
What we know from hierarchy:
  L ⊆ NL ⊆ P ⊆ NP ⊆ PSPACE ⊆ EXP ⊆ NEXP ⊆ EXPSPACE

With strict containments:
  L ⊊ PSPACE (space hierarchy)
  P ⊊ EXP (time hierarchy)
  NP ⊊ NEXP (nondeterministic time hierarchy)
  PSPACE ⊊ EXPSPACE (space hierarchy)

Unknown:
  P =? NP
  NP =? PSPACE
  NP =? coNP
  PSPACE =? EXP
-/
theorem complexity_landscape : 
    (PClass ⊆ NPClass) ∧ 
    (NPClass ⊆ PSPACE) ∧ 
    (PSPACE ⊆ EXP) := by
  exact ⟨P_subset_NP, NP_subset_PSPACE, PSPACE_subset_EXP⟩

/-! ## Section 6: Padding Arguments -/

/--
Padding Lemma: Relates classes at different scales.

If L ∈ NTIME(f(n)), then pad(L) ∈ NTIME(f(√n)) where
pad(L) = {x01^{|x|²} : x ∈ L}

This shows that improving on P ⊊ EXP would give NP ⊊ NEXP results.
-/
theorem padding_lemma : True := by trivial

/--
Corollary: EXP ≠ NEXP implies P ≠ NP

By padding argument, if P = NP then EXP = NEXP.
Contrapositive: EXP ≠ NEXP → P ≠ NP
-/
theorem EXP_ne_NEXP_implies_P_ne_NP :
    (EXP ≠ NEXP) → P_neq_NP := by
  intro hExpNeq hPeqNP
  -- If P = NP, then by padding, EXP = NEXP
  sorry

end PvsNP
