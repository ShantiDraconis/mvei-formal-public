/- 
  FormalSuite/I/MultiStateEncodings.lean

  Equivalent Lean encodings of the three-state kernel and its certificate
  boundary.  The purpose is to make the same semantics available as:
  inductive data, Option Bool, transition relations, Boolean adjacency,
  bit encodings, dependent certificates, existential propositions, and
  generic semantic producers.

  No axioms. No sorry.
-/

import FormalSuite.I.MultiStateKernel

namespace FormalSuite.IMultiState

universe u v

/-! ## Equivalent finite-data encodings -/

/-- Three states encoded as the three inhabitants of `Option Bool`. -/
def toOptionBool : Phase → Option Bool
  | Phase.seed => none
  | Phase.transit => some false
  | Phase.manifest => some true

/-- Decode the `Option Bool` representation. -/
def ofOptionBool : Option Bool → Phase
  | none => Phase.seed
  | some false => Phase.transit
  | some true => Phase.manifest

@[simp] theorem ofOptionBool_toOptionBool (p : Phase) :
    ofOptionBool (toOptionBool p) = p := by
  cases p <;> rfl

@[simp] theorem toOptionBool_ofOptionBool (x : Option Bool) :
    toOptionBool (ofOptionBool x) = x := by
  cases x with
  | none => rfl
  | some b =>
      cases b <;> rfl

/-- Explicit equivalence between the inductive encoding and `Option Bool`. -/
def phaseEquivOptionBool : Phase ≃ Option Bool where
  toFun := toOptionBool
  invFun := ofOptionBool
  left_inv := ofOptionBool_toOptionBool
  right_inv := toOptionBool_ofOptionBool

/-! ## Relational encoding -/

/-- The same three-cycle expressed as an inductive binary relation. -/
inductive Step : Phase → Phase → Prop where
  | seed_transit : Step Phase.seed Phase.transit
  | transit_manifest : Step Phase.transit Phase.manifest
  | manifest_seed : Step Phase.manifest Phase.seed

/-- The relational transition is exactly the functional rotation. -/
theorem step_iff_eq_rotate {a b : Phase} :
    Step a b ↔ b = rotate a := by
  constructor
  · intro h
    cases h <;> rfl
  · intro h
    cases a with
    | seed =>
        simp [rotate] at h
        subst b
        exact Step.seed_transit
    | transit =>
        simp [rotate] at h
        subst b
        exact Step.transit_manifest
    | manifest =>
        simp [rotate] at h
        subst b
        exact Step.manifest_seed

/-- The transition relation is deterministic. -/
theorem step_deterministic {a b c : Phase}
    (hab : Step a b) (hac : Step a c) :
    b = c := by
  calc
    b = rotate a := step_iff_eq_rotate.mp hab
    _ = c := (step_iff_eq_rotate.mp hac).symm

/-- Every phase has exactly one outgoing transition. -/
theorem step_total (a : Phase) : ∃ b, Step a b := by
  exact ⟨rotate a, step_iff_eq_rotate.mpr rfl⟩

/-! ## Boolean adjacency encoding -/

/-- Boolean adjacency matrix entry for the deterministic transition graph. -/
def edge (a b : Phase) : Bool :=
  decide (b = rotate a)

@[simp] theorem edge_rotate (a : Phase) :
    edge a (rotate a) = true := by
  simp [edge]

/-- A true Boolean edge decodes to the propositional transition fact. -/
theorem edge_sound {a b : Phase} (h : edge a b = true) :
    Step a b := by
  apply step_iff_eq_rotate.mpr
  simpa [edge] using h

/-- Every relational transition is accepted by the Boolean adjacency checker. -/
theorem edge_complete {a b : Phase} (h : Step a b) :
    edge a b = true := by
  have hb : b = rotate a := step_iff_eq_rotate.mp h
  simp [edge, hb]

/-! ## Two-bit encoding -/

/-- Two physical/logical bits can encode the three valid states plus one invalid code. -/
abbrev Bits2 := Bool × Bool

def encodeBits : Phase → Bits2
  | Phase.seed => (false, false)
  | Phase.transit => (false, true)
  | Phase.manifest => (true, false)

def decodeBits : Bits2 → Option Phase
  | (false, false) => some Phase.seed
  | (false, true) => some Phase.transit
  | (true, false) => some Phase.manifest
  | (true, true) => none

@[simp] theorem decodeBits_encodeBits (p : Phase) :
    decodeBits (encodeBits p) = some p := by
  cases p <;> rfl

/-- The unused two-bit code is explicitly rejected. -/
@[simp] theorem decodeBits_invalid :
    decodeBits (true, true) = none := rfl

def ValidBits (b : Bits2) : Prop :=
  decodeBits b ≠ none

theorem encodeBits_valid (p : Phase) :
    ValidBits (encodeBits p) := by
  cases p <;> simp [ValidBits, encodeBits, decodeBits]

/-! ## One-hot encoding -/

structure OneHot3 where
  seedBit : Bool
  transitBit : Bool
  manifestBit : Bool
  deriving DecidableEq, Repr

def oneHot : Phase → OneHot3
  | Phase.seed => ⟨true, false, false⟩
  | Phase.transit => ⟨false, true, false⟩
  | Phase.manifest => ⟨false, false, true⟩

def OneHotValid (x : OneHot3) : Prop :=
  (x.seedBit = true ∧ x.transitBit = false ∧ x.manifestBit = false) ∨
  (x.seedBit = false ∧ x.transitBit = true ∧ x.manifestBit = false) ∨
  (x.seedBit = false ∧ x.transitBit = false ∧ x.manifestBit = true)

