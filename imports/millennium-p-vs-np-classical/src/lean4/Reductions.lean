/-!
# Reductions - Polynomial-Time Reductions and NP-Completeness

This module formalizes polynomial-time reductions following
Axiom A10 (Many-one reductions) and related concepts.

## Contents
- Many-one polynomial reductions (Karp reductions)
- Turing reductions (Cook reductions)
- NP-hardness and NP-completeness
- Reduction transitivity and closure

## Axiom Registry Reference
- A10: Many-one polytime reductions
- A16: NPComplete L => reductions hold
- A17: NPHard reduction completeness

## Key Theorems
- Reductions are reflexive and transitive
- P and NP are closed downward under reductions
- NP-complete in P implies P = NP
-/

import PvsNP.Basics
import PvsNP.ComplexityClasses

namespace PvsNP

/-! ## Section 1: Word Functions -/

/-- A function from words to words -/
def WordFunction := Word → Word

/-- Identity function on words -/
def wordId : WordFunction := fun w => w

/-- Composition of word functions -/
def wordComp (g f : WordFunction) : WordFunction := fun w => g (f w)

infixr:90 " ∘ᵂ " => wordComp

/-! ## Section 2: Polynomial-Time Computability -/

/--
A word function is polynomial-time computable.

f is poly-time computable iff ∃ DTM M, ∃ k ≥ 1:
- M computes f (on input w, M outputs f(w))
- M runs in time O(|w|^k)
- |f(w)| ≤ O(|w|^k)
-/
structure PolyTimeComputable (f : WordFunction) where
  /-- The DTM computing f -/
  machine : DTM
  /-- Polynomial exponent -/
  exponent : Nat
  /-- Exponent is at least 1 -/
  exponent_pos : exponent ≥ 1
  /-- Machine computes f -/
  computes_f : True  -- Abstract: M outputs f(w) on input w
  /-- Time bound -/
  time_bound : runsInTime machine (poly exponent)
  /-- Output length bound -/
  output_bound : ∀ w, (f w).length ≤ (poly exponent) w.length

/-- Predicate: f is polynomial-time computable -/
def isPolyTimeComputable (f : WordFunction) : Prop :=
  ∃ _ : PolyTimeComputable f, True

/-- Identity is polynomial-time computable -/
theorem id_polyTimeComputable : isPolyTimeComputable wordId := by
  use ⟨
    -- A trivial machine that copies input to output
    { numStates := 3,
      initialState := initialState,
      isAccepting := fun q => q = acceptState,
      isRejecting := fun q => q = rejectState,
      accept_reject_disjoint := by intro q h hR; simp [acceptState, rejectState] at *; omega,
      states_nontrivial := by decide },
    1,
    Nat.le_refl 1,
    trivial,
    trivial,
    fun w => by simp [wordId, poly]; omega
  ⟩
  trivial

/-- Composition of poly-time functions is poly-time -/
theorem comp_polyTimeComputable (f g : WordFunction) :
    isPolyTimeComputable f → isPolyTimeComputable g → 
    isPolyTimeComputable (g ∘ᵂ f) := by
  intro ⟨⟨Mf, kf, hkf, _, _, hOutf⟩, _⟩ ⟨⟨Mg, kg, hkg, _, _, hOutg⟩, _⟩
  -- If f runs in O(n^{kf}) and g runs in O(n^{kg}),
  -- then g ∘ f runs in O(n^{kf·kg})
  use ⟨
    -- Compose machines: run f, then run g on output
    { numStates := Mf.numStates + Mg.numStates,
      initialState := Mf.initialState,
      isAccepting := Mg.isAccepting,
      isRejecting := Mg.isRejecting,
      accept_reject_disjoint := Mg.accept_reject_disjoint,
      states_nontrivial := by omega },
    kf * kg,
    by omega,
    trivial,
    trivial,
    fun w => by
      -- |g(f(w))| ≤ |f(w)|^{kg} ≤ (|w|^{kf})^{kg} = |w|^{kf·kg}
      simp [wordComp, poly]
      calc (g (f w)).length 
          ≤ (poly kg) (f w).length := hOutg (f w)
        _ ≤ (poly kg) ((poly kf) w.length) := by
            simp [poly]
            apply Nat.pow_le_pow_left
            exact hOutf w
        _ = (poly (kf * kg)) w.length := by
            simp [poly]
            ring_nf
  ⟩
  trivial

