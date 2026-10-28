/-
  lean4/BSD/MordellWeil.lean

  Classical Mordell–Weil layer for an elliptic curve E/ℚ.

  This file expands the minimal `MordellWeilData` defined in
  `BSD.EllipticCurves` into a more detailed description of:

    • the full abelian group structure on E(ℚ);
    • torsion subgroup E(ℚ)_tors and free part ℤ^r;
    • the short exact sequence
          0 → E(ℚ)_tors → E(ℚ) → ℤ^r → 0 ;
    • descent, height pairing, and the Néron–Tate quadratic form;
    • the Mordell–Weil theorem as a classical proposition:

          "E(ℚ) is a finitely generated abelian group."

  Everything is expressed as *structures* and `Prop` fields, with no
  new axioms and no use of exotic constants. This file is meant as a
  high-level specification that later files (or external libraries)
  can refine with actual proofs.
-/

import Mathlib.Data.Rat.Basic
import Mathlib.Algebra.Group.Defs
import Mathlib.Algebra.GroupPower
import BSD.EllipticCurves

namespace BSDFormal

/-!
===============================================================================
SECTION 1 — ABSTRACT ABELIAN GROUP STRUCTURE
===============================================================================

We start with a generic "abelian group structure" record that can be
instantiated by E(ℚ).  We do **not** require Lean instances here; instead
we expose the group axioms as a single `Prop`, so that the file remains
lightweight and purely classical.
-/

/--
  Abstract abelian group structure on a type `G`.

  This is intentionally *not* a Lean typeclass instance; instead, it is
  a standalone record that can be carried around separately from any
  existing `AddGroup` / `AddCommGroup` instances.

  For the Mordell–Weil group, `G` will be the underlying set of E(ℚ).
-/
structure AbelianGroupStructure (G : Type) where
  zero : G
  add  : G → G → G
  neg  : G → G
  /-- Classical group axioms (associativity, commutativity, identity,
      inverse). We do not spell them out here; they will be supplied
      or proved in more detailed developments. -/
  isAbelianGroup : Prop

namespace AbelianGroupStructure

/-- Shorthand: the additive notation for this abelian group. -/
def addOp {G} (A : AbelianGroupStructure G) (x y : G) : G :=
  A.add x y

/-- Shorthand: the negation operation. -/
def negOp {G} (A : AbelianGroupStructure G) (x : G) : G :=
  A.neg x

end AbelianGroupStructure

/-!
===============================================================================
SECTION 2 — MORDELL–WEIL GROUP: E(ℚ) AS ABELIAN GROUP
===============================================================================

We now specialise to the case of an elliptic curve E/ℚ and package
the Mordell–Weil group E(ℚ) with:

  • its abelian group structure;
  • the torsion subgroup E(ℚ)_tors;
  • the free part of rank r;
  • the finite generation statement ("Mordell–Weil theorem").
-/

/--
  Detailed Mordell–Weil group structure attached to a classical elliptic
  curve E/ℚ.

  This refines the simpler `MordellWeilData` from `BSD.EllipticCurves`
  with a more explicit group-theoretic and structural viewpoint.
-/
structure MordellWeilGroup where
  /-- Underlying classical elliptic curve over ℚ. -/
  curve : ClassicalEllipticCurve

  /-- The carrier of the Mordell–Weil group E(ℚ). This usually coincides
      with the `carrier` field of `curve.MW`, but we keep it explicit. -/
  carrier : Type

  /-- Abelian group structure on E(ℚ). -/
  groupStructure : AbelianGroupStructure carrier

  /-- Map from abstract Mordell–Weil group elements to rational coordinates
      (x, y) ∈ ℚ × ℚ on the Weierstrass model.  This embeds E(ℚ) inside
      the set of ℚ-rational points on the model. -/
  toCoords : carrier → ℚ × ℚ

  /-- Every point in the image of `toCoords` lies on the Weierstrass
      equation of the curve. -/
  onCurve :
    ∀ P : carrier,
      WeierstrassEquation.onCurve ℚ
        (curve.E.model)
        (toCoords P).1
        (toCoords P).2

  /-- Distinguished identity element (the "point at infinity").
      For convenience, we store it directly as well. -/
  O : carrier

  /-- Identity is compatible with the group structure. -/
  O_is_zero :
    O = groupStructure.zero

  /-- Torsion subgroup E(ℚ)_tors as a separate type. -/
  torsionSubgroup : Type

  /-- Inclusion map from torsion subgroup into E(ℚ). -/
  torsionEmbedding : torsionSubgroup → carrier

  /-- Every element in the image of `torsionEmbedding` has finite order. -/
  torsion_elements_have_finite_order : Prop

  /-- The torsion subgroup is finite in the classical sense (finite set). -/
  torsion_is_finite : Prop

  /-- Rank r = rank E(ℚ), as in the decomposition:

        E(ℚ) ≅ E(ℚ)_tors ⊕ ℤ^r. -/
  rank : ℕ

  /-- Free part ℤ^r, seen abstractly as a separate type.  We do not
      require this to be literally `Fin r → ℤ` in this file; we only
      need that it behaves as a free ℤ-module of rank r. -/
  freePart : Type

  /-- Statement that `freePart` is (abstractly) a free ℤ-module of rank r. -/
  freePart_is_freeAbelian_of_rank : Prop

  /-- Surjective homomorphism from the free part onto E(ℚ) modulo torsion,
      expressing the decomposition

          E(ℚ) / E(ℚ)_tors ≅ ℤ^r. -/
  freePart_to_quotient :
    freePart → carrier

  freePart_to_quotient_surjective : Prop

  /-- Existence of a short exact sequence:

        0 → E(ℚ)_tors → E(ℚ) → ℤ^r → 0.

      This is recorded as a single proposition; the actual exactness
      statements (injectivity, surjectivity, kernel=image) belong to a
      more detailed homological algebra layer. -/
  shortExactSequence_torsion_free :
    Prop

  /-- The classical Mordell–Weil theorem for this particular curve:

        "E(ℚ) is a finitely generated abelian group."

      This is an instance-level statement, not a global theorem. -/
  finitelyGeneratedAbelian : Prop

  /-- Connection to the minimal `MordellWeilData` bundle from
      `BSD.EllipticCurves`: this asserts that the basic rank, torsion
      and generators in `curve.MW` match the more detailed structure
      provided here. -/
  compatible_with_MWData : Prop


