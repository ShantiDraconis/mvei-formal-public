import ROZC.FreeOffCriticalGeometry

namespace ROZC

universe u

/-- Abstract reciprocal chart around critical displacement zero.
    It records the algebraic inversion law without pretending that limit theory
    has been proved in this dependency-free kernel. -/
structure ReciprocalChart where
  Coord : Type u
  zero : Coord
  inv : Coord → Coord
  nonzero : Coord → Prop
  inv_involutive : ∀ x, nonzero x → inv (inv x) = x

/-- An off-critical state can be represented in a reciprocal chart once a
    concrete adapter supplies a nonzero coordinate witness. -/
structure ReciprocalState (R : ReciprocalChart) where
  delta : R.Coord
  delta_nonzero : R.nonzero delta
  eta : R.Coord
  eta_eq : eta = R.inv delta

theorem reciprocal_round_trip
    {R : ReciprocalChart}
    (s : ReciprocalState R) :
    R.inv s.eta = s.delta := by
  rw [s.eta_eq]
  exact R.inv_involutive s.delta s.delta_nonzero

#print axioms reciprocal_round_trip

end ROZC
