import MCore.RH.NB.ZeroLimitFrontier

/-!
# Riemann scoped final claim

Scope only. This file deliberately does NOT export a theorem of type
`RiemannHypothesis`.

Frozen claim recorded for this lane:
  VanishingUpperBound -> DNToZero -> DNLimit = 0

The imported snapshot exposes the kernel-checked terminal equivalence below.
The historical VanishingUpperBound producer is registered in /open-math/frozen/
as `vanishing-upper-bound-green-5c66f8dc`; its exact Lean source is not
present in this M-Core snapshot, so it is not reconstructed or axiomatized here.
-/

namespace MCore.RH.ScopedFinal

#check MCore.RH.NB.NBHilbertData.DNToZero_iff_DNLimit_eq_zero
#check MCore.RH.NB.NBHilbertData.DNToZero_of_le_zero

def FINAL_SCOPED_CLAIM : String :=
  "VanishingUpperBound -> DNLimit = 0"

def RIEMANN_HYPOTHESIS_CLAIMS : Nat := 0

end MCore.RH.ScopedFinal
