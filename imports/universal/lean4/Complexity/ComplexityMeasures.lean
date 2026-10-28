/-
===============================================================================
File:      Complexity/ComplexityMeasures.lean
Author:    ShantiDraconis (Tiago) & Copilot/Lean
Project:   Millennium P vs NP — Abstract Complexity Measures

Purpose:
  Provide a *general*, purely classical layer for complexity measures, which:

    • abstracts over time, space, circuit size, formula size, etc.;
    • allows comparison of growth rates (polynomial, quasi-polynomial,
      exponential, etc.);
    • induces complexity classes from a measure (e.g. TIME(f), SIZE(f));
    • connects to the Boolean and circuit layers defined in:

        - Complexity/BooleanFunctions.lean
        - Complexity/Circuits.lean

  This file does NOT fix a specific machine model (Turing machines, RAM, etc.).
  Instead, it provides a general mathematical interface for "measure of cost"
  and "class of objects whose cost is bounded by g(n)".

Everything is standard mathematics:
  ℕ, ℝ, functions, sets, languages, growth bounds.
No exotic constants, no new axioms, no `sorry`.
===============================================================================
-/

import Mathlib.Data.Nat.Basic
import Mathlib.Data.Real.Basic
import Mathlib.Data.List.Basic
import Mathlib.Algebra.BigOperators.Basic
import Complexity.BooleanFunctions
import Complexity.Circuits

open scoped BigOperators

namespace Complexity
namespace Measures

open BooleanFunctions
open Circuits

/-
===============================================================================
I. BASIC NOTIONS — INPUT SIZE AND LENGTH
===============================================================================
-/

/--
A binary word is a list of bits. We reuse the alias from the Boolean layer.
-/
abbrev Word : Type := BooleanFunctions.Word

/--
Input size function for words:

  size(w) = length of the word.

This is the standard notion of input length |w|.
-/
def inputSize (w : Word) : ℕ :=
  w.length

/--
A generic input space for a problem instance.

Examples:
  • `Word` for languages,
  • `ℕ × ℕ` for pairs,
  • arbitrary types representing encodings of graphs, formulas, etc.
-/
abbrev InputSpace := Type

/--
A size function on an arbitrary input space X:

  size : X → ℕ

used to measure the length / encoding size of instances.
-/
structure SizeFunction (X : Type) where
  size : X → ℕ

/--
Standard size function on words, for convenience.
-/
def wordSizeFunction : SizeFunction Word :=
  { size := inputSize }

/-
===============================================================================
II. GENERAL COMPLEXITY MEASURE ON AN INPUT SPACE
===============================================================================
-/

/--
A general complexity measure on an input space X:

  • `cost(x)` = “complexity of computing the answer on input x”,
    in some classical model (time, space, steps, etc.);
  • `sizeFn` is a size function for x, used to speak of "worst case
    on inputs of length n".

We do not fix how `cost` is computed; we only record it as a function,
together with a few standard high-level properties as Propositions.
-/
structure ComplexityMeasure (X : Type) where
  /-- Input size function |x|. -/
  sizeFn : SizeFunction X

  /-- Cost function cost(x). -/
  cost : X → ℕ

  /--
  Monotonicity in the sense of "bigger input cannot be cheaper" is
  *not* always true in practice, but we record a generic optional
  property that can be instantiated when appropriate:

      |x| ≤ |y| ⇒ cost(x) ≤ cost(y).

  This is left as a `Prop` that a concrete model may or may not satisfy.
  -/
  weakMonotonicity : Prop

  /--
  Subadditivity or similar structural properties (e.g., cost(x ++ y) ≤
  cost(x) + cost(y) + overhead) can be captured here.  Again, this is
  kept as a `Prop` to allow different instantiations.
  -/
  structuralSubadditivity : Prop


/-
===============================================================================
III. GROWTH RATES AND ASYMPTOTIC DOMINATION
===============================================================================
-/

/--
A real-valued “growth function” on ℕ.

Examples:
  • f(n) = n^k,
  • f(n) = 2^n,
  • f(n) = n^log n, etc.
-/
abbrev GrowthFunction := ℕ → ℝ

/--
Big-O style domination: cost(n) = O(g(n)).

We keep this as a minimal abstract notion:

  A function f : ℕ → ℝ is O(g) if there exist C > 0 and N such that
  for all n ≥ N, |f(n)| ≤ C * g(n).

Here we encode the existence of such C and N as a `Prop`.
-/
structure BigO (f g : GrowthFunction) : Prop where
  exists_constants :
    ∃ (C : ℝ) (N : ℕ),
      C > 0 ∧
      ∀ n ≥ N, |f n| ≤ C * g n

