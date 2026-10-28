import Riemann.frozen.vanishing_upper_bound_green_5c66f8dc

namespace Riemann.claims

open MCore.RH.NB

def CLAIM_1_ID : String := "FINAL_SCOPED_CLAIM"
def CLAIM_1_HASH : String := "5c66f8dc"

theorem CLAIM_1
    (D : NBHilbertData)
    (rho : D.GeneratorFamily)
    (h : D.VanishingUpperBound rho) :
    D.DNLimit rho = 0 :=
  Riemann.frozen.vanishing_upper_bound_thm D rho h

#print axioms CLAIM_1

end Riemann.claims
