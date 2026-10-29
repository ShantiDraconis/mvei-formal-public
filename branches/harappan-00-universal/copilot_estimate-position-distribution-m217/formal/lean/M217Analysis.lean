/-
  M217 Positional Distribution Analysis — Lean 4 Formal Specification

  This module provides a Lean 4 encoding of the statistical framework for
  testing whether Indus sign M217 has a non-random positional distribution.

  Mathematical objects formalised:
    1. Position type and positional distribution
    2. Geometric feature vector and weighted L1 distance
    3. Co-occurrence adjacency matrix (bigram counts)
    4. Variant family and normalisation
    5. Null / alternative hypothesis framework

  Research context:
    - Rao et al. (2009): Markov / entropic approach to Indus sequences.
    - Wells (2011): Epigraphic positional analysis.
    - Yadav et al. (2010): Sign design, basic/compound/modifier classification.
    - Mahadevan (1977): Canonical 417-sign corpus.
-/

namespace Harappan.M217Analysis

-- ==========================================================================
-- 1. Position type
-- ==========================================================================

/-- Positional slot of a sign within an inscription. -/
inductive Position : Type where
  | initial  : Position   -- first sign of an inscription
  | medial   : Position   -- neither first nor last
  | terminal : Position   -- last sign of an inscription
  | isolated : Position   -- inscription of length 1
  deriving Repr, BEq, DecidableEq

/-- Derive the position of a sign at 0-based index [idx] in a text of
    length [len]. -/
def derivePosition (idx len : Nat) : Position :=
  if len == 1 then Position.isolated
  else if idx == 0 then Position.initial
  else if idx == len - 1 then Position.terminal
  else Position.medial

-- ==========================================================================
-- 2. Positional distribution
-- ==========================================================================

/-- Raw counts for each positional slot. -/
structure PositionalCounts where
  initial  : Nat := 0
  medial   : Nat := 0
  terminal : Nat := 0
  isolated : Nat := 0
  deriving Repr

def PositionalCounts.total (c : PositionalCounts) : Nat :=
  c.initial + c.medial + c.terminal + c.isolated

def PositionalCounts.empty : PositionalCounts := {}

/-- Increment the counter for a given position. -/
def PositionalCounts.increment (c : PositionalCounts) (p : Position) : PositionalCounts :=
  match p with
  | Position.initial  => { c with initial  := c.initial  + 1 }
  | Position.medial   => { c with medial   := c.medial   + 1 }
  | Position.terminal => { c with terminal := c.terminal + 1 }
  | Position.isolated => { c with isolated := c.isolated + 1 }

/-- Every increment raises the total by exactly one. -/
theorem increment_total (c : PositionalCounts) (p : Position) :
    (c.increment p).total = c.total + 1 := by
  unfold PositionalCounts.increment PositionalCounts.total
  cases p <;> simp <;> omega

-- ==========================================================================
-- 3. Geometric feature vector and weighted L1 distance
-- ==========================================================================

/-- Six-dimensional geometric parameter vector for a sign token.
    Parameters are natural-number scaled values to avoid real-number
    arithmetic. -/
structure GeometricVector where
  h     : Nat   -- height (scaled)
  a     : Nat   -- outer width
  b     : Nat   -- inner / cavity width
  g     : Nat   -- gap between horizontal bars
  theta : Nat   -- dominant stroke angle
  sigma : Nat   -- bilateral-symmetry residual
  deriving Repr, BEq

/-- Absolute difference of two natural numbers. -/
def absDiff (x y : Nat) : Nat :=
  if x ≤ y then y - x else x - y

/-- Weighted L1 distance between two sign feature vectors.

    d(Mᵢ, Mⱼ) = Σₖ wₖ · |vᵢₖ − vⱼₖ|
-/
def signDistance
    (w1 w2 w3 w4 w5 w6 : Nat)
    (vi vj : GeometricVector) : Nat :=
  w1 * absDiff vi.h     vj.h
+ w2 * absDiff vi.a     vj.a
+ w3 * absDiff vi.b     vj.b
+ w4 * absDiff vi.g     vj.g
+ w5 * absDiff vi.theta vj.theta
+ w6 * absDiff vi.sigma vj.sigma

/-- Distance is symmetric. -/
theorem signDistance_symm (w1 w2 w3 w4 w5 w6 : Nat) (vi vj : GeometricVector) :
    signDistance w1 w2 w3 w4 w5 w6 vi vj =
    signDistance w1 w2 w3 w4 w5 w6 vj vi := by
  unfold signDistance absDiff
  split_ifs <;> omega

