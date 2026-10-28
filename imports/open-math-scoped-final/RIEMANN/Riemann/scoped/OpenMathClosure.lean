import Riemann.scoped.FinalProof
import Riemann.external.ExternalCertificate

namespace Riemann.scoped

open MCore.RH.NB

/-- Minimal theorem-level closure of the scoped lane.
    It closes only the conditional statement already certified:
    VanishingUpperBound -> DNLimit = 0.
    It does not construct VanishingUpperBound and does not claim RH. -/
theorem OPEN_MATH_SCOPED_CLOSED
    (D : NBHilbertData)
    (rho : D.GeneratorFamily)
    (h : D.VanishingUpperBound rho) :
    D.DNLimit rho = 0 :=
  FINAL_PROOF D rho h

/-- The external certificate consumes exactly the same scoped theorem. -/
theorem OPEN_MATH_TO_EXTERNAL
    (D : NBHilbertData)
    (rho : D.GeneratorFamily)
    (h : D.VanishingUpperBound rho) :
    D.DNLimit rho = 0 :=
  Riemann.external.EXTERNAL_SCOPED_CLAIM D rho h

#print axioms OPEN_MATH_SCOPED_CLOSED
#print axioms OPEN_MATH_TO_EXTERNAL

end Riemann.scoped
