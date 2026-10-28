import SPMG.Core

namespace SPMG

/-- Abstract identity-time element for a geometry model. -/
structure IdentityTime (M : GeometryModel) where
  zeroTime : M.Time
  geometry_identity : ∀ g, M.evolveGeometry zeroTime g = g

/-- Geometry acts trivially on observation at the identity geometry evolution. -/
structure ObservationIdentity (M : GeometryModel) (I : IdentityTime M) where
  identity_observation :
    ∀ (g : M.Geometry) (s : M.State),
      M.observe (M.evolveGeometry I.zeroTime g) s = M.observe g s

theorem observed_at_zero_time
    (M : GeometryModel)
    (D : Dynamics M)
    (I : IdentityTime M)
    (O : ObservationIdentity M I)
    (g : M.Geometry) (s : M.State)
    (hstate : D.evolveState I.zeroTime s = s) :
    ObservedState M D I.zeroTime g s = M.observe g s := by
  unfold ObservedState
  rw [hstate]
  exact O.identity_observation g s

/-- A photon satisfying the stationary law has identity intrinsic evolution at every time. -/
theorem stationary_photon_intrinsic_fixed
    (M : GeometryModel) (D : Dynamics M)
    (h : StationaryPhotonLaw M D)
    (t : M.Time) (s : M.State) (hph : M.Photon s) :
    D.evolveState t s = s :=
  h t s hph

#print axioms observed_at_zero_time
#print axioms stationary_photon_intrinsic_fixed

end SPMG
