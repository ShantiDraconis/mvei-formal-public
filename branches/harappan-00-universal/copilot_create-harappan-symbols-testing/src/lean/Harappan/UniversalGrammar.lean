/-
  Harappan Universal Grammar
  
  Formal model of a universal grammar framework that could
  underlie the Harappan language.
-/

import Harappan.BasicTypes
import Harappan.Phonology
import Harappan.Phonotactics
import Harappan.Semantics

namespace Harappan.UniversalGrammar

open Harappan
open Harappan.Phonology
open Harappan.Phonotactics
open Harappan.Semantics

/-- Word class in the grammar -/
inductive WordClass
  | noun
  | verb
  | adjective
  | determiner
  | particle
  | suffix
  | prefix
  deriving DecidableEq, Repr

/-- Grammatical function -/
inductive GrammaticalFunction
  | subject
  | object
  | predicate
  | modifier
  | complement
  deriving DecidableEq, Repr

/-- A word in the grammar -/
structure Word where
  signs : List SignId
  word_class : WordClass
  meaning : String
  deriving Repr

/-- A phrase structure rule -/
inductive PhraseRule
  | NP_Det_N   -- NP → Det N
  | NP_N       -- NP → N
  | VP_V_NP    -- VP → V NP
  | VP_V       -- VP → V
  | S_NP_VP    -- S → NP VP
  deriving DecidableEq, Repr

/-- A phrase in the grammar -/
inductive Phrase
  | word (w : Word)
  | np (det : Option Phrase) (n : Phrase)
  | vp (v : Phrase) (obj : Option Phrase)
  | s (subj : Phrase) (pred : Phrase)
  deriving Repr

/-- Check if a phrase is well-formed -/
def well_formed : Phrase → Bool
  | .word _ => true
  | .np _ n => well_formed n
  | .vp v obj => well_formed v ∧ (obj.map well_formed).getD true
  | .s subj pred => well_formed subj ∧ well_formed pred

/-- A complete grammar -/
structure Grammar where
  words : List Word
  rules : List PhraseRule
  deriving Repr

/-- Default Harappan grammar rules (hypothetical) -/
def default_rules : List PhraseRule := [
  .NP_Det_N,
  .NP_N,
  .VP_V_NP,
  .VP_V,
  .S_NP_VP
]

/-- Check if a word class can start a phrase -/
def can_start_phrase (wc : WordClass) : Bool :=
  match wc with
  | .determiner => true
  | .noun => true
  | .verb => true
  | _ => false

/-- Universal grammar constraints -/
structure UniversalConstraints where
  -- Every language has nouns and verbs
  has_nouns : Bool
  has_verbs : Bool
  -- Phrase structure is recursive
  allows_recursion : Bool
  -- Word order is consistent
  word_order : String  -- "SOV", "SVO", etc.
  deriving Repr

/-- Hypothesized Harappan universal constraints -/
def harappan_constraints : UniversalConstraints := {
  has_nouns := true
  has_verbs := true
  allows_recursion := true
  word_order := "SOV"  -- Typical for South Asian languages
}

/-- Map a sign to its likely word class based on position -/
def infer_word_class (pos : Position) : WordClass :=
  match pos with
  | .initial => .determiner
  | .medial => .noun
  | .final => .suffix

/-- Theorem: Every grammar has at least the base rules -/
theorem grammar_has_base_rules : 
  ∀ g : Grammar, g.rules = default_rules → g.rules.length = 5 := by
  intro g h
  simp [h, default_rules]

/-- Theorem: Well-formed words are well-formed phrases -/
theorem word_is_well_formed (w : Word) : well_formed (.word w) = true := by
  simp [well_formed]

/-- An interpretation assigns meanings to signs -/
structure Interpretation where
  sign_meanings : List (SignId × String)
  phrase_meanings : List (Phrase × String)
  deriving Repr

/-- Compositionality: phrase meaning from part meanings -/
def compose_meaning (p : Phrase) (interp : Interpretation) : Option String :=
  match p with
  | .word w => some w.meaning
  | .np det n => 
    let n_meaning := compose_meaning n interp
    match det with
    | none => n_meaning
    | some d => 
      let d_meaning := compose_meaning d interp
      match d_meaning, n_meaning with
      | some dm, some nm => some (dm ++ " " ++ nm)
      | _, _ => none
  | .vp v obj =>
    let v_meaning := compose_meaning v interp
    match obj with
    | none => v_meaning
    | some o =>
      let o_meaning := compose_meaning o interp
      match v_meaning, o_meaning with
      | some vm, some om => some (vm ++ " " ++ om)
      | _, _ => none
  | .s subj pred =>
    let s_meaning := compose_meaning subj interp
    let p_meaning := compose_meaning pred interp
    match s_meaning, p_meaning with
    | some sm, some pm => some (sm ++ " " ++ pm)
    | _, _ => none

end Harappan.UniversalGrammar
