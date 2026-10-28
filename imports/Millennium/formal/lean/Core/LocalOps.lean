/-
  formal/lean/Core/LocalOps.lean
  
  Local operators for each Millennium problem.
  These operators measure deviation within a single domain.
-/

import UMOS.Core.Operators

namespace UMOS.Core.LocalOps

/-- Local operator for Riemann Hypothesis -/
structure RH_LocalOp where
  /-- Deviation from critical line -/
  delta : Float  -- Re(ρ) - 1/2
  /-- Zero identifier -/
  zeroId : Nat
deriving DecidableEq, Repr

/-- Local operator for P vs NP -/
structure NP_LocalOp where
  /-- Complexity gap -/
  delta : Float  -- C_det(L) - C_ndet(L)
  /-- Language identifier -/
  langId : Nat
deriving DecidableEq, Repr

/-- Local operator for Navier-Stokes -/
structure NS_LocalOp where
  /-- Inverse maximal time (0 if global) -/
  delta : Float  -- 1/T_max
  /-- Initial data identifier -/
  dataId : Nat
deriving DecidableEq, Repr

/-- Local operator for Hodge -/
structure H_LocalOp where
  /-- Distance to algebraic -/
  delta : Float
  /-- Class identifier -/
  classId : Nat
deriving DecidableEq, Repr

/-- Local operator for BSD -/
structure BSD_LocalOp where
  /-- Order minus rank -/
  delta : Int  -- ord_{s=1} L(E,s) - rank E(ℚ)
  /-- Curve identifier -/
  curveId : Nat
deriving DecidableEq, Repr

/-- Local operator for Yang-Mills -/
structure YM_LocalOp where
  /-- Mass gap -/
  delta : Float
  /-- Connection identifier -/
  connId : Nat
deriving DecidableEq, Repr

/-- Check if local operator indicates critical state -/
def isCritical (delta : Float) : Bool := delta == 0.0

end UMOS.Core.LocalOps
