/-
  HEU-7: Critical Levels
  Definitions of critical ordinal levels for each problem.
-/

import HEU.Core.Ordinals

namespace HEU.Core

/-- Critical level for Riemann Hypothesis: λ_RH = 0. -/
def λ_RH : Ord := 0

/-- Critical level for P vs NP: λ_PNP = ω^ω. -/
def λ_PNP : Ord := omega_omega

/-- Critical level for Navier-Stokes: λ_NS = ω₁. -/
noncomputable def λ_NS : Ord := omega_one

/-- Critical level for BSD: λ_BSD = 0. -/
def λ_BSD : Ord := 0

/-- Critical level for Hodge: λ_Hodge = ω. -/
def λ_Hodge : Ord := omega

/-- Critical level for Yang-Mills: λ_YM = 0⁺ (any positive value). -/
-- Note: This is represented as a positive condition rather than a specific ordinal.
def λ_YM : Ord := 1  -- Representing "any positive value"

/-- Summary of all critical levels. -/
structure CriticalLevels where
  rh : Ord := λ_RH
  pnp : Ord := λ_PNP
  ns : Ord := λ_NS
  bsd : Ord := λ_BSD
  hodge : Ord := λ_Hodge
  ym : Ord := λ_YM

/-- Default critical levels instance. -/
noncomputable def defaultCriticalLevels : CriticalLevels := {}

end HEU.Core
