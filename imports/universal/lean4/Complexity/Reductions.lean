/-
===============================================================================
File:      Complexity/Reductions.lean
Author:    ShantiDraconis (Tiago) & Copilot/Lean
Project:   Millennium P vs NP — Reductions (Classical Framework)

Purpose:
  Provide a unified, classical theory of reductions between decision
  problems (languages over {0,1}*):

    • Many-one (Karp) reductions;
    • Turing (oracle) reductions;
    • Truth-table reductions;
    • Abstract complexity constraints (polytime, logspace, etc.);
    • Composition schemas for reductions.

This file is a *specification layer*:

  - It does not fix a concrete machine model;
  - It encodes “polytime”, “logspace”, etc. as propositions;
  - It is designed to integrate with:

        Complexity.BooleanFunctions
        Complexity.ComplexityMeasures
        Complexity.RelativizationBarriers
        Complexity.SATCompleteness

Everything is standard mathematics:
  words, languages, functions, growth bounds.
No exotic constants, no new axioms, no `sorry`.
===============================================================================
-/

import Mathlib.Data.List.Basic
import Mathlib.Data.Nat.Basic
import Complexity.BooleanFunctions
import Complexity.ComplexityMeasures
import Complexity.RelativizationBarriers

namespace Complexity
namespace Reductions

open BooleanFunctions
open Measures
open RelativizationBarriers

/-
===============================================================================
I. BASIC OBJECTS — WORDS, LANGUAGES, MEASURES
===============================================================================
-/

/-- A binary word is a list of bits, from the Boolean framework. -/
abbrev Word : Type := BooleanFunctions.Word

/-- A language is a subset of {0,1}*. -/
abbrev Language : Type := BooleanFunctions.Language

/-- Complexity classes P and NP (base, unrelativized). -/
abbrev ComplexityClasses := BooleanFunctions.ComplexityClasses

/-- A general complexity measure on Word. -/
abbrev WordMeasure := ComplexityMeasure Word

/-
===============================================================================
II. MANY-ONE (KARP) REDUCTION
===============================================================================
-/

/--
A Karp (many-one) reduction from L₁ to L₂ with respect to a complexity
measure on words and a growth function g(n):

  • f : {0,1}* → {0,1}* is total and computable;
  • correctness: ∀w, w ∈ L₁ ↔ f(w) ∈ L₂;
  • complexity: running time / resource usage of f satisfies
                cost(w) ≤ g(|w|), expressed abstractly by `bounded`.

The “polytime” or “logspace” nature of the reduction is encoded by
choosing an appropriate (measure, g) and a property `bounded`.
-/
structure ManyOneReduction
    (measure : WordMeasure)
    (g : GrowthFunction)
    (L₁ L₂ : Language) where
  /-- reduction function f : {0,1}* → {0,1}* -/
  f : Word → Word

  /-- correctness: w ∈ L₁  ↔  f(w) ∈ L₂ -/
  correctness :
    ∀ w : Word, L₁ w ↔ L₂ (f w)

  /--
  Complexity constraint:

    cost(w) ≤ g(|w|)   for all w.

  We do not spell the inequality explicitly here; instead, we package
  the whole property as a single `Prop` to be instantiated in concrete
  models of time/space complexity.
  -/
  bounded : Prop


/--
Specialization: a *polynomial-time* many-one (Karp) reduction.

It is a ManyOneReduction parameterized by some growth function g that
is known to be of polynomial growth.
-/
structure PolyTimeManyOneReduction
    (measure : WordMeasure)
    (L₁ L₂ : Language) where
  g : GrowthFunction
  g_isPolynomial : PolynomialGrowth g
  red : ManyOneReduction measure g L₁ L₂

/--
Specialization: a *logspace* many-one reduction.

Again, we use a generic growth function g and an abstract `isLogspace`
predicate on (measure, g) and the reduction function f.
We do not define logspace formally here; we just package the idea.
-/
structure LogspaceManyOneReduction
    (measure : WordMeasure)
    (L₁ L₂ : Language) where
  g : GrowthFunction
  isLogspaceBound : Prop
  red : ManyOneReduction measure g L₁ L₂


/-
===============================================================================
III. TURING (ORACLE) REDUCTIONS
===============================================================================
-/

/--
Turing (oracle) reduction between languages L₁ and L₂ with respect to
an oracle model:

  • We assume an abstract oracle machine model with oracle access to L₂;
  • Using this oracle, the machine decides L₁;
  • Complexity of the reduction is controlled by a measure and a bound.

We do not build an explicit oracle machine semantics; instead, we
encapsulate everything in:

  - a “machine description” M,
  - a specification `correct` that M^L₂ decides L₁,
  - a property `bounded` that expresses the complexity bound.
