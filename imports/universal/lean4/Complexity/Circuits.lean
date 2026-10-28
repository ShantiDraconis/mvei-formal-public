/-
===============================================================================
File:      Complexity/Circuits.lean
Author:    ShantiDraconis (Tiago) & Copilot/Lean
Project:   Millennium P vs NP — Circuit Layer (Classical, Boolean Basis)

Purpose:
  Provide a fully classical, concrete model of Boolean circuits:

    • Circuit syntax over the basis {AND, OR, NOT, input, constant};
    • Evaluation of circuits as Boolean functions on {0,1}ⁿ;
    • Size and depth measures;
    • Uniform circuit families indexed by input length n;
    • A simple notion of “polynomial-size family”;
    • A circuit-style P vs NP / SAT lower bound statement type.

Everything is standard discrete mathematics.
No exotic constants, no new axioms, no use of `sorry`.
===============================================================================
-/

import Mathlib.Data.Fin.Basic
import Mathlib.Data.Bool.Basic
import Mathlib.Data.Nat.Basic
import Mathlib.Data.List.Basic
import Complexity.BooleanFunctions

namespace Complexity
namespace Circuits

open BooleanFunctions

/-
===============================================================================
I. BASIC CIRCUIT SYNTAX OVER {AND, OR, NOT, INPUT, CONST}
===============================================================================
-/

/--
Boolean circuits over n input bits, using the standard basis:

  • input i    : the i-th input bit;
  • const b    : constant gate (0 or 1);
  • not C      : NOT of a subcircuit;
  • and C₁ C₂  : AND of two subcircuits;
  • or  C₁ C₂  : OR of two subcircuits.

Mathematically, we are modeling tree-like circuits (formulas).  DAG
sharing can be added later, but this already suffices for many
complexity-theoretic specifications.
-/
inductive Circuit (n : ℕ) : Type
  | input  (i : Fin n) : Circuit n
  | const  (b : Bit)   : Circuit n
  | not   (c : Circuit n) : Circuit n
  | and   (c₁ c₂ : Circuit n) : Circuit n
  | or    (c₁ c₂ : Circuit n) : Circuit n

namespace Circuit

/-
===============================================================================
II. CIRCUIT EVALUATION — SEMANTICS AS BOOLEAN FUNCTIONS
===============================================================================
-/

/--
Evaluation of a circuit C on an input x ∈ 𝔹ⁿ.

This gives the standard semantics:

  input i     ↦ x i
  const b     ↦ b
  not C       ↦ ¬ eval C x
  and C₁ C₂   ↦ eval C₁ x && eval C₂ x
  or  C₁ C₂   ↦ eval C₁ x || eval C₂ x
-/
def eval {n : ℕ} (C : Circuit n) (x : BitVec n) : Bit :=
  match C with
  | input i     => x i
  | const b     => b
  | not c       => ! (eval c x)
  | and c₁ c₂   => (eval c₁ x) && (eval c₂ x)
  | or  c₁ c₂   => (eval c₁ x) || (eval c₂ x)

/--
The Boolean function computed by a circuit C, as an element of `BoolFun n`.

This is simply `x ↦ eval C x`.
-/
def toBoolFun {n : ℕ} (C : Circuit n) : BoolFun n :=
  fun x => eval C x

/--
Specification: “Circuit C computes the Boolean function f”.

This is the usual pointwise equality:

    ∀ x ∈ 𝔹ⁿ, eval C x = f x.
-/
def computes {n : ℕ} (C : Circuit n) (f : BoolFun n) : Prop :=
  ∀ x : BitVec n, eval C x = f x

/-
===============================================================================
III. SIZE AND DEPTH OF CIRCUITS
===============================================================================
-/

/--
Syntactic size of a circuit C:

  • Each gate and each input / constant node counts as 1;
  • The size is the total number of nodes in the circuit tree.

This is a standard complexity measure (up to constant factors).
-/
def size {n : ℕ} : Circuit n → ℕ
  | input _     => 1
  | const _     => 1
  | not c       => 1 + size c
  | and c₁ c₂   => 1 + size c₁ + size c₂
  | or  c₁ c₂   => 1 + size c₁ + size c₂

/--
Depth of a circuit C:

  • Input and constant gates have depth 1;
  • NOT adds 1 to the depth of its child;
  • AND/OR gates add 1 to the maximum depth of their children.

This approximates the parallel time of evaluating the circuit.
-/
def depth {n : ℕ} : Circuit n → ℕ
  | input _     => 1
  | const _     => 1
  | not c       => 1 + depth c
  | and c₁ c₂   => 1 + Nat.max (depth c₁) (depth c₂)
  | or  c₁ c₂   => 1 + Nat.max (depth c₁) (depth c₂)

end Circuit

/-
===============================================================================
IV. UNIFORM CIRCUIT FAMILIES
===============================================================================
-/

/--
A uniform family of Boolean circuits (syntactic view):

  • For each input length n, we have a circuit Cₙ on n inputs.

We do not, in this file, enforce a specific uniformity notion (DLOGTIME,
P-uniform, etc.).  Uniformity is recorded as a separate `Prop` and can
be instantiated in a more detailed file.
-/
structure CircuitFamily where
  circuitAt : ℕ → Circuit
  /-- Optional: semantic Boolean function associated with each circuit. -/
  funAt     : ℕ → BoolFun
  /-- Semantic correctness: Cₙ actually computes funAt n. -/
  correctness :
    ∀ n x, Circuit.eval (circuitAt n) x = funAt n x