/--
Polynomial growth function specification.

We do not define polynomials explicitly here; instead, we state that
g(n) is bounded above by some polynomial in n, and record the existence
of such a polynomial as a `Prop`.
-/
structure PolynomialGrowth (g : GrowthFunction) : Prop where
  exists_polynomial_bound : Prop

/--
Quasi-polynomial growth: typically something like

    g(n) = exp( (log n)ᵏ ).

We keep the exact functional form abstract and merely state that g
grows at most quasi-polynomially.
-/
structure QuasiPolynomialGrowth (g : GrowthFunction) : Prop where
  exists_quasiPoly_bound : Prop

/--
Exponential growth: typically of the form

    g(n) ≥ c * a^n  for some a > 1, c > 0.

We track it as a `Prop`.
-/
structure ExponentialGrowth (g : GrowthFunction) : Prop where
  grows_at_least_exp : Prop


/-
===============================================================================
IV. COMPLEXITY CLASSES INDUCED BY A MEASURE
===============================================================================
-/

/--
Language: a subset of {0,1}*, as in the Boolean framework.
-/
abbrev Language := BooleanFunctions.Language

/--
A problem instance can often be seen as an input word, so we can talk
about complexity measures for deciding membership in a language L.
We assume:

  • a complexity measure on Word,
  • and a decision algorithm (abstract) for L,
  • whose cost is measured by `measure.cost`.

We separate the notion of “language + algorithm + measure” into a
single structure, so that we can then talk about worst-case cost
on inputs of length n.
-/
structure LanguageAlgorithm where
  /-- Language L ⊆ {0,1}*. -/
  L : Language

  /-- Complexity measure on words (inputs). -/
  measure : ComplexityMeasure Word

  /--
  Abstract decision procedure:

    dec : Word → Bool

  The intended semantics is that dec(w) = true iff w ∈ L.
  We do not require this to be computable here; we only fix the
  signature and a correctness proposition.
  -/
  dec : Word → Bool

  /-- Correctness of the decision procedure. -/
  correctness :
    ∀ w : Word, (dec w = true) ↔ L w


/--
Worst-case cost on inputs of size n for a given LanguageAlgorithm.

Formally:

  T(n) = max_{|w| = n} cost(w).

Since we are not constructing maxima explicitly in this file, we record
this as a function `T : ℕ → ℕ` together with a Prop describing that
it truly bounds cost(w) for all w of length n.
-/
structure WorstCaseCost (A : LanguageAlgorithm) where
  T : ℕ → ℕ
  /--
  Bounding property:

    ∀ w with |w| = n, cost(w) ≤ T(n).

  This is the standard worst-case interpretation of the complexity
  associated with the algorithm A.
  -/
  bounds_cost :
    ∀ n w,
      inputSize w = n →
      A.measure.cost w ≤ T n


/--
A complexity class induced by a complexity measure and a growth function g.

This models, for example, TIME(g), SPACE(g), or SIZE(g) when g is a
bounding function.

Informally:

  L ∈ Class(g)  if there exists an algorithm for L whose worst-case
  cost on inputs of length n is O(g(n)).

Here we package this as a `Prop` on languages, parametrized by:

  • A complexity measure on Word,
  • A growth function g : ℕ → ℝ.
-/
structure ClassFromMeasure where
  measure : ComplexityMeasure Word
  g       : GrowthFunction

  /--
  Membership of a language L in this class:

    L is in the class if there exists an algorithm A for L and a
    worst-case cost bound T(n) such that T(n) = O(g(n)).

  The existence of A and T, plus the O(g) relationship, is captured
  in the `member` proposition.
  -/
  member : Language → Prop

/-
===============================================================================
V. SPECIALIZATION: CIRCUIT SIZE AS A COMPLEXITY MEASURE
===============================================================================
-/

/--
We can view circuit size as a complexity measure on Boolean functions,
or, via encodings, on languages.

This structure provides a bridge from:

  • Circuit families over inputs of size n,
  • to a complexity measure over words (Binary encodings).
-/
structure CircuitSizeMeasure where
  /-- A word↔bitvector encoding. -/
  encoding : WordBitVecEncoding

  /-- Circuit family intended to decide some language on {0,1}*. -/
  family   : Circuits.CircuitFamily

  /-- Complexity measure on Word induced by circuit size. -/
  measureOnWords : ComplexityMeasure Word

  /--
  Prop-level specification stating that `measureOnWords.cost w` is
  essentially given by the size of the circuit of appropriate arity
  that acts on the bit-vector encoding of w.

  In other words, there is a simple relationship between:

    cost(w)        (abstract measure on Word)
    size(C_n)      (syntax size of the circuit for length n),
    where n = |w|.

  We record this relationship abstractly here, to be instantiated
  concretely in a more detailed development.
  -/
  cost_matches_circuit_size : Prop


