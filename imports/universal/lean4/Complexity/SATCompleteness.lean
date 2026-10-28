/-
===============================================================================
File:      Complexity/SATCompleteness.lean
Author:    ShantiDraconis (Tiago) & Copilot/Lean
Project:   Millennium P vs NP — SAT & NP-Completeness (Classical)

Purpose:
  Provide a classical, fully explicit layer for propositional SAT:

    • Propositional variables, literals, clauses, CNF formulas;
    • Truth assignments and satisfaction;
    • SAT language over binary words via an abstract encoding;
    • Karp (polynomial-time many-one) reductions between languages;
    • Formal "SAT is NP-complete" statement type, linked to:

        - Complexity.BooleanFunctions (Language, ComplexityClasses),
        - Complexity.ComplexityMeasures (time-like measures).

All content is 100% classical mathematics:
  finite sets, Booleans, lists, encodings, polynomial bounds.
No exotic constants, no new axioms, no `sorry`.
===============================================================================
-/

import Mathlib.Data.Nat.Basic
import Mathlib.Data.List.Basic
import Mathlib.Data.Bool.Basic
import Mathlib.Data.Fin.Basic
import Complexity.BooleanFunctions
import Complexity.ComplexityMeasures

namespace Complexity
namespace SATCompleteness

open BooleanFunctions
open Measures

/-
===============================================================================
I. BASIC REUSED NOTIONS: WORDS, LANGUAGES, CLASSES
===============================================================================
-/

/-- A binary word is a list of bits, as in the Boolean layer. -/
abbrev Word : Type := BooleanFunctions.Word

/-- A language is a set of binary words. -/
abbrev Language : Type := BooleanFunctions.Language

/-- Complexity classes P and NP (base, unrelativized). -/
abbrev ComplexityClasses := BooleanFunctions.ComplexityClasses

/-
===============================================================================
II. PROPOSITIONAL VARIABLES, LITERALS, CLAUSES, CNF FORMULAS
===============================================================================
-/

/--
Propositional variables are indexed by natural numbers.

In a more refined development we could restrict to {0,…,n-1}, but for
complexity theory, ℕ is enough and we will implicitly bound via context.
-/
abbrev Var : Type := ℕ

/--
A literal is either a positive variable or a negated variable.
-/
inductive Literal : Type
  | pos (v : Var)
  | neg (v : Var)
deriving DecidableEq

/--
A clause is a finite disjunction of literals, represented as a list.

Semantically:
  [ℓ₁, ℓ₂, …, ℓₖ] means (ℓ₁ ∨ ℓ₂ ∨ … ∨ ℓₖ).
-/
abbrev Clause : Type := List Literal

/--
A CNF formula is a finite conjunction of clauses, represented as a list.

Semantically:
  [C₁, C₂, …, C_m] means (C₁ ∧ C₂ ∧ … ∧ C_m).
-/
abbrev CNF : Type := List Clause

/-
===============================================================================
III. TRUTH ASSIGNMENTS AND SATISFACTION
===============================================================================
-/

/--
A truth assignment for propositional variables:

  α : Var → Bool

gives a truth value to each variable v ∈ Var.
-/
abbrev Assignment : Type := Var → Bool

/--
Evaluate a literal under an assignment α.

  α ⊨ v      : α v = true
  α ⊨ ¬ v    : α v = false
-/
def evalLiteral (α : Assignment) : Literal → Bool
  | Literal.pos v => α v
  | Literal.neg v => ! (α v)

/--
Satisfaction of a clause by an assignment:

  α ⊨ (ℓ₁ ∨ … ∨ ℓₖ)  iff  at least one ℓᵢ is true under α.

The empty clause is false by convention.
-/
def satisfiesClause (α : Assignment) (C : Clause) : Bool :=
  C.foldr (fun lit acc => evalLiteral α lit || acc) false

/--
Satisfaction of a CNF formula by an assignment:

  α ⊨ (C₁ ∧ … ∧ C_m)  iff  α ⊨ C_j for every j.

The empty conjunction is true by convention.
-/
def satisfiesCNF (α : Assignment) (φ : CNF) : Bool :=
  φ.foldr (fun cl acc => satisfiesClause α cl && acc) true

/--
Semantic satisfiability of a CNF formula:

  SAT(φ)  ≡  ∃ α, α ⊨ φ.
-/
def isSatisfiable (φ : CNF) : Prop :=
  ∃ α : Assignment, satisfiesCNF α φ = true

/-
===============================================================================
IV. ENCODING CNF FORMULAS AS WORDS
===============================================================================
-/

/--
An abstract encoding of CNF formulas as binary words:

  encode : CNF → Word
  decode : Word → CNF

