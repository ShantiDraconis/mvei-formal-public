/-
  HEU-7 Framework: Critical Level Definitions
  
  This module defines the critical ordinals for each Millennium Problem.
-/

import HEU.Core.Ordinals

namespace HEU.Core

/-- Critical ordinal for the Riemann Hypothesis: 1 (simple zeros) -/
def α_RH : Ordinal := 1

/-- Critical ordinal for P vs NP: ω (polynomial time) -/
def α_PNP : Ordinal := omega

/-- Critical ordinal for Navier-Stokes: ω (finite blow-up) -/
def α_NS : Ordinal := omega

/-- Critical ordinal for Hodge Conjecture: ω (finite algebraic degree) -/
def α_Hodge : Ordinal := omega

/-- Critical ordinal for Yang-Mills: 1 (positive mass gap) -/
def α_YM : Ordinal := 1

/-- 
  BSD is special: the critical ordinal depends on the curve.
  For curve E, α_BSD(E) = algebraic rank of E(ℚ).
  We model this as a function.
-/
def α_BSD (rank : ℕ) : Ordinal := rank

/-- Most HEU problems have critical ordinal 1 or ω -/
inductive CriticalType
  | one       -- Binary (RH, YM)
  | omega     -- Finite/Infinite (P vs NP, NS, Hodge)
  | variable  -- Depends on object (BSD)

def criticalTypeOf : String → CriticalType
  | "RH" => CriticalType.one
  | "YM" => CriticalType.one
  | "PNP" => CriticalType.omega
  | "NS" => CriticalType.omega
  | "Hodge" => CriticalType.omega
  | "BSD" => CriticalType.variable
  | _ => CriticalType.omega

end HEU.Core