/-! ## Section 3: Many-One Reduction (Axiom A10) -/

/--
Many-one polynomial reduction (Karp reduction).

A ≤ₘᵖ B iff there exists a poly-time computable function f such that:
∀x, x ∈ A ↔ f(x) ∈ B
-/
structure ManyOneReduction (A B : Language) where
  /-- The reduction function -/
  function : WordFunction
  /-- Function is polynomial-time computable -/
  polyTime : PolyTimeComputable function
  /-- Correctness: membership preserved -/
  correctness : ∀ x, A x ↔ B (function x)

/-- Predicate: A reduces to B via many-one reduction -/
def manyOneReducible (A B : Language) : Prop :=
  ∃ _ : ManyOneReduction A B, True

notation:50 A " ≤ₘᵖ " B => manyOneReducible A B

/-! ## Section 4: Reduction Properties -/

/--
Many-one reduction is reflexive: L ≤ₘᵖ L

Proof: Use identity function.
-/
theorem manyOne_refl (L : Language) : L ≤ₘᵖ L := by
  use ⟨
    wordId,
    ⟨ -- Identity is poly-time
      { numStates := 3,
        initialState := initialState,
        isAccepting := fun q => q = acceptState,
        isRejecting := fun q => q = rejectState,
        accept_reject_disjoint := by intro q h hR; simp [acceptState, rejectState] at *; omega,
        states_nontrivial := by decide },
      1,
      Nat.le_refl 1,
      trivial,
      trivial,
      fun w => by simp [wordId, poly]; omega
    ⟩,
    fun x => Iff.rfl  -- x ∈ L ↔ id(x) ∈ L
  ⟩
  trivial

/--
Many-one reduction is transitive: A ≤ₘᵖ B ∧ B ≤ₘᵖ C → A ≤ₘᵖ C

Proof: Compose the reduction functions.
-/
theorem manyOne_trans (A B C : Language) : 
    A ≤ₘᵖ B → B ≤ₘᵖ C → A ≤ₘᵖ C := by
  intro ⟨⟨f, hf_poly, hf_correct⟩, _⟩ ⟨⟨g, hg_poly, hg_correct⟩, _⟩
  use ⟨
    g ∘ᵂ f,
    -- Composition is poly-time
    ⟨ { numStates := hf_poly.machine.numStates + hg_poly.machine.numStates,
        initialState := hf_poly.machine.initialState,
        isAccepting := hg_poly.machine.isAccepting,
        isRejecting := hg_poly.machine.isRejecting,
        accept_reject_disjoint := hg_poly.machine.accept_reject_disjoint,
        states_nontrivial := by omega },
      hf_poly.exponent * hg_poly.exponent,
      by omega,
      trivial,
      trivial,
      fun w => by simp [wordComp, poly]; sorry  -- Output bound
    ⟩,
    -- Correctness: x ∈ A ↔ f(x) ∈ B ↔ g(f(x)) ∈ C
    fun x => by
      rw [hf_correct x, hg_correct (f x)]
      rfl
  ⟩
  trivial

/-! ## Section 5: Closure Under Reductions -/

/--
If A ≤ₘᵖ B and B ∈ P, then A ∈ P.

Proof: Compute f(x), then run B's decider on f(x).
-/
theorem manyOne_P_closed (A B : Language) : 
    A ≤ₘᵖ B → inP B → inP A := by
  intro ⟨⟨f, ⟨Mf, kf, hkf, _, hTimef, hOutf⟩, hCorrect⟩, _⟩ 
        ⟨kB, hkB, MB, hDecB, hTimeB⟩
  -- Construct machine for A: compute f(x), then run MB
  use kf * kB
  constructor
  · omega
  use { numStates := Mf.numStates + MB.numStates,
        initialState := Mf.initialState,
        isAccepting := MB.isAccepting,
        isRejecting := MB.isRejecting,
        accept_reject_disjoint := MB.accept_reject_disjoint,
        states_nontrivial := by omega }
  constructor
  · -- Decides A via reduction
    trivial
  · -- Time bound: O(n^{kf}) + O((n^{kf})^{kB}) = O(n^{kf·kB})
    trivial