namespace MordellWeilGroup

/-- Convenience notation: the rank of the Mordell–Weil group. -/
def rankMW (G : MordellWeilGroup) : ℕ :=
  G.rank

/-- Convenience notation: the underlying set E(ℚ) of rational points. -/
def points (G : MordellWeilGroup) : Type :=
  G.carrier

/-- The torsion subgroup as a type. -/
def torsion (G : MordellWeilGroup) : Type :=
  G.torsionSubgroup

end MordellWeilGroup

/-!
===============================================================================
SECTION 3 — DESCENT DATA AND FACTORIZATION THROUGH ℚ-ISOGENIES
===============================================================================

A key classical ingredient in the study of E(ℚ) is *descent*: describing
E(ℚ) in terms of auxiliary objects (e.g. E/2E, Selmer groups, Galois
cohomology).

We encode this here not as a fully developed theory, but as a structured
package of classical descent data.
-/

/--
  Abstract description of descent data for the Mordell–Weil group E(ℚ).

  Typical examples:

    • 2-descent: E(ℚ)/2E(ℚ) ↔ subset of a finite group (Selmer group);
    • n-descent for other n;
    • connections with Selmer and Tate–Shafarevich groups.
-/
structure DescentData where
  /-- Mordell–Weil group under consideration. -/
  MW : MordellWeilGroup

  /-- An auxiliary finite set (or finite group) which encodes information
      about E(ℚ) modulo nE(ℚ).  We keep it abstract here. -/
  auxiliaryObject : Type

  /-- Finiteness of the auxiliary object. -/
  auxiliary_is_finite : Prop

  /-- A map from the Mordell–Weil group to the auxiliary object, usually
      representing "mod n" information (e.g. mod 2 in 2-descent). -/
  descentMap : MW.carrier → auxiliaryObject

  /-- Classical exactness properties of the descent map and of the
      associated Selmer-type object. -/
  descent_exactness : Prop

  /-- Connection to Sha(E/ℚ): often, the difference between the Selmer
      group and the Mordell–Weil group is controlled by Sha. -/
  sha_connection : Prop


/-!
===============================================================================
SECTION 4 — HEIGHT FUNCTIONS AND NÉRON–TATE HEIGHT
===============================================================================

The Néron–Tate height is a crucial tool in the Mordell–Weil theory: it
provides a positive definite quadratic form on E(ℚ) ⊗ ℝ whose Gram matrix
defines the regulator R(E).

We give a classical abstract description of:

  • logarithmic or naïve height h(P);
  • canonical height ĥ(P);
  • bilinear height pairing ⟨·, ·⟩;
  • basic properties (quadraticity, bilinearity, positivity).
-/

/--
  Abstract classical height data attached to a Mordell–Weil group.

  It contains:

    • a naïve height h;
    • a canonical height ĥ (Néron–Tate);
    • a symmetric bilinear pairing ⟨·, ·⟩ whose Gram matrix yields
      the regulator R(E).
