/-
Copyright (c) 2024 Universal Emergent Logic Project. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: UEL Team

# P vs NP - Reduction

Reduces P≠NP to checking κ_PNP > 0
-/

import PvsNP.Foundations
import PvsNP.Objects
import PvsNP.LocalLemmas
import PvsNP.StructuralBridge

namespace PvsNP

theorem pnp_reduces_to_curvature : (P ≠ NP) ↔ κ_PNP > 0 :=
  bridge_pnp_to_curvature

theorem main_reduction : (P ≠ NP) ↔ Ω_PNP > 0 :=
  pnp_reduces_to_curvature

end PvsNP
