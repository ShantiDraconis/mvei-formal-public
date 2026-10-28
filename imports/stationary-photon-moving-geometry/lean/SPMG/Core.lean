namespace SPMG

universe u v w

/-- Abstract physical model separating intrinsic state evolution from geometry. -/
structure GeometryModel where
  State : Type u
  Geometry : Type v
  Time : Type w
  Photon : State → Prop
  evolveGeometry : Time → Geometry → Geometry
  observe : Geometry → State → State

/-- Intrinsic state dynamics, intentionally separate from geometry dynamics. -/
structure Dynamics (M : GeometryModel) where
  evolveState : M.Time → M.State → M.State

/-- Photon states remain intrinsically unchanged in the SPMG model. -/
def StationaryPhotonLaw (M : GeometryModel) (D : Dynamics M) : Prop :=
  ∀ (t : M.Time) (s : M.State), M.Photon s → D.evolveState t s = s

/-- Observed state after both intrinsic and geometric evolution. -/
def ObservedState (M : GeometryModel) (D : Dynamics M)
    (t : M.Time) (g₀ : M.Geometry) (s : M.State) : M.State :=
  M.observe (M.evolveGeometry t g₀) (D.evolveState t s)

/-- For a stationary photon, all observed evolution is geometric. -/
theorem photon_observed_motion_is_geometric
    (M : GeometryModel) (D : Dynamics M)
    (h : StationaryPhotonLaw M D)
    (t : M.Time) (g₀ : M.Geometry) (s : M.State)
    (hph : M.Photon s) :
    ObservedState M D t g₀ s =
      M.observe (M.evolveGeometry t g₀) s := by
  unfold ObservedState
  rw [h t s hph]

#print axioms photon_observed_motion_is_geometric

end SPMG
