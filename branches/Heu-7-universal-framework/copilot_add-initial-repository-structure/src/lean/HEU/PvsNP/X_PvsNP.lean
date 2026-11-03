/-
  HEU-7 Framework: P vs NP - Domain Space
  
  This module defines X_PvsNP, the space of Boolean circuits
  representing computational problems.
-/

import HEU.Core.Encoding

namespace HEU.PvsNP

/-- Boolean circuit gate types -/
inductive Gate
  | Input (n : Nat)
  | And (left right : Nat)
  | Or (left right : Nat)
  | Not (input : Nat)
  | Output (input : Nat)

/-- A Boolean circuit is a sequence of gates -/
structure Circuit where
  /-- Number of input bits -/
  inputSize : Nat
  /-- The gates in topological order -/
  gates : List Gate
  /-- Number of output bits -/
  outputSize : Nat

/-- Circuit size (number of gates) -/
def Circuit.size (c : Circuit) : Nat := c.gates.length

/-- Circuit depth (placeholder) -/
def Circuit.depth (c : Circuit) : Nat := c.gates.length

/-- The domain space for P vs NP: pairs of (problem, circuit family) -/
def X_PvsNP := Nat → Circuit

/-- A language (decision problem) encoded as a predicate on inputs -/
def Language := List Bool → Bool

/-- NP: languages decidable by polynomial-time verifiers -/
def NP (L : Language) : Prop :=
  ∃ (V : Language) (p : Nat → Nat), 
    ∀ x, L x = true ↔ ∃ w, V (x ++ w) = true

/-- P: languages decidable by polynomial-size circuits -/
def P (L : Language) : Prop :=
  ∃ (f : Nat → Circuit), ∀ n, (f n).size ≤ n * n

/-- P ≠ NP statement -/
def PneNP : Prop := ∃ L, NP L ∧ ¬P L

end HEU.PvsNP