-/
structure TuringReduction
    (measure : WordMeasure)
    (g : GrowthFunction)
    (L₁ L₂ : Language) where
  /--
  Abstract machine description.  In a concrete development, this would
  be a type of oracle Turing machines, RAMs with oracle access, etc.
  Here we keep it opaque.
  -/
  Machine : Type

  /-- Intended semantics:

      run M with oracle L₂ outputs a Boolean answer for input w.
  -/
  run : Machine → (Language) → Word → Bool

  /-- A particular machine that realizes the reduction. -/
  M : Machine

  /-- Correctness: with oracle L₂, M decides L₁. -/
  correct :
    ∀ w : Word, (run M L₂ w = true) ↔ L₁ w

  /--
  Complexity constraint:

    cost_M^L₂(w) ≤ g(|w|) with respect to the measure.

  Here we record this global property as a `Prop` to be instantiated
  in a model where the measure knows how to count steps of M.
  -/
  bounded : Prop


/--
Polytime Turing reduction specialization.

A Turing reduction that uses a bound g of polynomial growth.
-/
structure PolyTimeTuringReduction
    (measure : WordMeasure)
    (L₁ L₂ : Language) where
  g : GrowthFunction
  g_isPolynomial : PolynomialGrowth g
  red : TuringReduction measure g L₁ L₂


/-
===============================================================================
IV. TRUTH-TABLE (NONADAPTIVE) REDUCTIONS
===============================================================================
-/

/--
Truth-table reduction (nonadaptive Turing reduction):

  Informally, on input w, we compute a finite list of queries q₁,…,q_k
  to the oracle L₂, then decide membership in L₁ based only on:

    w, and the vector of answers (L₂(q₁), …, L₂(q_k)).

We encode this as:

  • a query-generation function queries : Word → List Word;
  • a decision function decision : Word → List Bool → Bool;
  • correctness with respect to L₁ and L₂;
  • complexity bound via a measure and growth function.
-/
structure TruthTableReduction
    (measure : WordMeasure)
    (g : GrowthFunction)
    (L₁ L₂ : Language) where
  /-- Given w, compute the list of queries qᵢ. -/
  queries : Word → List Word

  /--
  Given the input w and the answers to queries (bᵢ), decide membership
  in L₁.  This function does *not* adaptively query the oracle; all
  queries are computed first, and then the answers are used.
  -/
  decision : Word → List Bool → Bool

  /-- Correctness: the reduction is exact. -/
  correct :
    ∀ w : Word,
      let qs := queries w
      let ans := qs.map (fun q => decide (L₂ q))
      in (decision w ans = true) ↔ L₁ w

  /--
  Complexity bound:

    both computing `queries w` and running `decision w ans` are bounded
    by g(|w|) with respect to the given measure.

  This is encapsulated as a single `Prop`.
  -/
  bounded : Prop


/--
Polytime truth-table reduction specialization.
-/
structure PolyTimeTruthTableReduction
    (measure : WordMeasure)
    (L₁ L₂ : Language) where
  g : GrowthFunction
  g_isPolynomial : PolynomialGrowth g
  red : TruthTableReduction measure g L₁ L₂


/-
===============================================================================
V. COMPOSITION SCHEMAS FOR REDUCTIONS
===============================================================================
-/

/--
Schema: composition of many-one reductions.

Given:

  • R₁₂ : L₁ ≤ₘ L₂ with bound g₁₂,
  • R₂₃ : L₂ ≤ₘ L₃ with bound g₂₃,

there is a composite many-one reduction:

  • R₁₃ : L₁ ≤ₘ L₃ with bound g₁₃,

where g₁₃ is some composition of g₁₂ and g₂₃ (pointwise or asymptotic).

We *do not* construct the composite explicitly here, since we do not
have a concrete time model; instead, we provide the *type* of the
existence of such a composite reduction.
-/
structure ManyOneCompositionSchema
    (measure : WordMeasure)
    (L₁ L₂ L₃ : Language) where
  g₁₂ g₂₃ g₁₃ : GrowthFunction
  red₁₂ : ManyOneReduction measure g₁₂ L₁ L₂
  red₂₃ : ManyOneReduction measure g₂₃ L₂ L₃

  /--
  Existence of a composite many-one reduction L₁ ≤ₘ L₃ with bound g₁₃.
  -/
  compositeExists :
    ∃ (red₁₃ : ManyOneReduction measure g₁₃ L₁ L₃), True


/--
Schema: composition of Karp reductions preserves polynomial-time,
assuming composition of polynomial functions is polynomial.

