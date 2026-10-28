import formal.HodgeMaterialProgram

/-! ATK terminal material frontier: deliberately unproved; not a certificate. -/
namespace ATKHodgeMaterialFrontier
open HodgeStructuralCore HodgeMaterialEndpointProbe HodgeMaterialProgram
universe u
variable {𝕜 V : Type u} [Field 𝕜] [AddCommGroup V] [Module 𝕜 V]

/-- This is the exact remaining universal cycle-production obligation for the declared family. -/
theorem terminal_universal_cycles
    (F : GeometricHodgeFamily (𝕜 := 𝕜) (V := V)) :
    UniversalGeometricMaterial F := by
  sorry

/-- The endpoint follows conditionally from the producer above. -/
theorem terminal_geometric_endpoints
    (F : GeometricHodgeFamily (𝕜 := 𝕜) (V := V)) :
    ∀ i : F.Index, ProbeHodgeStatement (F.data i) := by
  exact universalGeometricMaterial_closes F (terminal_universal_cycles F)
end ATKHodgeMaterialFrontier
