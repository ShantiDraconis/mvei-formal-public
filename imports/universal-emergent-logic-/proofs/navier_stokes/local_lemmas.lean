/-
Copyright (c) 2024 Universal Emergent Logic Project. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.

# Navier-Stokes - Local Lemmas
-/

import NavierStokes.Foundations
import NavierStokes.Objects

namespace NavierStokes

lemma κ_NS_positive : κ_NS > 0 := by sorry

lemma energy_inequality (u : VelocityField) (t : ℝ) :
  EnergyTransferRate u t ≥ κ_NS - Dissipation u t := by sorry

lemma cubic_obstruction (u : VelocityField) (t : ℝ) :
  ∃ C > 0, sorry := by sorry

end NavierStokes
