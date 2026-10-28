/-
  HEU-7 Universal Framework
  Encodings Module

  This module provides Gödel numbering and other encoding schemes
  for set-theoretic and logical objects. Essential for the
  meta-mathematical analysis in HEU-7.

  Designed for automatic expansion by AI assistants.
-/

import HEU.Core.ZF.Sets
import HEU.Core.ZF.Ordinals

namespace HEU.Core.ZF

/-- Gödel encoding for natural numbers -/
def goedelEncode : Nat → Nat
  | 0 => 1
  | n + 1 => 2 * goedelEncode n

/-- Gödel decoding (partial inverse) -/
def goedelDecode : Nat → Option Nat
  | 1 => some 0
  | n => if n % 2 = 0 then
           match goedelDecode (n / 2) with
           | some m => some (m + 1)
           | none => none
         else none

/-- Pairing function (Cantor pairing) -/
def cantorPair (a b : Nat) : Nat :=
  (a + b) * (a + b + 1) / 2 + b

/-- Unpairing function (left projection) -/
def cantorUnpairLeft (n : Nat) : Nat :=
  let w := (Nat.sqrt (8 * n + 1) - 1) / 2
  let t := w * (w + 1) / 2
  w - (n - t)

/-- Unpairing function (right projection) -/
def cantorUnpairRight (n : Nat) : Nat :=
  let w := (Nat.sqrt (8 * n + 1) - 1) / 2
  let t := w * (w + 1) / 2
  n - t

/-- Encode a list of naturals -/
def encodeList : List Nat → Nat
  | [] => 0
  | x :: xs => cantorPair (x + 1) (encodeList xs)

/-- Decode a natural to a list -/
partial def decodeList : Nat → List Nat
  | 0 => []
  | n =>
    let a := cantorUnpairLeft n
    let b := cantorUnpairRight n
    if a > 0 then (a - 1) :: decodeList b else []

/-- Formula encoding structure -/
inductive Formula where
  | var : Nat → Formula
  | neg : Formula → Formula
  | conj : Formula → Formula → Formula
  | disj : Formula → Formula → Formula
  | impl : Formula → Formula → Formula
  | forall_ : Nat → Formula → Formula
  | exists_ : Nat → Formula → Formula
  deriving Repr, DecidableEq

/-- Encode a formula to a natural number -/
def encodeFormula : Formula → Nat
  | Formula.var n => cantorPair 0 n
  | Formula.neg φ => cantorPair 1 (encodeFormula φ)
  | Formula.conj φ ψ => cantorPair 2 (cantorPair (encodeFormula φ) (encodeFormula ψ))
  | Formula.disj φ ψ => cantorPair 3 (cantorPair (encodeFormula φ) (encodeFormula ψ))
  | Formula.impl φ ψ => cantorPair 4 (cantorPair (encodeFormula φ) (encodeFormula ψ))
  | Formula.forall_ n φ => cantorPair 5 (cantorPair n (encodeFormula φ))
  | Formula.exists_ n φ => cantorPair 6 (cantorPair n (encodeFormula φ))

/-- Set encoding (via characteristic function) -/
def encodeSet (s : HSet Nat) : Nat :=
  encodeList s.elements

/-- Ordinal encoding -/
def encodeOrd (α : Ord) : Nat := α.val

end HEU.Core.ZF
