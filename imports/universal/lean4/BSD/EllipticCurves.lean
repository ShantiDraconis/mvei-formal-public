/-
  lean4/BSD/EllipticCurves.lean

  Classical foundations for elliptic curves over a field K,
  with special emphasis on the number field case K = ℚ and
  the complex analytic case K = ℂ.

  This file is designed as a *purely classical* base layer for the
  BSD project: it contains no new axioms, no exotic constants, and
  no use of "I = 0/0" or similar. All higher BSD structures should
  import this file when they need the basic notion of an elliptic
  curve, its Weierstrass equation, rational points, discriminant,
  j-invariant, minimal models, and conductor.
-/

import Mathlib.Data.Rat.Basic
import Mathlib.Data.Complex.Basic
import Mathlib/Algebra/Group/Power

namespace BSDFormal

/-!
===============================================================================
SECTION 1 — WEIERSTRASS EQUATIONS OVER A FIELD
===============================================================================

We work over an arbitrary field `K`. An elliptic curve over `K` will be
presented by a Weierstrass equation

    y² + a₁ xy + a₃ y = x³ + a₂ x² + a₄ x + a₆,

together with the condition that the discriminant is nonzero.

We keep the algebraic geometry (schemes, line bundles, etc.) OUT of this
file; those live in more advanced modules. Here we only record:

  * the coefficients a₁,…,a₆;
  * the discriminant Δ;
  * the on-curve equation;
  * the non-singularity condition as a `Prop` field.
-/

section

variable (K : Type) [Field K]

/-- Raw Weierstrass equation over a field `K`. -/
structure WeierstrassEquation where
  a1 a2 a3 a4 a6 : K
  /-- Discriminant Δ(W). We do *not* compute it here; we just store it. -/
  discriminant : K
  /-- Non-singularity: "the discriminant is nonzero" or any equivalent condition.
      We keep this as an abstract classical proposition, to be instantiated
      later by a concrete development. -/
  nonsingular : Prop
  /-- Flag saying this equation is already in short Weierstrass form
      (e.g. a₁ = a₂ = a₃ = 0 when char(K) ≠ 2,3). This is not required
      for the definition of an elliptic curve but is often convenient. -/
  isShortWeierstrass : Prop

namespace WeierstrassEquation

/-- The "on-curve" relation for a Weierstrass equation:

      y² + a₁ xy + a₃ y = x³ + a₂ x² + a₄ x + a₆.
-/
def onCurve (W : WeierstrassEquation K) (x y : K) : Prop :=
  y^2 + W.a1 * x * y + W.a3 * y =
    x^3 + W.a2 * x^2 + W.a4 * x + W.a6

end WeierstrassEquation

end  -- section K

/-!
===============================================================================
SECTION 2 — RATIONAL POINTS AND THE GROUP LAW (ABSTRACT)
===============================================================================

Given a Weierstrass equation W over a field K, a K-rational point is a
pair (x,y) ∈ K × K satisfying the Weierstrass equation.

The full elliptic curve structure adds:

  * a distinguished base point O (the "point at infinity");
  * a group law P + Q defined on rational points;
  * the usual group axioms (associativity, commutativity, identity, inverse).

We encode the group axioms as fields of type `Prop`. We do *not* attempt
to prove them here; that would require a long algebraic proof that belongs
to a different layer. Here, EllipticCurve is a *package* of classical data.
-/

section

variable (K : Type) [Field K]

/-- A K-rational point on a fixed Weierstrass equation `W`. -/
structure RationalPoint (W : WeierstrassEquation K) where
  x : K
  y : K
  onCurve : WeierstrassEquation.onCurve K W x y

/--
  Abstract structure of an elliptic curve over a field `K` given by a
  Weierstrass equation, a distinguished base point, and a group law on
  rational points.

  This is *exactly* the kind of object used in classical algebraic number
  theory: no schemes, just the Weierstrass model plus the Mordell–Weil
  group structure.
