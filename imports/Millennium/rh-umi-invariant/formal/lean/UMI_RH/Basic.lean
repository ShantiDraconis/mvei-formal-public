import Mathlib

namespace UMI_RH

-- Basic placeholders for Hilbert space framework.
-- TODO: specialize to H = L^2(0,1) and define indicator function 1_(0,1).

/-- Generic Hilbert space placeholder, to be instantiated with `L^2(0,1)` in the concrete development. -/
variable {H : Type} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

-- Distance to a subspace (placeholder; Mathlib has Submodule and dist in metric spaces).
-- TODO: use Submodule / ClosedSubspace and define dist properly.

end UMI_RH