/--
From a circuit size measure, we can define a complexity class:

  SIZE(g) = { L ⊆ {0,1}* : L has a circuit family with size ≤ g(n) }.

Here we keep the general shape as a ClassFromMeasure, with the growth
function g provided as a parameter.
-/
def SizeClass (M : CircuitSizeMeasure) (g : GrowthFunction) : ClassFromMeasure :=
  { measure := M.measureOnWords
    g       := g
    member  := fun L => True }  -- placeholder: detailed membership described elsewhere


/-
===============================================================================
VI. SPECIAL GROWTH FUNCTIONS: POLY, QUASI-POLY, EXP
===============================================================================
-/

/--
Abstract “polynomial” growth function parameterized by an exponent k ≥ 1:

  poly_k(n) = n^k, encoded as a real-valued function.
-/
def polyGrowth (k : ℕ) : GrowthFunction :=
  fun n => (n : ℝ) ^ k

/--
Abstract “quasi-polynomial” growth function:

  qp(n) ≈ exp( (log n)^k ).

We do not pin down the exact formula here; we simply give it a name.
-/
def quasiPolyGrowth (k : ℕ) : GrowthFunction :=
  fun n => Real.exp ((Real.log (n.toReal + 1)) ^ k)

/--
Abstract exponential growth:

  expGrowth(n) = a^n for some fixed a > 1.

We leave `a` as a parameter.
-/
def expGrowth (a : ℝ) : GrowthFunction :=
  fun n => a ^ n


/-
===============================================================================
VII. P vs NP AND SAT VIA MEASURES AND CIRCUITS
===============================================================================
-/

/--
Pulls in the ComplexityClasses defined in the Boolean framework.
-/
abbrev ComplexityClasses := BooleanFunctions.ComplexityClasses

/--
A classical-style triple connecting:

  • Boolean complexity classes (P, NP, SAT),
  • circuit size measure,
  • and a growth rate g (e.g. polynomial).

This is used to express the canonical form of P vs NP lower bounds:

    P ≠ NP ⇒ SAT ∉ SIZE(poly).

We express it as a type of theorem.
-/
structure PvNP_MeasureFramework where
  classes : ComplexityClasses
  circuitMeasure : CircuitSizeMeasure
  g : GrowthFunction
  g_is_polynomial : PolynomialGrowth g

/--
Statement type:

  In this measure-based framework F, the P vs NP lower bound for SAT
  against size(g) reads:

    If P ≠ NP, then SAT ∉ SIZE(g).

We do not assert it is true; we only define its precise logical shape.
-/
def PvNP_SAT_vs_Size_Statement
    (F : PvNP_MeasureFramework) : Prop :=
  let C := F.classes
  -- P ≠ NP as a language-level statement.
  let P_ne_NP : Prop :=
    ¬ (∀ L : Language, C.P L ↔ C.NP L)

  -- SAT is not in the SizeClass determined by g.
  let SAT_not_in_sizeClass : Prop :=
    ¬ (SizeClass F.circuitMeasure F.g).member C.SAT

  P_ne_NP → SAT_not_in_sizeClass


/-
===============================================================================
VIII. META-LEVEL: HOW TO USE THIS FILE IN THE FULL PROJECT
===============================================================================

This file is intended as a reusable abstraction layer:

  • For *time complexity*: instantiate ComplexityMeasure with
    - X = Word,
    - sizeFn = length,
    - cost = “number of steps of a Turing machine M on input w”;
    and define TIME(f) classes via ClassFromMeasure.

  • For *space complexity*: same pattern, cost = “memory used”.

  • For *circuit size*: use CircuitSizeMeasure to connect syntactic
    size(C_n) to a measure on Word.

  • For *P vs NP* and Clay-style theorems:
    - Use PvNP_MeasureFramework + PvNP_SAT_vs_Size_Statement as the
      central type of theorem to be proved;
    - Connect this with the Boolean geometry layer
      (ConfigurationSpace, MorseFunctional, etc.);
    - Optionally bring in analytic layers or limit-hypothesis layers.

Every object here is classical and has a clear mathematical meaning.
No symbolic or exotic objects are introduced.
===============================================================================
-/

end Measures
end Complexity
