/-
Copyright (c) 2024 Universal Emergent Logic Project. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.

# Navier-Stokes - Objects
-/

import NavierStokes.Foundations

namespace NavierStokes

noncomputable def κ_NS : ℝ := sorry  -- Energy transfer curvature
noncomputable def Residue (u : VelocityField) : ℝ := sorry
noncomputable def EnergyTransferRate (u : VelocityField) (t : ℝ) : ℝ := sorry
noncomputable def Dissipation (u : VelocityField) (t : ℝ) : ℝ := sorry
noncomputable def Ω_NS : ℝ := κ_NS  -- Main obstruction

axiom κ_NS_welldefined : κ_NS ≥ 0

end NavierStokes
