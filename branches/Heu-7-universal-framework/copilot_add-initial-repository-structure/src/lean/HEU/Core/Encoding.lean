/-
  HEU-7 Framework: Encoding Schemes
  
  This module provides encoding functions for various
  mathematical objects as natural numbers or sequences.
-/

namespace HEU.Core

/-- Encoded sequence type: maps indices to values -/
def Encoded := Nat → Nat

/-- Encoded pair using Cantor pairing function -/
def pair (a b : Nat) : Nat :=
  (a + b) * (a + b + 1) / 2 + b

/-- First projection of Cantor pair -/
def unpair_fst (n : Nat) : Nat :=
  let w := (Nat.sqrt (8 * n + 1) - 1) / 2
  let t := (w * w + w) / 2
  w - (n - t)

/-- Second projection of Cantor pair -/
def unpair_snd (n : Nat) : Nat :=
  let w := (Nat.sqrt (8 * n + 1) - 1) / 2
  let t := (w * w + w) / 2
  n - t

/-- Encoding of rational numbers as pairs -/
structure EncodedRational where
  num : Int
  den : Nat
  den_pos : den > 0

/-- Encoding of complex numbers as pairs of rationals -/
structure EncodedComplex where
  re : EncodedRational
  im : EncodedRational

/-- Encoding of finite sequences -/
def FiniteSeq (n : Nat) := Fin n → Nat

/-- Encoding of polynomials as coefficient sequences -/
def EncodedPolynomial := List Int

end HEU.Core