/-- A sign's distance to itself is zero. -/
theorem signDistance_self_zero (w1 w2 w3 w4 w5 w6 : Nat) (v : GeometricVector) :
    signDistance w1 w2 w3 w4 w5 w6 v v = 0 := by
  unfold signDistance absDiff
  simp

-- ==========================================================================
-- 4. Variant family
-- ==========================================================================

/-- A variant family groups sign tokens within a threshold distance.
    The canonical member is the sign closest to the centroid. -/
structure VariantFamily where
  canonicalId : String
  members     : List String
  threshold   : Nat
  deriving Repr

def VariantFamily.inFamily (fam : VariantFamily) (sid : String) : Bool :=
  fam.members.contains sid

/-- A family is well-formed when the canonical ID is in the member list. -/
def VariantFamily.wellFormed (fam : VariantFamily) : Prop :=
  fam.canonicalId ∈ fam.members

-- ==========================================================================
-- 5. Co-occurrence adjacency
-- ==========================================================================

/-- A directed bigram: [fromSign] immediately precedes [toSign]. -/
structure Bigram where
  fromSign : String
  toSign   : String
  count    : Nat
  deriving Repr

/-- Sum forward bigram counts for a given source sign. -/
def countForward (bgs : List Bigram) (sid : String) : Nat :=
  bgs.foldl (fun acc bg =>
    if bg.fromSign == sid then acc + bg.count else acc) 0

/-- Transition probability P(toSign | fromSign) under unigram MLE.
    Returns a pair (numerator, denominator) for exact rational arithmetic. -/
def transitionCount (bgs : List Bigram) (from' to' : String) : Nat :=
  bgs.foldl (fun acc bg =>
    if bg.fromSign == from' && bg.toSign == to' then acc + bg.count else acc) 0

-- ==========================================================================
-- 6. Hypothesis framework
-- ==========================================================================

/-
  H0: M217 does not show a positional distribution distinct from chance
      (uniform over the four positional slots).

  H1: M217 shows distributional restrictions incompatible with random
      placement.

  Test statistic: χ²(df=3) with scaled integer arithmetic.
  Critical value for α=0.05, df=3: 7.815 (scaled × 1000 → 7815).
-/

/-- Scaled chi-squared statistic (× total × 16 to stay in ℕ). -/
def chi2Scaled (c : PositionalCounts) : Nat :=
  let n := c.total
  let k := 4
  -- Each (k·Oᵢ − n)² contributes to the statistic.
  let d1 := absDiff (k * c.initial)  n
  let d2 := absDiff (k * c.medial)   n
  let d3 := absDiff (k * c.terminal) n
  let d4 := absDiff (k * c.isolated) n
  d1 * d1 + d2 * d2 + d3 * d3 + d4 * d4

/-- Decide whether to reject H0.
    Rejects when chi2Scaled × 1000 > critical7815 × n². -/
def rejectH0 (c : PositionalCounts) (critical7815 : Nat := 7815) : Bool :=
  let n := c.total
  if n == 0 then false
  else chi2Scaled c * 1000 > critical7815 * n

/-- All occurrences in the initial slot: H0 is rejected. -/
theorem allInitial_rejectsH0 (n : Nat) (hn : n ≥ 4) :
    rejectH0 { initial := n, medial := 0, terminal := 0, isolated := 0 } = true := by
  unfold rejectH0 chi2Scaled PositionalCounts.total absDiff
  simp
  omega

/-- Empty corpus: H0 is not rejected. -/
theorem empty_noReject : rejectH0 PositionalCounts.empty = false := by
  unfold rejectH0 PositionalCounts.empty PositionalCounts.total
  simp

-- ==========================================================================
-- 7. Structural interpretation record
-- ==========================================================================

/--
  Academic framing:
  "This work does not claim decipherment. It proposes a formal geometric,
  parametric, and graph-theoretic model of M217 and outlines a corpus-based
  program for testing whether the sign has a stable structural role."
-/
structure M217StructuralHypothesis where
  targetSignId        : String
  canonicalForm       : GeometricVector
  positionalData      : PositionalCounts
  positionalSignif    : Bool        -- true ↔ H0 rejected
  numVariants         : Nat
  uniqueSuccessors    : Nat
  uniquePredecessors  : Nat
  deriving Repr

/-- A hypothesis is empirically supported when H0 is rejected and the
    sign appears in at least 5 inscriptions with rich neighbourhoods. -/
def M217StructuralHypothesis.isSupported (h : M217StructuralHypothesis) : Prop :=
  h.positionalSignif = true ∧
  h.positionalData.total ≥ 5 ∧
  h.uniqueSuccessors ≥ 2 ∧
  h.uniquePredecessors ≥ 1

end Harappan.M217Analysis
