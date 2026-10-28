/-
UniversalTime.lean

Universal time scales in TUNS.
-/

import TUNS.Framework
import Mathlib.Data.Real.Basic
import Mathlib.Data.Real.EReal

namespace TUNS

/-- Time scale for a framework -/
structure Time (F : Framework) where
  /-- Time value (possibly infinite) -/
  value : F.X → EReal
  /-- Time is non-negative -/
  nonneg : ∀ x : F.X, 0 ≤ value x

/-- Universal time construction -/
structure UniversalTime where
  /-- Time for each framework -/
  times : (F : Framework) → Time F
  /-- Characteristic minimum time -/
  min_time : EReal
  /-- All times are at least min_time -/
  bounded_below : ∀ (F : Framework) (x : F.X),
                  min_time ≤ (times F).value x

/-- Global finiteness: all times are finite -/
def UniversalTime.globallyFinite (T : UniversalTime) : Prop :=
  ∀ (F : Framework) (x : F.X), 
    (T.times F).value x ≠ ⊤

end TUNS