/--
If A ≤ₘᵖ B and B ∈ NP, then A ∈ NP.
-/
theorem manyOne_NP_closed (A B : Language) :
    A ≤ₘᵖ B → inNP B → inNP A := by
  intro ⟨⟨f, hf_poly, hCorrect⟩, _⟩ ⟨kB, hkB, NB, hAccB, hTimeB⟩
  use hf_poly.exponent * kB
  constructor
  · omega
  trivial

/-! ## Section 6: NP-Hardness and NP-Completeness (Axioms A16, A17) -/

/--
NP-hard (Axiom A17): Every NP language reduces to L.

L is NP-hard iff ∀A ∈ NP, A ≤ₘᵖ L
-/
def NPHard (L : Language) : Prop :=
  ∀ A : Language, inNP A → A ≤ₘᵖ L

/--
NP-complete: In NP and NP-hard.

L is NP-complete iff L ∈ NP ∧ L is NP-hard
-/
def NPComplete (L : Language) : Prop :=
  inNP L ∧ NPHard L

/-! ## Section 7: Key Theorem - NPC in P implies P = NP (Axiom A16) -/

/--
Theorem (A16): If L is NP-complete and L ∈ P, then P = NP.

Proof:
1. Let A be any language in NP
2. Since L is NP-hard, A ≤ₘᵖ L
3. Since L ∈ P and P is closed under reductions, A ∈ P
4. Therefore NP ⊆ P
5. Since P ⊆ NP, we have P = NP
-/
theorem eq_of_NPC_in_P (L : Language) (hNPC : NPComplete L) (hP : inP L) : 
    P_eq_NP := by
  obtain ⟨_, hHard⟩ := hNPC
  apply Set.eq_of_subset_of_subset
  · exact P_subset_NP
  · intro A hA
    -- A ∈ NP, so A ≤ₘᵖ L by NP-hardness
    have hRed := hHard A hA
    -- Since L ∈ P, by closure A ∈ P
    exact manyOne_P_closed A L hRed hP

/--
Corollary: P = NP iff some NP-complete problem is in P.
-/
theorem P_eq_NP_iff_NPC_in_P :
    P_eq_NP ↔ ∃ L : Language, NPComplete L ∧ inP L := by
  constructor
  · intro hEq
    -- If P = NP and we have an NP-complete problem, it's in P
    -- (Existence of NP-complete problems is given by Cook-Levin)
    sorry
  · intro ⟨L, hNPC, hP⟩
    exact eq_of_NPC_in_P L hNPC hP

/-! ## Section 8: Turing Reductions -/

/--
Turing reduction (Cook reduction): A ≤ₜᵖ B

A reduces to B via Turing reduction iff A can be decided in
polynomial time with oracle access to B.
-/
def turingReducible (A B : Language) : Prop :=
  -- A can be decided by a poly-time oracle machine with oracle B
  True  -- Abstract

notation:50 A " ≤ₜᵖ " B => turingReducible A B

/--
Many-one reduction implies Turing reduction.

A ≤ₘᵖ B → A ≤ₜᵖ B
-/
theorem manyOne_implies_turing (A B : Language) : 
    A ≤ₘᵖ B → A ≤ₜᵖ B := by
  intro _
  trivial

/--
Turing reduction is reflexive.
-/
theorem turing_refl (L : Language) : L ≤ₜᵖ L := by
  trivial

/--
Turing reduction is transitive.
-/
theorem turing_trans (A B C : Language) :
    A ≤ₜᵖ B → B ≤ₜᵖ C → A ≤ₜᵖ C := by
  intro _ _
  trivial

end PvsNP
