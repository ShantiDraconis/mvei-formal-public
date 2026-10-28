-- ============================================================
--  The Indeterminate Framework (TIF) — Lean 4 Formalization
--  File: lean4/Indeterminate.lean
-- ============================================================
--
-- This file provides the foundational Lean 4 skeleton for TIF.
-- It defines the primitive indeterminate type, the extension
-- table operators, the State type, and the Collapse function,
-- together with elementary lemmas corresponding to those in the
-- LaTeX blueprint.
--
-- To check this file, install Lean 4 (via elan) and run:
--   lake env lean lean4/Indeterminate.lean
-- ============================================================

namespace TIF

-- ============================================================
-- 1. Primitive Indeterminate Type  (Definition 1.1, 1.2)
-- ============================================================

/-- The universe of indetermination classes.
    `Ind n` represents the symbol I_n.
    `Ind 0` = I_0 is the base indeterminate (arising from 0/0). -/
inductive Ind : Type where
  | mk : Nat → Ind
  deriving Repr, DecidableEq

/-- Index of an indeterminate. -/
def Ind.index : Ind → Nat
  | Ind.mk n => n

/-- The base indeterminate I_0. -/
def I0 : Ind := Ind.mk 0

-- ============================================================
-- 2. Extended Value  (classical ℝ or Indeterminate)
-- ============================================================

/-- An extended value is either a real number (classical) or an Ind. -/
inductive ExtVal : Type where
  | classical : Float → ExtVal
  | ind       : Ind   → ExtVal
  deriving Repr

def ExtVal.isClassical : ExtVal → Bool
  | ExtVal.classical _ => true
  | ExtVal.ind _       => false

-- ============================================================
-- 3. Axiom 5: No indeterminate equals any classical value
-- ============================================================

/-- Axiom 5: I_n ≠ any classical value (expressed as a proposition
    over ExtVal). -/
theorem ind_neq_classical (n : Nat) (r : Float) :
    ExtVal.ind (Ind.mk n) ≠ ExtVal.classical r := by
  intro h
  cases h  -- ExtVal constructors are distinct

-- ============================================================
-- 4. Extended Operators  (Definition 1.3, Extension Table)
-- ============================================================

/-- Maximum index of two indeterminates (absorption rule). -/
def maxInd (a b : Ind) : Ind := Ind.mk (max a.index b.index)

/-- Apply an extended binary operation following the extension table.
    Parameters: op ∈ {'+', '-', '*', '/'}  (encoded as Char)
    Result:
    - Both classical → classical result (or I_0 on division by zero).
    - One/both indeterminate → absorption rule (max index). -/
def applyOp (op : Char) (left right : ExtVal) : ExtVal :=
  match left, right with
  | ExtVal.classical l, ExtVal.classical r =>
      match op with
      | '+' => ExtVal.classical (l + r)
      | '-' => ExtVal.classical (l - r)
      | '*' => ExtVal.classical (l * r)
      | '/' =>
          if r == 0.0 then ExtVal.ind I0   -- 0/0 and a/0 → I_0
          else ExtVal.classical (l / r)
      | _   => ExtVal.ind I0  -- unknown operator → I_0
  | ExtVal.ind a, ExtVal.ind b => ExtVal.ind (maxInd a b)  -- I_m ○ I_n → I_max
  | ExtVal.ind a, _            => ExtVal.ind a             -- absorption left
  | _,            ExtVal.ind b => ExtVal.ind b             -- absorption right

-- ============================================================
-- 5. Axiom 2: 0/0 → I_0
-- ============================================================

/-- Axiom 2 as a theorem: dividing 0.0 by 0.0 yields I_0. -/
theorem zero_div_zero_is_I0 :
    applyOp '/' (ExtVal.classical 0.0) (ExtVal.classical 0.0) =
    ExtVal.ind I0 := by
  simp [applyOp, I0]

-- ============================================================
-- 6. Axiom 3: Classical Reduction
-- ============================================================

/-- Axiom 3 (addition): the extended + agrees with classical + on reals. -/
theorem classical_add (a b : Float) :
    applyOp '+' (ExtVal.classical a) (ExtVal.classical b) =
    ExtVal.classical (a + b) := by
  simp [applyOp]

/-- Axiom 3 (multiplication): the extended * agrees with classical * on reals. -/
theorem classical_mul (a b : Float) :
    applyOp '*' (ExtVal.classical a) (ExtVal.classical b) =
    ExtVal.classical (a * b) := by
  simp [applyOp]

-- ============================================================
-- 7. Lemma: Idempotence of I_0  (Lemma 4.1 in blueprint)
-- ============================================================

/-- Lemma 4.1: I_0 + I_0 = I_0. -/
theorem I0_add_idemp :
    applyOp '+' (ExtVal.ind I0) (ExtVal.ind I0) = ExtVal.ind I0 := by
  simp [applyOp, maxInd, I0, Ind.index]

-- ============================================================
-- 8. State  (Definition 1.4)
-- ============================================================

/-- A meta-arithmetic state Σ = (E, C).
    Here we model E as a (partial) mapping Nat → Float
    (assigning classical values to indeterminate indices),
    and C as a list of propositions encoded as decidable predicates.

    NOTE: `Float` here is IEEE 754 double-precision (a pragmatic choice
    for this executable skeleton).  A full mathematical formalization
    for Paper P1 should replace `Float` with `Real` from Mathlib4,
    which faithfully models the mathematical real numbers. -/
structure State where
  /-- Equation set: maps indeterminate index to classical value. -/
  equations   : Nat → Option Float
  /-- Constraint set: predicates that must hold on equation values. -/
  constraints : List (Nat × (Float → Bool))

/-- The empty state. -/
def State.empty : State where
  equations   := fun _ => none
  constraints := []

/-- A state is consistent if all constraints are satisfied. -/
def State.isConsistent (s : State) : Bool :=
  s.constraints.all fun (idx, pred) =>
    match s.equations idx with
    | some v => pred v
    | none   => false

-- ============================================================
-- 9. Collapse  (Definition 1.5)
-- ============================================================

/-- Attempt to collapse an ExtVal to a classical Float under a state.
    Returns `some v` if a unique classical resolution exists; `none` otherwise. -/
def collapse (e : ExtVal) (s : State) : Option Float :=
  match e with
  | ExtVal.classical v => some v  -- already classical
  | ExtVal.ind (Ind.mk n) => s.equations n

-- ============================================================
-- 10. Lemma: Classical values collapse to themselves
-- ============================================================

theorem collapse_classical (v : Float) (s : State) :
    collapse (ExtVal.classical v) s = some v := by
  simp [collapse]

-- ============================================================
-- 11. Conservativity (Axiom 6) — stated as a metatheorem
-- ============================================================

/-
  Axiom 6 (Conservativity): For every sentence φ in the language of ZFC,
    TIF ⊢ φ  →  ZFC ⊢ φ.

  This is a metatheoretic statement about the proof system and cannot
  be directly expressed as a Lean 4 theorem without embedding both
  proof systems. The proof sketch is:

    (1) Construct a model M ⊨ ZFC.
    (2) Extend it to M_I by adding I_0 as a fresh urelement.
    (3) The extension table ensures every L_ZFC-sentence has the same
        truth value in M and M_I.
    (4) Hence no new L_ZFC-theorems are produced.

  A full formalization of this argument requires a Lean 4 model theory
  library (e.g., a future Mathlib4 chapter on set-theoretic semantics).
  This is marked as a TODO for Paper P1 in the paper program.
-/

end TIF