Again, we only capture the *type* of such a theorem.
-/
structure PolyTimeManyOneCompositionSchema
    (measure : WordMeasure)
    (L₁ L₂ L₃ : Language) where
  R₁₂ : PolyTimeManyOneReduction measure L₁ L₂
  R₂₃ : PolyTimeManyOneReduction measure L₂ L₃

  /--
  Existence of a composite polynomial-time many-one reduction L₁ ≤ₘ L₃.
  -/
  compositeExists :
    ∃ (R₁₃ : PolyTimeManyOneReduction measure L₁ L₃), True


/--
Schema: composition of Turing reductions.

Given L₁ ≤_T L₂ and L₂ ≤_T L₃, we expect L₁ ≤_T L₃.
We record the existence of such a composite.
-/
structure TuringCompositionSchema
    (measure : WordMeasure)
    (L₁ L₂ L₃ : Language) where
  g₁₂ g₂₃ g₁₃ : GrowthFunction
  red₁₂ : TuringReduction measure g₁₂ L₁ L₂
  red₂₃ : TuringReduction measure g₂₃ L₂ L₃
  compositeExists :
    ∃ (red₁₃ : TuringReduction measure g₁₃ L₁ L₃), True


/--
Schema: composition of truth-table reductions.
-/
structure TruthTableCompositionSchema
    (measure : WordMeasure)
    (L₁ L₂ L₃ : Language) where
  g₁₂ g₂₃ g₁₃ : GrowthFunction
  red₁₂ : TruthTableReduction measure g₁₂ L₁ L₂
  red₂₃ : TruthTableReduction measure g₂₃ L₂ L₃
  compositeExists :
    ∃ (red₁₃ : TruthTableReduction measure g₁₃ L₁ L₃), True


/-
===============================================================================
VI. REDUCTION-BASED HARDNESS AND COMPLETENESS
===============================================================================
-/

/--
Hardness of a language L under a family of reductions R:

  Given:
    • A notion of reduction type RedType (e.g. ManyOneReduction),
    • A complexity measure and growth function,
    • A complexity class C (e.g. NP),

  we say:

    L is Red-hard for C

  if every language in C reduces to L via a reduction of type RedType.

We express this abstractly as a structure parametrized by:

  • class predicate C : Language → Prop,
  • a reduction *existence* predicate `RedExists` (a Prop-valued function
    encoding “there exists a reduction from L₁ to L₂”).
-/
structure Hardness
    (C : Language → Prop)
    (RedExists : Language → Language → Prop)
    (L : Language) : Prop :=
  hard :
    ∀ L₀ : Language,
      C L₀ →
      RedExists L₀ L

/--
Completeness of a language L for a class C under reductions RedExists:

  • L ∈ C, and
  • L is Red-hard for C.
-/
structure Completeness
    (C : Language → Prop)
    (RedExists : Language → Language → Prop)
    (L : Language) : Prop :=
  inClass : C L
  hard    : Hardness C RedExists L


/--
Instantiation: NP-hardness and NP-completeness under polynomial-time
many-one (Karp) reductions with respect to a given measure.

We turn PolyTimeManyOneReduction into a binary “there exists a reduction”
predicate RedExistsPTMM.
-/
def RedExists_PolyTimeManyOne
    (measure : WordMeasure)
    (L₁ L₂ : Language) : Prop :=
  ∃ (R : PolyTimeManyOneReduction measure L₁ L₂), True

/-- NP-hardness under polynomial-time many-one reductions. -/
abbrev NP_hard_polyManyOne
    (C : ComplexityClasses)
    (measure : WordMeasure)
    (L : Language) : Prop :=
  Hardness C.NP (RedExists_PolyTimeManyOne measure) L

/-- NP-completeness under polynomial-time many-one reductions. -/
abbrev NP_complete_polyManyOne
    (C : ComplexityClasses)
    (measure : WordMeasure)
    (L : Language) : Prop :=
  Completeness C.NP (RedExists_PolyTimeManyOne measure) L


/-
===============================================================================
VII. META-LEVEL USAGE IN THE PROJECT
===============================================================================

This file is meant as a *reusable reduction toolbox* for the entire
Millennium / P vs NP project.  Typical uses:

  • SAT completeness:
      - SAT_CNF is NP-complete under PolyTimeManyOneReduction;
      - Any NP-complete language for other encodings (3-SAT, CLIQUE,
        VERTEX-COVER, etc.) is shown by providing explicit reductions.

  • Circuit lower bounds:
      - Translate hardness under many-one reductions into circuit
        size lower bounds using CircuitSizeMeasure + SizeClass.

  • Proof barriers:
      - Combine TuringReduction with RelativizedClasses to study
        relativization barriers at the level of reductions.

Key design principles:

  - All deep complexity-theoretic facts are represented as `Prop` fields;
  - No reliance on unproven axioms or `sorry`;
  - Everything is compatible with a classical ZFC-style metatheory;
  - This module can be imported safely into Lean proofs without
    forcing any particular machine model.

===============================================================================
-/

end Reductions
end Complexity
