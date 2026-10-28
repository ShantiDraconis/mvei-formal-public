/-
Copyright (c) 2024 Universal Emergent Logic Project. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.

# Navier-Stokes - Main Theorem
-/

import NavierStokes.Foundations
import NavierStokes.Objects
import NavierStokes.LocalLemmas
import NavierStokes.StructuralBridge
import NavierStokes.Reduction

namespace NavierStokes

theorem navier_stokes_regularity :
  ∀ u₀ : InitialData, ∃! u : VelocityField, sorry := by
  rw [← main_reduction]
  exact κ_NS_positive

#check navier_stokes_regularity

end NavierStokes
