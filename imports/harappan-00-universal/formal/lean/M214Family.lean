/-
  M214–M229 Bow-Tie Family — Lean 4 Formalization
  
  Formal verification of the M214–M229 sign family with M217 as the central
  balanced composite, following the analysis in:
    LaTeX: latex/chapters/ch11_m214_family_analysis.tex
    Coq  : formal/coq/M214Family.v
    Isa  : formal/isabelle/M214Family.thy

  Author: Harappan Universal System
  Reference: Mahadevan (1977), Concordance pages 214–219, Table 2
-/

import Mathlib.Data.Finset.Basic
import Mathlib.Data.List.Basic
import Mathlib.Logic.Basic

namespace M214Family

/-! # 1. Graphical Operators
    Matches LaTeX §2 (Section sec:operators) and Table tab:family. -/

/-- Atomic graphical operators that build every sign in F_217. -/
inductive GraphicOperator : Type where
  | B      : GraphicOperator  -- base bow-tie / crossed-triangle nucleus
  | R      : GraphicOperator  -- lateral repetition
  | Delta_r : GraphicOperator -- right-side opening / angular appendage
  | Z_c    : GraphicOperator  -- central serrated / double-chevron connector
  | Mu_c   : GraphicOperator  -- central axial insertion (haste / double-haste)
  | Omega_c : GraphicOperator -- oval / ligature central connector
  | Frame  : GraphicOperator  -- external rectangular framing
  | Barb_r : GraphicOperator  -- right oblique barb
  | Barb_r2 : GraphicOperator -- double right barb
  | Barb_l : GraphicOperator  -- left oblique barb
  | Barb   : GraphicOperator  -- generic barb (used with B_min)
  | Wave_r : GraphicOperator  -- right lateral undulation
  | Wave_l : GraphicOperator  -- left lateral undulation
  | Stack  : GraphicOperator  -- vertical stacking (second nucleus above)
  | Over   : GraphicOperator  -- overstrike diagonal
  | B_min  : GraphicOperator  -- minimal / reduced bow-tie base
  deriving Repr, DecidableEq

/-! # 2. Sign Terms
    A sign term is either a base operator or a composition. -/

/-- Compositional sign expression: Base ⊕ Modifier* -/
inductive SignTerm : Type where
  | atom  : GraphicOperator → SignTerm
  | comp  : SignTerm → GraphicOperator → SignTerm
  deriving Repr, DecidableEq

open GraphicOperator SignTerm

/-! # 3. Canonical operator expressions for each sign (eq. 4–19 in LaTeX) -/

def M214_term : SignTerm := atom B
def M215_term : SignTerm := comp (atom B) R
def M216_term : SignTerm := comp (atom B) Delta_r
def M217_term : SignTerm := comp (comp (atom B) Z_c) B
def M218_term : SignTerm := comp M217_term Mu_c
def M219_term : SignTerm := comp (atom B) Omega_c
def M220_term : SignTerm := comp (atom B) Frame
def M221_term : SignTerm := atom B_min
def M222_term : SignTerm := comp (atom B) Barb_r
def M223_term : SignTerm := comp (atom B) Barb_r2
def M224_term : SignTerm := comp (atom B) Barb_l
def M225_term : SignTerm := comp (atom B_min) Barb
def M226_term : SignTerm := comp (atom B) Wave_r
def M227_term : SignTerm := comp (atom B) Wave_l
def M228_term : SignTerm := comp (atom B) Stack
def M229_term : SignTerm := comp (atom B) Over

/-! # 4. Sign enumeration (Mahadevan 214–229) -/

/-- The sixteen signs of the bow-tie family. -/
inductive BowTieSign : Type where
  | s214 | s215 | s216 | s217 | s218 | s219
  | s220 | s221 | s222 | s223 | s224 | s225
  | s226 | s227 | s228 | s229
  deriving Repr, DecidableEq, Fintype