theorem oneHot_valid (p : Phase) :
    OneHotValid (oneHot p) := by
  cases p <;> simp [OneHotValid, oneHot]

/-! ## Certificate encodings -/

/-- The certificate as a dependent subtype. -/
abbrev WitnessSubtype (α : Type u) (check : α → Bool) :=
  {x : α // check x = true}

/-- Convert the structure certificate to the subtype certificate. -/
def certificateToSubtype {α : Type u} {check : α → Bool}
    (c : ManifestCertificate α check) :
    WitnessSubtype α check :=
  ⟨c.witness, c.accepted⟩

/-- Convert the subtype certificate back to the structure certificate. -/
def subtypeToCertificate {α : Type u} {check : α → Bool}
    (c : WitnessSubtype α check) :
    ManifestCertificate α check where
  witness := c.1
  accepted := c.2

@[simp] theorem certificate_roundtrip {α : Type u} {check : α → Bool}
    (c : ManifestCertificate α check) :
    subtypeToCertificate (certificateToSubtype c) = c := by
  cases c
  rfl

@[simp] theorem subtype_roundtrip {α : Type u} {check : α → Bool}
    (c : WitnessSubtype α check) :
    certificateToSubtype (subtypeToCertificate c) = c := by
  cases c
  rfl

/-- Inhabiting the certificate type is equivalent to an existential witness. -/
theorem certificate_nonempty_iff_exists {α : Type u} {check : α → Bool} :
    Nonempty (ManifestCertificate α check) ↔
      ∃ x : α, check x = true := by
  constructor
  · rintro ⟨c⟩
    exact ⟨c.witness, c.accepted⟩
  · rintro ⟨x, hx⟩
    exact ⟨⟨x, hx⟩⟩

/-! ## Exact finite-search specification -/

/-- If finite search returns a witness, that witness came from the input list. -/
theorem findFirst_mem {α : Type u}
    (check : α → Bool) (xs : List α) (x : α)
    (h : findFirst check xs = some x) :
    x ∈ xs := by
  induction xs with
  | nil =>
      simp [findFirst] at h
  | cons y ys ih =>
      cases hcheck : check y with
      | false =>
          have htail : findFirst check ys = some x := by
            simpa [findFirst, hcheck] using h
          exact List.mem_cons_of_mem y (ih htail)
      | true =>
          have hyx : y = x := by
            simpa [findFirst, hcheck] using h
          subst x
          simp

/-- Search failure is exactly the statement that every listed candidate is rejected. -/
theorem findFirst_none_iff {α : Type u}
    (check : α → Bool) (xs : List α) :
    findFirst check xs = none ↔
      ∀ x ∈ xs, check x = false := by
  induction xs with
  | nil =>
      simp [findFirst]
  | cons y ys ih =>
      cases hcheck : check y with
      | false =>
          simp [findFirst, hcheck, ih]
      | true =>
          simp [findFirst, hcheck]

/-- Exact finite-search contract: success iff an accepted list member exists. -/
theorem findFirst_exists_iff {α : Type u}
    (check : α → Bool) (xs : List α) :
    (∃ x, findFirst check xs = some x) ↔
      ∃ x, x ∈ xs ∧ check x = true := by
  constructor
  · rintro ⟨x, hx⟩
    exact ⟨x, findFirst_mem check xs x hx, findFirst_sound check xs x hx⟩
  · rintro ⟨x, hxmem, hxtrue⟩
    by_contra hnone
    have hnone' : findFirst check xs = none := by
      cases h : findFirst check xs with
      | none => exact h
      | some y =>
          exfalso
          exact hnone ⟨y, h⟩
    have hall := (findFirst_none_iff check xs).mp hnone'
    have hxfalse : check x = false := hall x hxmem
    simp [hxtrue] at hxfalse

/-! ## Generic semantic bridge -/

/--
A domain adapter separates a decidable Boolean checker from the proposition
that the checker is intended to certify.
-/
structure Semantics (α : Type u) where
  check : α → Bool
  Meaning : α → Prop
  sound : ∀ x, check x = true → Meaning x

/--
Run finite search through a semantic adapter and return a proposition-level
witness.  No proposition-level witness is supplied as an input.
-/
def semanticProduce {α : Type u}
    (S : Semantics α) (xs : List α) :
    Option {x : α // S.Meaning x} :=
  match h : findFirst S.check xs with
  | none => none
  | some x =>
      some ⟨x, S.sound x (findFirst_sound S.check xs x h)⟩

/-- Every semantic producer output satisfies the domain proposition by construction. -/
theorem semanticProduce_sound {α : Type u}
    (S : Semantics α) (xs : List α) (w : {x : α // S.Meaning x})
    (h : semanticProduce S xs = some w) :
    S.Meaning w.1 := by
  exact w.2

/-! ## Boolean gate layer -/

def gateNot (a : Bool) : Bool := !a
def gateAnd (a b : Bool) : Bool := a && b
def gateOr (a b : Bool) : Bool := a || b
def gateNand (a b : Bool) : Bool := !(a && b)

@[simp] theorem nand_as_not (a : Bool) :
    gateNand a a = gateNot a := by
  cases a <;> rfl

@[simp] theorem nand_builds_and (a b : Bool) :
    gateNand (gateNand a b) (gateNand a b) = gateAnd a b := by
  cases a <;> cases b <;> rfl

@[simp] theorem nand_builds_or (a b : Bool) :
    gateNand (gateNand a a) (gateNand b b) = gateOr a b := by
  cases a <;> cases b <;> rfl

/-
The kernel boundary can therefore be expressed in Lean as:
finite state data -> deterministic transition -> exact producer ->
dependent certificate -> Boolean checker, while NAND suffices to realize
the final Boolean basis.
-/

end FormalSuite.IMultiState
