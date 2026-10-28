/-
  MetaMillennium.Problems.PNPMeta
  
  Meta-mathematical analysis of P vs NP.
-/

import MetaMillennium.DualState.ProblemsMeta

namespace MetaMillennium.Problems.PNP

open MetaMillennium.DualState
open MetaMillennium.DualState.NumericClasses

/-- Separation number for P vs NP -/
def PNP_sep_number : SeparationNumber := {
  separation_strength := 0,  -- unknown
  barrier_count := 3  -- relativization, natural proofs, algebrization
}

/-- P vs NP has three major barriers -/
theorem PNP_barriers : PNP_sep_number.barrier_count = 3 := rfl

end MetaMillennium.Problems.PNP