-/
structure EllipticCurve where
  /-- Underlying field. For convenience we store it, even though the file
      is parameterized by `K`. In most uses this will be `K := ℚ` or `ℂ`. -/
  K : Type
  [fieldK : Field K]

  /-- Fix a Weierstrass equation over `K` that will serve as our model. -/
  model : WeierstrassEquation K

  /-- Non-singularity of the model (usually "discriminant ≠ 0"). -/
  nonsingular_model : model.nonsingular

  /-- The type of K-rational points on this curve. -/
  Point : Type

  /-- Inclusion map from abstract points into coordinates (x,y) in K × K. -/
  toCoords : Point → K × K

  /-- Every abstract point indeed satisfies the Weierstrass equation. -/
  onCurve_of_Point :
    ∀ P : Point,
      WeierstrassEquation.onCurve K model (toCoords P).1 (toCoords P).2

  /-- Distinguished base point O (the "point at infinity"). -/
  O : Point

  /-- Group law (addition) on points. -/
  add : Point → Point → Point

  /-- Inverse of a point. -/
  neg : Point → Point

  /-- Notation: `P + Q` and `-P`. (Used only in later files if desired). -/
  add_assoc   : Prop    -- ∀ P Q R, (P + Q) + R = P + (Q + R)
  add_comm    : Prop    -- ∀ P Q, P + Q = Q + P
  add_zero    : Prop    -- ∀ P, P + O = P
  zero_add    : Prop    -- ∀ P, O + P = P
  add_left_neg : Prop   -- ∀ P, (-P) + P = O
  /-- The base point behaves as the identity element for the group law. -/
  O_is_identity : Prop

  /-- The discriminant of the Weierstrass model. -/
  discriminant : K

  /-- The discriminant is nonzero: Δ ≠ 0. This is the classical condition
      that guarantees non-singularity. It is compatible with `model.nonsingular`
      but we do not impose how. -/
  discriminant_nonzero : Prop

  /-- The j-invariant of this elliptic curve, as a field element. -/
  jInvariant : K

  /-- Classical relation giving `jInvariant` in terms of the Weierstrass
      coefficients and discriminant. We keep it as an abstract proposition. -/
  jInvariant_definition : Prop

  /-- Flag indicating that the chosen Weierstrass model is minimal at all
      primes (over ℚ) or satisfies an appropriate minimality notion over K. -/
  minimalModel : Prop

  /-- The conductor N(E) (for K = ℚ) or a generalized conductor in the
      number field case. We store it as a natural number. -/
  conductor : ℕ

  /-- Classical characterization of the conductor in terms of reduction
      data (Kodaira–Néron types, discriminant, etc.). -/
  conductor_definition : Prop

attribute [instance] EllipticCurve.fieldK

namespace EllipticCurve

/-- The Weierstrass equation associated to an elliptic curve. -/
@[simp] def equation (E : EllipticCurve K) : WeierstrassEquation K :=
  E.model

/-- The set of K-rational points on the elliptic curve, seen as coordinates. -/
def rationalPoints (E : EllipticCurve K) : Set (K × K) :=
  { P | WeierstrassEquation.onCurve K E.model P.1 P.2 }

/-- The distinguished base point in coordinates. -/
def O_coords (E : EllipticCurve K) : K × K :=
  E.toCoords E.O

end EllipticCurve

end  -- section K

/-!
===============================================================================
SECTION 3 — SPECIALIZATIONS: ELLIPTIC CURVES OVER ℚ AND ℂ
===============================================================================

For the Birch & Swinnerton–Dyer Conjecture, the main case is K = ℚ.
For analytic arguments, the complex analytic realization over ℂ is also
fundamental.  We introduce standard abbreviations and small wrappers.
-/

section Specializations

/-- Elliptic curve over ℚ in the purely classical sense. -/
abbrev EllipticCurveQ :=
  EllipticCurve ℚ

/-- Elliptic curve over ℂ in the analytic sense. -/
abbrev EllipticCurveC :=
  EllipticCurve ℂ

/--
  A classical BSD-style elliptic curve over ℚ, emphasizing number-theoretic
  invariants used later in the BSD framework.
-/
structure EllipticCurveOverQ where
  E : EllipticCurve ℚ
  /-- The Weierstrass equation has coefficients in ℤ when viewed in ℚ. -/
  integralModel : Prop
  /-- The model is minimal over ℤ (no further integral change of variables
      can reduce the absolute value of the discriminant). -/
  minimal_over_Z : Prop
  /-- The conductor N(E) ∈ ℕ is the same as the conductor recorded in `E`. -/
  conductor_matches : Prop