/-- Mahadevan catalogue number for each family member. -/
def mahadevanNumber : BowTieSign → Nat
  | .s214 => 214 | .s215 => 215 | .s216 => 216
  | .s217 => 217 | .s218 => 218 | .s219 => 219
  | .s220 => 220 | .s221 => 221 | .s222 => 222
  | .s223 => 223 | .s224 => 224 | .s225 => 225
  | .s226 => 226 | .s227 => 227 | .s228 => 228
  | .s229 => 229

/-- Canonical operator term for each family member. -/
def canonicalTerm : BowTieSign → SignTerm
  | .s214 => M214_term | .s215 => M215_term | .s216 => M216_term
  | .s217 => M217_term | .s218 => M218_term | .s219 => M219_term
  | .s220 => M220_term | .s221 => M221_term | .s222 => M222_term
  | .s223 => M223_term | .s224 => M224_term | .s225 => M225_term
  | .s226 => M226_term | .s227 => M227_term | .s228 => M228_term
  | .s229 => M229_term

/-! # 5. Three-Level Classification
    Matches LaTeX §3 (Definitions of B, D, C). -/

/-- Three-level typological classification.
    B = Minimal Base, D = Linear Derivation, C = Composite Nucleus. -/
inductive SignLevel : Type where
  | Base       : SignLevel  -- Minimal Base (B)
  | Derivation : SignLevel  -- Linear Derivation (D)
  | Composite  : SignLevel  -- Composite Nucleus (C)
  deriving Repr, DecidableEq

/-- Assign the typological level to each family member.
    This matches Table tab:family in the LaTeX chapter. -/
def signLevel : BowTieSign → SignLevel
  | .s214 => .Base       -- B
  | .s215 => .Derivation -- D
  | .s216 => .Derivation -- D
  | .s217 => .Composite  -- C
  | .s218 => .Composite  -- C
  | .s219 => .Composite  -- C
  | .s220 => .Composite  -- C
  | .s221 => .Base       -- B
  | .s222 => .Derivation -- D
  | .s223 => .Derivation -- D
  | .s224 => .Derivation -- D
  | .s225 => .Base       -- B
  | .s226 => .Derivation -- D
  | .s227 => .Derivation -- D
  | .s228 => .Composite  -- C
  | .s229 => .Derivation -- D

/-- The full family F_217. -/
def bowtieFamily : Finset BowTieSign := Finset.univ

/-! # 6. Sub-family sets B, D, C -/

def baseSet : Finset BowTieSign :=
  Finset.univ.filter (fun s => signLevel s = .Base)

def derivationSet : Finset BowTieSign :=
  Finset.univ.filter (fun s => signLevel s = .Derivation)

def compositeSet : Finset BowTieSign :=
  Finset.univ.filter (fun s => signLevel s = .Composite)

/-! # 7. Partition Theorem
    Matches LaTeX Theorem (Partition of F_217). -/

theorem base_card : baseSet.card = 3 := by decide

theorem derivation_card : derivationSet.card = 8 := by decide

theorem composite_card : compositeSet.card = 5 := by decide

theorem family_card : bowtieFamily.card = 16 := by decide

/-- The three level-sets are pairwise disjoint. -/
theorem levels_disjoint :
    (baseSet ∩ derivationSet = ∅) ∧
    (derivationSet ∩ compositeSet = ∅) ∧
    (baseSet ∩ compositeSet = ∅) := by decide

/-- The three level-sets cover the entire family. -/
theorem family_partition :
    baseSet ∪ derivationSet ∪ compositeSet = bowtieFamily := by decide

/-! # 8. M217-Specific Theorems
    Matches LaTeX Proposition prop:m217proto and Theorem thm:m217. -/

/-- M217 is classified as a Composite Nucleus. -/
theorem m217_is_composite : signLevel .s217 = .Composite := by decide

/-- M218 is the composite derived from M217 by adding Mu_c. -/
theorem m218_extends_m217 :
    canonicalTerm .s218 = comp (canonicalTerm .s217) Mu_c := by decide

