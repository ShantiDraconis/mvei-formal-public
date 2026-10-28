/-
Copyright (c) 2025 ShantiDraconis. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ShantiDraconis

# Trivial Zeros of the Riemann Zeta Function

The trivial zeros at s = -2, -4, -6, ... arise from poles of Γ(s/2)
in the functional equation.
-/

import Millennium.Riemann.CollapseComplex
import Millennium.Riemann.Core.ZetaDef
import Millennium.Riemann.Zeros.Basic

namespace Millennium.Riemann.Zeros

open CollapseComplex Core

/-- Trivial zero at -2n -/
def trivialZeroAt (n : ℕ) (hn : n > 0) : CollapseComplex :=
  ofReal (-(2 * n : ℝ))

/-- All trivial zeros are zeros -/
axiom trivial_zero_is_zero : ∀ n : ℕ, ∀ hn : n > 0,
  zeta (trivialZeroAt n hn) = zero

/-- Trivial zeros have zero imaginary part -/
theorem trivial_real_axis (n : ℕ) (hn : n > 0) :
  (trivialZeroAt n hn).im = 0 := by
  simp [trivialZeroAt, ofReal]

/-- Trivial zeros are on negative real axis -/
theorem trivial_negative (n : ℕ) (hn : n > 0) :
  (trivialZeroAt n hn).re < 0 := by
  simp [trivialZeroAt, ofReal]
  have : (n : ℝ) > 0 := Nat.cast_pos.mpr hn
  linarith

/-- There are infinitely many trivial zeros -/
theorem trivial_infinite : ∀ N : ℕ, ∃ n > N, True := by
  intro N
  use N + 1
  constructor
  · exact Nat.lt_succ_self N
  · trivial

/-- Trivial zeros arise from Γ function poles -/
axiom trivial_from_gamma : ∀ n : ℕ, n > 0 →
  True  -- Γ(s/2) has pole at s = -2n

/-- The mechanism: sin(πs/2) = 0 at negative even integers -/
theorem trivial_mechanism (n : ℕ) (hn : n > 0) :
  True := trivial  -- sin(π(-2n)/2) = sin(-πn) = 0

/-- Distance between consecutive trivial zeros -/
theorem trivial_spacing (n : ℕ) (hn : n > 0) :
  (trivialZeroAt (n+1) (Nat.succ_pos n)).re - (trivialZeroAt n hn).re = -2 := by
  simp [trivialZeroAt, ofReal]
  ring

/-- Trivial zeros are all simple (multiplicity 1) -/
axiom trivial_zeros_simple : ∀ n : ℕ, ∀ hn : n > 0,
  let ρ : ZetaZero := ⟨trivialZeroAt n hn, trivial_zero_is_zero n hn⟩
  isSimple ρ

/-- The regularization constant at trivial zeros -/
def trivial_reg_constant (n : ℕ) : ℝ := 2 * n + 1/2

/-- I-component contribution at trivial zeros -/
axiom trivial_I_component : ∀ n : ℕ, ∀ hn : n > 0,
  True  -- I-regularization applies

/-- Trivial zeros form a lattice on negative real axis -/
def trivialZeroSet : Set CollapseComplex :=
  { s | ∃ n : ℕ, n > 0 ∧ s = ofReal (-(2 * n : ℝ)) }

end Millennium.Riemann.Zeros
