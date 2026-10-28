/-
  MetaMillennium.Problems.NS.NSDefinition
  Navier-Stokes definition
-/

import MetaMillennium.Core.TheoryAndModel

namespace MetaMillennium.Problems.NS

open MetaMillennium.Core

/-- A velocity field in 3D -/
structure VelocityField where
  /-- Abstract representation -/
  id : Nat

/-- Initial data for Navier-Stokes -/
structure InitialData where
  /-- The initial velocity field -/
  velocity : VelocityField
  /-- Is the data smooth? -/
  is_smooth : Bool
  /-- Energy of the initial data -/
  energy : Float

/-- A solution to Navier-Stokes -/
structure NSSolution where
  /-- The solution as a time-dependent velocity field -/
  evolution : Float → VelocityField
  /-- Maximum existence time (could be ∞) -/
  max_time : Float
  /-- Is it globally defined? -/
  is_global : Bool
  /-- Is it smooth? -/
  is_smooth : Bool

/-- Global existence and smoothness -/
def GlobalExistenceAndSmoothness : Prop :=
  ∀ init : InitialData, init.is_smooth →
    ∃ sol : NSSolution, sol.is_global ∧ sol.is_smooth

/-- Finite-time blowup -/
def FiniteTimeBlowup : Prop :=
  ∃ init : InitialData, init.is_smooth ∧
    ∀ sol : NSSolution, ¬sol.is_global

/-- NS Millennium statement -/
def phi_NS : Sentence := {
  id := 1003
  repr := "∀(smooth initial data) ∃(global smooth solution)"
}

/-- Alternative formulation: blowup -/
def phi_NS_blowup : Sentence := {
  id := 1003
  repr := "∃(smooth initial data)(finite-time blowup)"
}

end MetaMillennium.Problems.NS
