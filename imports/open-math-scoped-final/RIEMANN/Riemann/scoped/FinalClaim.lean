import Riemann.scoped.FinalProof

namespace Riemann.scoped

open MCore.RH.NB

theorem FINAL_SCOPED_CLAIM_FROM_CLAIM
    (D : NBHilbertData)
    (rho : D.GeneratorFamily)
    (h : D.VanishingUpperBound rho) :
    D.DNLimit rho = 0 :=
  FINAL_PROOF D rho h

#print axioms FINAL_SCOPED_CLAIM_FROM_CLAIM

end Riemann.scoped