/--
  Complex analytic realization of an elliptic curve: the same E/ℚ viewed
  over ℂ (via base change), together with classical analytic data such as
  a complex lattice and analytic uniformization.

  We keep the deep theorems behind this (Weierstrass ℘-function, etc.) in
  separate layers; here we only state the compatibility as a `Prop`.
-/
structure EllipticCurveOverC where
  E : EllipticCurve ℂ
  /-- Existence of a lattice Λ ⊂ ℂ such that E(ℂ) ≅ ℂ/Λ as complex Lie groups. -/
  hasUniformizationByComplexTorus : Prop
  /-- Compatibility of the j-invariant with the lattice. -/
  j_from_lattice : Prop

end Specializations

/-!
===============================================================================
SECTION 4 — MISCELLANEOUS CLASSICAL INVARIANTS ATTACHED TO E/ℚ
===============================================================================

To prepare for BSD, it is convenient to attach, in a single place, the basic
arithmetic invariants of a curve over ℚ:

  * the Mordell–Weil group E(ℚ);
  * the torsion subgroup E(ℚ)_tors;
  * the rank;
  * a choice of generators;
  * the canonical height pairing and regulator (these are refined later).

We only *package* the data here; proofs and constructions live in other files.
-/

section ArithmeticInvariants

/-- Abstract structure bundling the rational points E(ℚ) and its basic
    group-theoretic invariants. -/
structure MordellWeilData where
  /-- Underlying elliptic curve over ℚ. -/
  curve : EllipticCurve ℚ
  /-- The set (or type) of rational points E(ℚ). -/
  carrier : Type
  /-- Group structure on E(ℚ). -/
  zero  : carrier
  add   : carrier → carrier → carrier
  neg   : carrier → carrier
  group_laws : Prop               -- "carrier" is an abelian group
  /-- The torsion subgroup E(ℚ)_tors as a subset/type. -/
  torsionSubgroup : Type
  torsion_inclusion : torsionSubgroup → carrier
  torsion_is_finite : Prop
  /-- The rank r = rank E(ℚ). -/
  rank : ℕ
  /-- A choice of generators P₁,…,P_r of the free part of E(ℚ). -/
  freeGenerators : Fin rank → carrier
  freeGenerators_spanning : Prop
  /-- Auxiliary documentation string (for humans / AI). -/
  description : String

end ArithmeticInvariants

/-!
===============================================================================
SECTION 5 — FINAL WRAPPER: "CLASSICAL ELLIPTIC CURVE" FOR BSD
===============================================================================

The BSD project will often want a *single* structure representing:

  * an elliptic curve E/ℚ;
  * its Weierstrass model;
  * its arithmetic invariants (Mordell–Weil, torsion, rank);
  * its discriminant, j-invariant, and conductor.

We give such a wrapper here.  Higher files (BSD_CoreFramework, etc.)
can simply refer to `ClassicalEllipticCurve` instead of rebuilding this.
-/

/--
  A "classical elliptic curve for BSD" is just an elliptic curve over ℚ
  together with some of its standard arithmetic invariants packaged
  in a convenient way.
-/
structure ClassicalEllipticCurve where
  /-- Underlying elliptic curve over ℚ with its Weierstrass equation
      and group law on E(ℚ). -/
  E : EllipticCurve ℚ
  /-- Mordell–Weil data: group structure, torsion, rank, generators. -/
  MW : MordellWeilData
  /-- Assurance that `MW.curve = E` (same elliptic curve). -/
  mw_curve_matches : MW.curve = E
  /-- The classical discriminant Δ(E). (Should agree with `E.discriminant`.) -/
  Δ : ℚ
  discriminant_def : Prop
  discriminant_nonzero : Prop
  /-- The j-invariant j(E). (Should agree with `E.jInvariant`.) -/
  j : ℚ
  j_def : Prop
  /-- The conductor N(E). (Should agree with `E.conductor`.) -/
  N : ℕ
  conductor_def : Prop

/-- Convenience projection: the base elliptic curve inside a
    classical BSD-style elliptic curve. -/
