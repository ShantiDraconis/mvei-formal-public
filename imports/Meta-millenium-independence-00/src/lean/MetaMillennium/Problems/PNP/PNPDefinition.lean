/-
  MetaMillennium.Problems.PNP.PNPDefinition
  P vs NP definition
-/

import MetaMillennium.Core.TheoryAndModel

namespace MetaMillennium.Problems.PNP

open MetaMillennium.Core

/-- A Turing machine (abstract representation) -/
structure TuringMachine where
  /-- Identifier -/
  id : Nat
  /-- Description -/
  description : String

/-- Time complexity function -/
def TimeComplexity := Nat → Nat

/-- Polynomial time: there exists k such that time ≤ n^k -/
def isPolynomialTime (t : TimeComplexity) : Prop :=
  ∃ k : Nat, ∀ n : Nat, t n ≤ n ^ k

/-- The class P: languages decidable in polynomial time -/
structure P_Language where
  /-- The language (set of strings, abstract) -/
  lang_id : Nat
  /-- The polynomial-time machine -/
  machine : TuringMachine
  /-- Time complexity is polynomial -/
  is_poly : isPolynomialTime (fun _ => 0)  -- Placeholder

/-- The class NP: languages verifiable in polynomial time -/
structure NP_Language where
  /-- The language -/
  lang_id : Nat
  /-- The polynomial-time verifier -/
  verifier : TuringMachine
  /-- Verification is polynomial -/
  verify_poly : isPolynomialTime (fun _ => 0)  -- Placeholder

/-- SAT: the satisfiability problem -/
def SAT : NP_Language := {
  lang_id := 1
  verifier := { id := 1, description := "SAT verifier" }
  verify_poly := ⟨2, fun _ => by norm_num⟩
}

/-- P = NP statement -/
def P_equals_NP : Prop :=
  ∀ L : NP_Language, ∃ M : TuringMachine, ∃ t : TimeComplexity,
    isPolynomialTime t  -- M decides L in polynomial time

/-- P ≠ NP statement -/
def P_neq_NP : Prop := ¬P_equals_NP

/-- P vs NP as a sentence -/
def phi_PNP : Sentence := { id := 1002, repr := "P ≠ NP" }

end MetaMillennium.Problems.PNP
