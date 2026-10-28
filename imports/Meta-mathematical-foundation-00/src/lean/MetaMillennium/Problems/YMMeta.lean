/-
  MetaMillennium.Problems.YMMeta
  
  Meta-mathematical analysis of Yang-Mills Mass Gap.
-/

import MetaMillennium.DualState.ProblemsMeta

namespace MetaMillennium.Problems.YM

open MetaMillennium.DualState.NumericClasses

/-- Mass gap number for YM -/
def YM_gap_number : MassGapNumber := {
  mass_gap := 0,  -- unknown
  exists_gap := true  -- conjectured
}

end MetaMillennium.Problems.YM