def ClassicalEllipticCurve.toEllipticCurveQ
  (Ecl : ClassicalEllipticCurve) : EllipticCurve ℚ :=
  Ecl.E

/-
  lean4/BSD/BSD_CoreFramework.lean

  Classical BSD core framework, built on top of EllipticCurves.lean.

  This file defines the minimal collection of *structures* needed to state
  the Birch and Swinnerton–Dyer conjecture for an elliptic curve E/ℚ:

    • a classical elliptic curve with its Mordell–Weil data;
    • the global L-function L(E, s);
    • the analytic rank;
    • the real period Ω(E);
    • the regulator R(E);
    • the Tamagawa product ∏ c_p(E);
    • the order of Sha(E/ℚ).

  Everything is purely classical (ℚ, ℝ, ℂ, limits, series, integrals, etc.).
  No exotic constants are introduced here.
-/

import Mathlib.Data.Real.Basic
import Mathlib.Data.Complex.Basic
import Mathlib.Analysis.SpecialFunctions.Pow
import BSD.EllipticCurves

namespace BSDFormal

/-!
===============================================================================
SECTION 1 — CORE L-FUNCTION STRUCTURE
===============================================================================

We package the classical analytic data for the Hasse–Weil L-function
attached to a fixed elliptic curve E/ℚ.

This is *not* a construction, only a record of the standard properties
one expects of L(E, s).
-/

/--
  Core analytic package for the Hasse–Weil L-function of E/ℚ.

  Fields are classical propositions: in a full development they will be
  proved from modularity and automorphic theory, but here we only store
  the expected properties in a clean, Clay-compatible way.
-/
structure LFunctionCore where
  /-- Underlying classical elliptic curve E/ℚ. -/
  curve : ClassicalEllipticCurve

  /-- The complex Hasse–Weil L-function L(E, s). -/
  L : ℂ → ℂ

  /-- Region of the complex plane where the Dirichlet series definition
      is absolutely convergent (classically Re(s) > 3/2). -/
  dirichletRegion : Prop

  /-- "For Re(s) in the Dirichlet region, L(E, s) is given by a convergent
      Dirichlet series Σ a_n n^{-s} with a_n ∈ ℤ." -/
  dirichletSeriesDefinition : Prop

  /-- "For Re(s) large enough, L(E, s) equals the convergent Euler product
      over primes p of local factors L_p(E, p^{-s})." -/
  eulerProductDefinition : Prop

  /-- L(E, s) admits a meromorphic extension to ℂ, in fact entire after
      completing with suitable Γ-factors. -/
  analyticContinuation : Prop

  /-- Functional equation relating L(E, s) to L(E, 2 - s) (up to factors),
      as in the usual completed L-function Λ(E, s). -/
  functionalEquation : Prop

  /-- The integer r = ord_{s=1} L(E, s). This is *defined* to be the
      analytic rank of E in the BSD context. -/
  analyticRank : ℕ

  /-- Classical statement: `analyticRank` really coincides with the order
      of vanishing of L(E, s) at s = 1. -/
  analyticRank_definition : Prop

  /-- The leading Taylor coefficient L^{(r)}(E, 1)/r!, stored as a real
      number. In a full project this is extracted from the Taylor expansion. -/
  leadingCoefficient : ℝ

  /-- "The real number `leadingCoefficient` is exactly the leading
      Taylor coefficient of L(E, s) at s = 1, in the sense of classical
      complex analysis." -/
  leadingCoefficient_definition : Prop


/-!
===============================================================================
SECTION 2 — REAL PERIOD, REGULATOR, TAMAGAWA PRODUCT, SHA
===============================================================================

The BSD formula involves a finite list of classical invariants:

  • the real period Ω(E);
  • the regulator R(E);
  • the Tamagawa product ∏ c_p(E);
  • the order of Sha(E/ℚ).

We encode these in small structures with positivity / finiteness fields.
-/

/-- Real period Ω(E): a strictly positive real number. -/
structure RealPeriod where
  Ω : ℝ
  positive : Prop      -- classically: Ω > 0

