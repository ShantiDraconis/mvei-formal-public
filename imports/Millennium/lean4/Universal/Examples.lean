-- Universal/Examples.lean
-- Simple examples demonstrating TUNS framework usage

import Universal.TUNS

namespace Universal.Examples

-- Example: A trivial domain with unit types
def trivialDomain : MathDomain where
  X := Unit
  L := Unit
  G := Unit
  loc := fun _ => ()
  glob := fun _ => ()
  energy := fun _ => (0, 0, 0, 0)
  timeParam := fun _ x => x

-- Example: Verify that identity morphism works
example : Morphism trivialDomain trivialDomain := 
  CategoryStruct.id trivialDomain

-- Example: A domain family with all domains being the trivial domain
def exampleFamily : DomainFamily where
  RH_dom := trivialDomain
  NS_dom := trivialDomain
  YM_dom := trivialDomain
  FA_dom := trivialDomain
  OD_dom := trivialDomain
  Hodge_dom := trivialDomain
  Poincare_dom := trivialDomain
  AlgTop_dom := trivialDomain
  DiffGeom_dom := trivialDomain
  BSD_dom := trivialDomain
  ANT_dom := trivialDomain
  AA_dom := trivialDomain
  PvsNP_dom := trivialDomain
  CompLog_dom := trivialDomain

-- Verify the family has 14 domains
example : exampleFamily.toList.length = 14 := by rfl

end Universal.Examples