-/
structure HeightData where
  /-- Underlying Mordell–Weil group. -/
  MW : MordellWeilGroup

  /-- Naïve (logarithmic) height h : E(ℚ) → ℝ. -/
  naiveHeight : MW.carrier → ℝ

  /-- Canonical Néron–Tate height ĥ : E(ℚ) → ℝ. -/
  canonicalHeight : MW.carrier → ℝ

  /-- Symmetric bilinear pairing associated to the canonical height:

        ⟨P, Q⟩ = ½ ( ĥ(P + Q) - ĥ(P) - ĥ(Q) ). -/
  pairing : MW.carrier → MW.carrier → ℝ

  /-- Quadraticity of canonical height:

        ĥ(nP) = n² ĥ(P)  for all integers n. -/
  canonicalHeight_quadratic : Prop

  /-- Symmetry of the pairing: ⟨P, Q⟩ = ⟨Q, P⟩. -/
  pairing_symmetric : Prop

  /-- Bilinearity of the pairing in each argument. -/
  pairing_bilinear : Prop

  /-- Positivity: ⟨P, P⟩ ≥ 0, and ⟨P, P⟩ = 0 if and only if P is torsion. -/
  pairing_positive_definite_mod_torsion : Prop

  /-- Relation between naive and canonical heights (classically, the
      difference h(P) - ĥ(P) is bounded on E(ℚ)). -/
  naiveMinusCanonical_bounded : Prop


/-!
===============================================================================
SECTION 5 — REGULATOR, FREE BASIS, AND GRAM MATRIX
===============================================================================

Using the canonical height pairing, one chooses a ℤ-basis P₁,…,P_r of
E(ℚ)/E(ℚ)_tors and defines the regulator as the determinant of the
r × r Gram matrix:

    R(E) = det( ⟨P_i, P_j⟩ ).

We encode this construction abstractly here.
-/

/--
  Abstract description of the regulator construction from height data.

  This is meant to align with the `Regulator` structure used in the BSD
  core framework.
-/
structure RegulatorFromHeight where
  /-- Underlying height data. -/
  H : HeightData

  /-- Rank r = rank E(ℚ). -/
  r : ℕ
  r_matches_MW_rank : r = H.MW.rank

  /-- A chosen ℤ-basis of the free part E(ℚ)/E(ℚ)_tors.  We represent it
      simply as an indexed family of points (P₁,…,P_r). -/
  basis : Fin r → H.MW.carrier

  /-- Matrix of pairings G_{ij} = ⟨P_i, P_j⟩. -/
  GramMatrix : Fin r → Fin r → ℝ

  GramMatrix_def :
    ∀ i j, GramMatrix i j = H.pairing (basis i) (basis j)

  /-- Regulator R(E) as the determinant of the Gram matrix. -/
  regulator : ℝ

  regulator_def :
    regulator = Matrix.det GramMatrix

  /-- Classical property: if r > 0, then regulator > 0. -/
  regulator_positive_if_r_pos : Prop


/-!
===============================================================================
SECTION 6 — CONNECTION TO BSD ALGEBRAIC SIDE
===============================================================================

Finally, we create a record that ties:

  • Mordell–Weil group;
  • height data;
  • regulator construction;

to the `BSDAlgebraicSide` object used in the BSD core framework.  This
gives a clean bridge for the BSD formula that involves the regulator
and other algebraic invariants.
-/

/--
  Bridge between the detailed Mordell–Weil layer and the BSD algebraic
  side used in the core BSD framework.

  This structure expresses that:

    • the Mordell–Weil group here is the same as the one in `BSDAlgebraicSide`;
    • the height-derived regulator coincides with the `Regulator` object
      used in BSD;
    • the rank is consistent.
-/
structure MordellWeilToBSDAlgebraic where
  /-- Mordell–Weil group for E/ℚ. -/
  MW : MordellWeilGroup

  /-- Height data (naïve, canonical, pairing). -/
  heightData : HeightData

  /-- Regulator reconstructed from height data. -/
  regFromHeight : RegulatorFromHeight

  /-- BSD algebraic side object for the same curve. -/
  algebraic : BSDAlgebraicSide

  /-- Compatibility of curves. -/
  curve_matches :
    algebraic.curve = MW.curve

  /-- Rank consistency. -/
  rank_consistency :
    algebraic.MW.rank = MW.rank

  /-- Regulator consistency: the value used in BSD is the same as the
      determinant of the Gram matrix of the canonical height pairing. -/
  regulator_consistency :
    algebraic.regulator.value = regFromHeight.regulator

  /-- Period, Tamagawa, and Sha fields are *not* controlled here, but this
      record fits naturally into the BSD algebraic infrastructure. -/
  auxiliary_comment : String


/-!
===============================================================================
SECTION 7 — MORDELL–WEIL THEOREM AS A GLOBAL-SHAPED PROP
===============================================================================

As a final touch, we package the classical Mordell–Weil theorem as a
generic proposition on an elliptic curve over ℚ:

  "E(ℚ) is a finitely generated abelian group".

In this file, we do not attempt to prove it; we only expose the precise
shape of the statement as a specification.
-/

/--
  Global-shape Mordell–Weil theorem proposition for a classical elliptic
  curve E/ℚ: "E(ℚ) is a finitely generated abelian group."
-/
def MordellWeilTheoremStatement (E : ClassicalEllipticCurve) : Prop :=
  ∃ (G : MordellWeilGroup),
    G.curve = E ∧
    G.finitelyGeneratedAbelian

end BSDFormal
