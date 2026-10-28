/-
Copyright (c) 2024 Universal Emergent Logic Project. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.

# Navier-Stokes - Reduction
-/

import NavierStokes.Foundations
import NavierStokes.Objects
import NavierStokes.LocalLemmas
import NavierStokes.StructuralBridge

namespace NavierStokes

theorem main_reduction :
  (∀ u₀ : InitialData, ∃! u : VelocityField, sorry) ↔ Ω_NS > 0 :=
  bridge_smoothness_to_curvature

end NavierStokes
