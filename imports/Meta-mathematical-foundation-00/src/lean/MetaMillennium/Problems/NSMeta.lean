/-
  MetaMillennium.Problems.NSMeta
  
  Meta-mathematical analysis of Navier-Stokes.
-/

import MetaMillennium.DualState.ProblemsMeta

namespace MetaMillennium.Problems.NS

open MetaMillennium.DualState.NumericClasses

/-- Regularity number for NS -/
def NS_reg_number : RegularityNumber := {
  space_reg := 0,  -- unknown
  time_reg := 0,   -- unknown
  has_singularity := false  -- hoped/expected
}

end MetaMillennium.Problems.NS