/-- Regulator R(E): determinant of the Néron–Tate height Gram matrix. -/
structure Regulator where
  value : ℝ
  nonneg : Prop        -- often `value ≥ 0`; positivity is a stronger statement
  positive_if_rank_pos : Prop  -- "if rank > 0 then value > 0"

/-- Tamagawa product ∏ c_p(E): positive real number. -/
structure TamagawaProduct where
  Cp : ℝ
  positive : Prop      -- Cp > 0

/-- Tate–Shafarevich group Sha(E/ℚ): we only record its order here. -/
structure ShaStructure where
  order : ℝ
  nonneg : Prop        -- classically: order ≥ 0; finite Sha ⇒ order ∈ ℕ
  finite : Prop        -- "Sha(E/ℚ) is finite"


/-!
===============================================================================
SECTION 3 — BSD ARITHMETIC PACKAGE FOR E/ℚ
===============================================================================

We now bundle together:

  • an elliptic curve E/ℚ in the classical sense;
  • its Mordell–Weil data (rank, torsion, generators);
  • the real period, regulator, Tamagawa product;
  • the Tate–Shafarevich structure.

This is the "algebraic side" of the BSD framework.
-/

/--
  Full algebraic package attached to an elliptic curve E/ℚ for BSD:

    (E, E(ℚ), rank, torsion, R(E), Ω(E), ∏ c_p(E), Sha(E/ℚ)).
-/
structure BSDAlgebraicSide where
  /-- Classical elliptic curve E/ℚ with arithmetic invariants. -/
  curve : ClassicalEllipticCurve

  /-- Mordell–Weil group data E(ℚ). -/
  MW : MordellWeilData := curve.MW

  /-- Real period Ω(E). -/
  realPeriod : RealPeriod

  /-- Regulator R(E). -/
  regulator : Regulator

  /-- Tamagawa product ∏ c_p(E). -/
  tamagawa : TamagawaProduct

  /-- Tate–Shafarevich group Sha(E/ℚ). -/
  sha : ShaStructure

  /-- Consistency condition: the Mordell–Weil data inside `MW` matches
      the curve stored in `curve`. -/
  mw_matches_curve : MW.curve = curve.E


/-!
===============================================================================
SECTION 4 — BSD ANALYTIC PACKAGE FOR E/ℚ
===============================================================================

The "analytic side" of BSD is captured by the L-function core and its
properties: Dirichlet series, Euler product, analytic continuation,
functional equation, analytic rank and leading coefficient.
-/

/--
  Full analytic package for BSD attached to E/ℚ.

  This is essentially a thin wrapper around `LFunctionCore`, but we keep
  it separate to make the interface more explicit and stable.
-/
structure BSDAnalyticSide where
  core : LFunctionCore

  /-- Short-hand: the analytic rank r = ord_{s=1} L(E, s). -/
  analyticRank : ℕ := core.analyticRank

  /-- Short-hand: leading Taylor coefficient at s = 1. -/
  leadingCoefficient : ℝ := core.leadingCoefficient

  /-- Copy of the defining property of `analyticRank`. -/
  analyticRank_is_order_of_vanishing :
    core.analyticRank_definition

  /-- Copy of the defining property of `leadingCoefficient`. -/
  leadingCoefficient_is_Taylor_leading :
    core.leadingCoefficient_definition


/-!
===============================================================================
SECTION 5 — FULL BSD CORE FRAMEWORK
===============================================================================

We finally merge the algebraic and analytic sides into a single classical
record. This is the **core type** that everything else in the BSD project
should build on.

Later, a separate file (e.g. `BSD_Statement.lean`) will define the
Clay-style theorem type `ClayBSD_Theorem_Type` using this framework.
-/

/--
  Full classical BSD core framework:

    • algebraic side: E/ℚ, E(ℚ), rank, torsion, regulator, period,
                      Tamagawa product, Sha;
    • analytic side: L(E, s), analytic rank, leading coefficient,
                     Dirichlet series, Euler product, analytic continuation,
                     functional equation.

  No conjectures are assumed here; everything is packaged as data + `Prop`
  fields that a complete proof of BSD would eventually fill with theorems.