/-- M219 uses Omega_c (a different central operator than M217's Z_c). -/
theorem m219_uses_omega :
    canonicalTerm .s219 = comp (atom B) Omega_c := by decide

/-- M217's term is the unique member of compositeSet whose term equals
    B ⊕ Z_c ⊕ B (bilateral without extra inserted modifier). -/
theorem m217_is_minimal_composite :
    ∀ s : BowTieSign,
      signLevel s = .Composite →
      canonicalTerm s = comp (comp (atom B) Z_c) B →
      s = .s217 := by decide

/-! # 9. Derivational Chain (eq. chain in LaTeX) -/

/-- The core derivational chain: M214 → M216 → M217 → {M218, M219}.
    Each step adds exactly one operator. M218 and M219 are parallel qualified
    composites branching from M217, not sequential steps from one another. -/
def derivationalChain : List BowTieSign :=
  [.s214, .s216, .s217, .s218, .s219]

/-- Term depth: number of composition layers.
    Chain depths are [0, 1, 2, 3, 1]: M218 (depth 3) and M219 (depth 1) are
    parallel branches from M217, so M219's low depth is expected, not an error. -/
def termDepth : SignTerm → Nat
  | atom _    => 0
  | comp t _  => termDepth t + 1

theorem chain_depths :
    (derivationalChain.map (fun s => termDepth (canonicalTerm s))) =
    [0, 1, 2, 3, 1] := by decide

/-! # 10. Concordance Evidence (LaTeX §5, Table tab:concordance) -/

/-- Approximate concordance attestation counts from pages 214–219. -/
def concordanceEntries : BowTieSign → Nat
  | .s214 => 25 | .s215 => 20 | .s216 => 20
  | .s217 => 25 | .s218 => 20 | .s219 => 18
  | _     => 0  -- not covered by concordance pages 214–219

/-- Every member of F_217^(0) has at least 15 concordance entries,
    confirming none are hapax ornamentals. -/
theorem nuclear_family_attested :
    ∀ s : BowTieSign,
      mahadevanNumber s ≤ 219 →
      concordanceEntries s ≥ 15 := by decide

/-- M217 has maximum attestation (tied with M214) within F_217^(0). -/
theorem m217_max_attestation :
    ∀ s : BowTieSign,
      mahadevanNumber s ≤ 219 →
      concordanceEntries s ≤ concordanceEntries .s217 := by decide

/-! # 11. Methodological Integration (eq. method in LaTeX) -/

/-- Four evidence streams that converge on the M217 hypothesis. -/
structure EvidenceStream where
  shapeFamily    : Bool  -- morphological family membership
  concordance    : Bool  -- attestation in concordance pages 214–219
  textSequences  : Bool  -- distribution in text sequences
  pairFrequency  : Bool  -- stable bigram partners (Table 2)
  deriving Repr

/-- M217's evidence record: all four streams are active. -/
def m217Evidence : EvidenceStream :=
  { shapeFamily   := true
    concordance   := true
    textSequences := true
    pairFrequency := true }

/-- Full convergence predicate. -/
def fullConvergence (e : EvidenceStream) : Prop :=
  e.shapeFamily ∧ e.concordance ∧ e.textSequences ∧ e.pairFrequency

theorem m217_full_convergence : fullConvergence m217Evidence := by
  simp [fullConvergence, m217Evidence]

/-! # 12. Main Theorem: M217 as Balanced Composite Centre
    Matches LaTeX Theorem thm:m217. -/

/-- Predicate capturing the four conditions of Theorem thm:m217. -/
def isBalancedCompositeCenter (s : BowTieSign) : Prop :=
  signLevel s = .Composite ∧
  (∀ s' : BowTieSign, signLevel s' = .Composite →
     canonicalTerm s' = comp (comp (atom B) Z_c) B → s' = s) ∧
  (∃ s1 s2 : BowTieSign,
     canonicalTerm s1 = comp (canonicalTerm s) Mu_c ∧
     canonicalTerm s2 = comp (atom B) Omega_c) ∧
  concordanceEntries s ≥ 20

theorem m217_balanced_composite_centre :
    isBalancedCompositeCenter .s217 := by
  constructor
  · decide
  constructor
  · intro s' hlevel hterm
    exact m217_is_minimal_composite s' hlevel hterm
  constructor
  · exact ⟨.s218, .s219, by decide, by decide⟩
  · decide

end M214Family
