import SPMG.Core

namespace SPMG

/-- Abstract speed structure with zero and distinguished c. -/
structure SpeedModel where
  Speed : Type
  zero : Speed
  c : Speed

/-- SPMG kinematic assignment. -/
structure PhotonKinematics (S : SpeedModel) where
  photonIntrinsicSpeed : S.Speed
  geometryPropagationSpeed : S.Speed
  photon_intrinsic_zero : photonIntrinsicSpeed = S.zero
  geometry_speed_c : geometryPropagationSpeed = S.c

theorem photon_speed_zero
    (S : SpeedModel) (K : PhotonKinematics S) :
    K.photonIntrinsicSpeed = S.zero :=
  K.photon_intrinsic_zero

theorem geometry_speed_is_c
    (S : SpeedModel) (K : PhotonKinematics S) :
    K.geometryPropagationSpeed = S.c :=
  K.geometry_speed_c

theorem stationary_photon_moving_geometry
    (S : SpeedModel) (K : PhotonKinematics S) :
    K.photonIntrinsicSpeed = S.zero ∧
    K.geometryPropagationSpeed = S.c := by
  exact ⟨K.photon_intrinsic_zero, K.geometry_speed_c⟩

#print axioms photon_speed_zero
#print axioms geometry_speed_is_c
#print axioms stationary_photon_moving_geometry

end SPMG
