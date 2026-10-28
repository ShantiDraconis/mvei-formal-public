/-
  MetaMillennium.Models.ZFCAbstract
  Abstract ZFC as a theory
-/

import MetaMillennium.Core.TheoryAndModel

namespace MetaMillennium.Models

open MetaMillennium.Core

/-- ZFC Axiom names -/
inductive ZFCAxiom where
  | extensionality
  | emptySet
  | pairing
  | union
  | powerSet
  | infinity
  | separation
  | replacement
  | foundation
  | choice
  deriving Repr, BEq

/-- Convert ZFC axiom to sentence (abstract) -/
def ZFCAxiom.toSentence (ax : ZFCAxiom) : Sentence :=
  match ax with
  | extensionality => { id := 101, repr := "∀x∀y(∀z(z∈x ↔ z∈y) → x=y)" }
  | emptySet => { id := 102, repr := "∃x∀y(y∉x)" }
  | pairing => { id := 103, repr := "∀x∀y∃z(x∈z ∧ y∈z)" }
  | union => { id := 104, repr := "∀x∃y∀z(z∈y ↔ ∃w(w∈x ∧ z∈w))" }
  | powerSet => { id := 105, repr := "∀x∃y∀z(z∈y ↔ z⊆x)" }
  | infinity => { id := 106, repr := "∃x(∅∈x ∧ ∀y(y∈x → y∪{y}∈x))" }
  | separation => { id := 107, repr := "∀x∃y∀z(z∈y ↔ z∈x ∧ φ(z))" }
  | replacement => { id := 108, repr := "∀x(∀y∈x ∃!z φ(y,z) → ∃w∀y∈x ∃z∈w φ(y,z))" }
  | foundation => { id := 109, repr := "∀x(x≠∅ → ∃y∈x(y∩x=∅))" }
  | choice => { id := 110, repr := "∀x(∅∉x → ∃f:x→⋃x ∀A∈x f(A)∈A)" }

/-- Full ZFC theory -/
def ZFC_full : Theory := {
  name := "ZFC"
  axioms := [
    ZFCAxiom.extensionality.toSentence,
    ZFCAxiom.emptySet.toSentence,
    ZFCAxiom.pairing.toSentence,
    ZFCAxiom.union.toSentence,
    ZFCAxiom.powerSet.toSentence,
    ZFCAxiom.infinity.toSentence,
    ZFCAxiom.separation.toSentence,
    ZFCAxiom.replacement.toSentence,
    ZFCAxiom.foundation.toSentence,
    ZFCAxiom.choice.toSentence
  ]
}

/-- ZF (without choice) -/
def ZF : Theory := {
  name := "ZF"
  axioms := ZFC_full.axioms.filter (· ≠ ZFCAxiom.choice.toSentence)
}

/-- V = L axiom -/
def VeqL : Sentence := { id := 200, repr := "V = L" }

/-- Continuum Hypothesis -/
def CH : Sentence := { id := 201, repr := "2^ℵ₀ = ℵ₁" }

/-- Generalized Continuum Hypothesis -/
def GCH : Sentence := { id := 202, repr := "∀κ(2^κ = κ⁺)" }

end MetaMillennium.Models