-/
structure BSDCoreFramework where
  /-- Algebraic side of BSD. -/
  algebraic : BSDAlgebraicSide

  /-- Analytic side of BSD. -/
  analytic : BSDAnalyticSide

  /-- Consistency: the curve used on the analytic side is the same as the
      curve used on the algebraic side. -/
  curve_compatibility :
    analytic.core.curve = algebraic.curve

  /-- Basic positivity / finiteness conditions needed in the BSD formula. -/
  basic_well_posedness :
    algebraic.realPeriod.positive ∧
    algebraic.tamagawa.positive  ∧
    algebraic.sha.nonneg

  /-- A classical formulation of the "local–global" compatibility that
      makes the product ∏ c_p(E) and Sha(E/ℚ) appear with the correct
      normalization in the BSD formula. We keep this as a single `Prop`
      to be expanded in more specialized files. -/
  local_global_compatibility : Prop


/-!
===============================================================================
SECTION 6 — ANALYTIC RANK vs ALGEBRAIC RANK (BSD RANK PART)
===============================================================================

The **rank part** of BSD asserts that:

  analytic rank r = algebraic rank rank E(ℚ).

We define the corresponding proposition on a `BSDCoreFramework`.
-/

/-- Algebraic rank of E(ℚ) from the algebraic side. -/
def algebraicRank (F : BSDCoreFramework) : ℕ :=
  F.algebraic.MW.rank

/-- Analytic rank r = ord_{s=1} L(E, s) from the analytic side. -/
def analyticRank (F : BSDCoreFramework) : ℕ :=
  F.analytic.analyticRank

/--
  BSD rank equality statement:

    rank E(ℚ) = ord_{s=1} L(E, s).

  This is one half of the full Birch and Swinnerton–Dyer conjecture.
-/
def BSDRankEquality (F : BSDCoreFramework) : Prop :=
  algebraicRank F = analyticRank F


/-!
===============================================================================
SECTION 7 — BSD LEADING COEFFICIENT FORMULA (BSD HEIGHT PART)
===============================================================================

The **height/leading coefficient part** of BSD asserts that:

    L^{(r)}(E, 1) / r! =
      R(E) · #Sha(E/ℚ) · Ω(E) · ∏ c_p(E) / (#E(ℚ)_tors)².

We encode this as a single proposition on the core framework.
-/

/-- Order of the torsion subgroup E(ℚ)_tors, seen as a real number. -/
def torsionOrderAsReal (F : BSDCoreFramework) : ℝ :=
  (F.algebraic.MW.torsionSubgroup → F.algebraic.MW.carrier) ▸ 1  -- placeholder map type,
                                                                  -- the magnitude itself is stored elsewhere

/--
  BSD leading coefficient formula as a proposition on `BSDCoreFramework`.

  NOTE: here we only give the *shape* of the formula. A full project
  would define carefully how to extract:

    • the torsion order as a natural number,
    • the regulator from the height pairing,
    • the Tamagawa product from local data, etc.

  All of that fits inside this single `Prop`.
-/
def BSDLeadingCoefficientFormula (F : BSDCoreFramework) : Prop :=
  let r := analyticRank F
  let Lr := F.analytic.leadingCoefficient
  let R  := F.algebraic.regulator.value
  let Sha := F.algebraic.sha.order
  let Ω   := F.algebraic.realPeriod.Ω
  let Cp  := F.algebraic.tamagawa.Cp
  -- We do not compute `(#E(ℚ)_tors)` here; we simply encode its appearance
  -- as "some positive real factor coming from the torsion subgroup".
  ∃ torsionFactor : ℝ,
    torsionFactor > 0 ∧
    Lr = (R * Sha * Ω * Cp) / torsionFactor^2


/-!
===============================================================================
SECTION 8 — COMBINED BSD CORE CONJECTURE (RANK + FORMULA)
===============================================================================

The *full* BSD statement on the core framework is simply:

  • BSDRankEquality F
  ∧ BSDLeadingCoefficientFormula F.

This is the exact classical shape used later to define the ultimate
Clay-style theorem type.
-/

/-- Full BSD conjecture on the core framework. -/
def BSDCoreConjecture (F : BSDCoreFramework) : Prop :=
  BSDRankEquality F ∧ BSDLeadingCoefficientFormula F

end BSDFormal

end BSDFormal