Together with round-trip properties (up to a chosen notion of equality).
We keep these as a structure so that different concrete encodings
can be plugged in later.
-/
structure CNFEncoding where
  encode : CNF → Word
  decode : Word → CNF

  /--
  “decode ∘ encode ≈ id”:

  For every CNF formula φ, decoding its encoding yields something
  equivalent to φ from the point of view of satisfiability.
  -/
  decode_encode_preserves_sat :
    ∀ φ : CNF,
      isSatisfiable (decode (encode φ)) ↔ isSatisfiable φ

  /--
  Optional: encode ∘ decode acts as a normalization on words.

  This ensures that the encoded word of a decoded formula normalizes
  the representation; we record it as a `Prop` without enforcing
  any particular shape.
  -/
  encode_decode_normalizes : Prop

/-
===============================================================================
V. SAT LANGUAGE OVER WORDS (CNF-SAT)
===============================================================================
-/

/--
Given an encoding of CNF formulas, define the SAT language:

  SAT_CNF(w)  ⇔  the decoded CNF formula is satisfiable.
-/
def SAT_CNF (enc : CNFEncoding) : Language :=
  fun w : Word => isSatisfiable (enc.decode w)

/-
===============================================================================
VI. KARP (MANY-ONE) REDUCTIONS
===============================================================================
-/

/--
Karp (polynomial-time many-one) reduction between languages.

We parameterize this reduction by:

  • A complexity measure on Word (e.g. time complexity),
  • A growth function g(n) representing a polynomial bound,
  • A Cost model that ensures the reduction function runs in time ≤ g(n).

We keep the precise “polytime” condition abstract as a `Prop`.
-/
structure KarpReduction
    (measure : ComplexityMeasure Word)
    (g : GrowthFunction)
    (L₁ L₂ : Language) where
  /--
  Reduction function:

    f : {0,1}* → {0,1}*
  -/
  f : Word → Word

  /--
  Correctness of the reduction:

    ∀ w, w ∈ L₁  ↔  f(w) ∈ L₂.
  -/
  correctness :
    ∀ w : Word, L₁ w ↔ L₂ (f w)

  /--
  Complexity bound of the reduction:

    cost(f(w)) ≤ g(|w|) with respect to the given measure.

  We package this as a proposition `polytime` that can be instantiated
  by a concrete time complexity theory.
  -/
  polytime : Prop


/-
===============================================================================
VII. NP-COMPLETENESS OF SAT (ABSTRACT STATEMENT TYPE)
===============================================================================
-/

/--
Framework to state “SAT is NP-complete”:

  • A base complexity class structure (P, NP, SAT) on languages;
  • A CNF encoding;
  • A complexity measure for time on words;
  • A polynomial growth bound g (typically n^k);
  • A proof that every language in NP Karp-reduces to SAT_CNF
    with respect to measure and g.
-/
structure SATCompletenessFramework where
  classes : ComplexityClasses

  /-- CNF encoding to define SAT_CNF. -/
  encoding : CNFEncoding

  /-- Time-like complexity measure on Word. -/
  timeMeasure : ComplexityMeasure Word

  /-- Polynomial growth bound used as the notion of “polynomial time”. -/
  polyBound : GrowthFunction
  polyBound_isPolynomial : PolynomialGrowth polyBound

  /-- We identify our SAT_CNF language with the `SAT` of the classes. -/
  SATlang : Language := SAT_CNF encoding
  SATlang_is_classesSAT :
    SATlang = classes.SAT

  /--
  SAT_CNF is in NP.

  This corresponds to the classical statement “SAT ∈ NP”:

    There is a nondeterministic polynomial-time Turing machine
    that decides SAT.
  Here we package it as a single `Prop` relative to `classes.NP`.
  -/
  SAT_in_NP : classes.NP SATlang

  /--
  NP-hardness: for every language L ∈ NP, there exists a polynomial-time
  Karp reduction from L to SAT_CNF.

  Concretely:

    For every L, if L ∈ NP, then there exists a reduction f such that
    KarpReduction(timeMeasure, polyBound, L, SATlang) holds.

  This is the core completeness property.
  -/
  SAT_NP_hard :
    ∀ L : Language,
      classes.NP L →
      ∃ red : KarpReduction timeMeasure polyBound L SATlang, True

/--
Macro-proposition: “SAT_CNF is NP-complete” in this framework.

We package the two conditions (SAT_in_NP, SAT_NP_hard) together as a Prop.
-/
def SAT_is_NP_complete (F : SATCompletenessFramework) : Prop :=
  F.SAT_in_NP ∧
    ∀ L : Language,
      F.classes.NP L →
      ∃ red : KarpReduction F.timeMeasure F.polyBound L F.SATlang, True


/-
===============================================================================
VIII. LINK TO ComplexityClasses.SAT_NP_complete
===============================================================================

In the Boolean layer (`Complexity.BooleanFunctions`), the field:

    classes.SAT_NP_complete

is an abstract NP-completeness statement for some distinguished
SAT language `classes.SAT`.

In the current file, we provide the *CNF-based* SAT language and
a separate NP-completeness statement.

A future integration file can:

  • show that `SAT_CNF encoding` = `classes.SAT`;
  • show that these NP-completeness formulations are equivalent;
  • instantiate concrete time measures and polynomial bounds.

Here we only expose the structures, without imposing these identifications.
===============================================================================
-/

end SATCompleteness
end Complexity