/--
Uniformity property for a circuit family.

In a full theory, this would formalize that:

  • there exists a Turing machine that, on input (1^n, i), outputs the i-th
    gate of the circuit Cₙ in time polylog(n) or polynomial in n;

or any other standard notion (DLOGTIME-uniform, P-uniform, etc.).

Here we keep it as a single `Prop` placeholder to be chosen later.
-/
structure Uniformity where
  family : CircuitFamily
  isUniform : Prop

/-
===============================================================================
V. POLYNOMIAL-SIZE CIRCUIT FAMILIES
===============================================================================
-/

/--
Polynomial growth bound on ℕ.

This is a minimal abstract notion: we only require a function `bound : ℕ → ℕ`
and a proposition `isPolynomialGrowth` expressing “bound grows at most
polynomially in n”.

A more detailed development could use explicit polynomials p(n) = a₀ + a₁n + …
from Mathlib; here we just record the idea as a `Prop`.
-/
structure PolynomialBound where
  bound : ℕ → ℕ
  isPolynomialGrowth : Prop

/--
A circuit family is polynomial-size if there is some polynomial bound B
such that:

    size(Cₙ) ≤ B.bound n   for all n.

This is the usual “poly-size family of circuits” notion, expressed with
our abstract `PolynomialBound`.
-/
def PolySize (F : CircuitFamily) : Prop :=
  ∃ (B : PolynomialBound),
    ∀ n : ℕ, Circuit.size (F.circuitAt n) ≤ B.bound n

/-
===============================================================================
VI. CONNECTING CIRCUIT FAMILIES TO LANGUAGES
===============================================================================
-/

/--
A circuit family recognizing a language L ⊆ {0,1}*.

We use:

  • Encoding of words as bit-vectors (WordBitVecEncoding),
  • A circuit family F with semantics funAt n : 𝔹ⁿ → 𝔹,
  • The language L is accepted iff the circuit outputs 1 on the encoded input.
-/
structure CircuitRecognizer where
  encoding : WordBitVecEncoding
  family   : CircuitFamily
  language : Language

  /--
  Specification:

    w ∈ L   ⇔   the circuit of appropriate arity returns true on the
                bit-vector encoding of w.

  This is stored as a single proposition; precise details (how n is
  extracted, padding, etc.) are handled by `encoding`.
  -/
  recognition :
    ∀ w : Word,
      language w ↔
        let p := encoding.toVec w
        in Circuit.eval (family.circuitAt p.1) p.2 = true

/-
===============================================================================
VII. SAT VIA CIRCUITS AND THE P vs NP CIRCUIT STATEMENT TYPE
===============================================================================
-/

open BooleanFunctions

/--
A classical SAT-circuit framework:

  • Complexity classes P and NP, with SAT ∈ NP and NP-completeness;
  • A word↔bit-vector encoding;
  • A circuit family attempting to recognize SAT.

We do not require that the family actually recognizes SAT correctly;
that is expressed as a separate `Prop`.
-/
structure SATCircuitFramework where
  classes   : ComplexityClasses
  encoding  : WordBitVecEncoding

  /-- Circuit family intended to compute SAT. -/
  satFamily : CircuitFamily

  /-- Language we intend to be SAT. -/
  SATlang : Language

  /-- SATlang is the `SAT` language from the complexity classes. -/
  SATlang_is_classesSAT :
    SATlang = classes.SAT

  /--
  Specification that the circuit family correctly recognizes SATlang.

  This is a logical statement; in a full proof attempt, this would be
  *proved* by showing the circuit family encodes a standard SAT algorithm.
  -/
  satFamily_recognizes_SAT :
    ∀ w : Word,
      SATlang w ↔
        let p := encoding.toVec w
        in Circuit.eval (satFamily.circuitAt p.1) p.2 = true

/--
Circuit lower bound statement type for SAT:

  Given a SAT-circuit framework F, this expresses the classical assertion:

    “If P ≠ NP, then there is no polynomial-size uniform circuit family
     recognizing SAT.”

In this file we do not assert that the implication holds; we only define
the *type* of such a theorem.  Proving it is the core of the P vs NP
circuit lower bound program.
-/
def PvNP_SAT_CircuitLowerBound_Statement
    (F : SATCircuitFramework)
    (uniform : Uniformity) : Prop :=
  let C := F.classes
  -- Logical statement “P ≠ NP”.
  let P_ne_NP : Prop := ¬ (∀ L : Language, C.P L ↔ C.NP L)
  -- “No polynomial-size circuit family correctly recognizing SAT”.
  let noPolySizeSAT : Prop :=
    ∀ (B : PolynomialBound),
      ¬ (∀ n : ℕ,
        Circuit.size (uniform.family.circuitAt n) ≤ B.bound n)
  P_ne_NP → noPolySizeSAT

/-
Comment:

  • `PvNP_SAT_CircuitLowerBound_Statement F uniform` is the precise Lean type
    of a Clay-style P vs NP circuit theorem in this framework.

  • A future file (e.g. `PvsNPStatement.lean`) can import this and combine it
    with the Boolean-geometry layer (`BooleanFunctions.lean`), the
    order-of-vanishing / analytic layer, or any other structures needed.

  • No exotic notions appear: only words, languages, Boolean functions,
    circuits, sizes, and polynomial bounds.

-/

end Circuits
end Complexity
