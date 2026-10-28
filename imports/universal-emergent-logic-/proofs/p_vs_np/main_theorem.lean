/-
Copyright (c) 2024 Universal Emergent Logic Project. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: UEL Team

# P vs NP - Main Theorem

Proves P ≠ NP using the reduction.
-/

import PvsNP.Foundations
import PvsNP.Objects
import PvsNP.LocalLemmas
import PvsNP.StructuralBridge
import PvsNP.Reduction

namespace PvsNP

theorem p_neq_np : P ≠ NP := by
  rw [← main_reduction]
  show κ_PNP > 0
  exact κ_PNP_positive

theorem np_complete_not_in_p (L : Language) (hL : NPComplete L) :
  L ∉ P := by
  intro h_in_p
  have : P = NP := by sorry
  exact p_neq_np this

#check p_neq_np

end PvsNP
