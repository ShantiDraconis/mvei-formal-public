/-
  MetaMillennium.Problems.BSDMeta
  
  Meta-mathematical analysis of BSD Conjecture.
-/

import MetaMillennium.DualState.ProblemsMeta

namespace MetaMillennium.Problems.BSD

open MetaMillennium.DualState.NumericClasses

/-- Mordell-Weil number for BSD -/
def BSD_mw_number : MordellWeilNumber := {
  alg_rank := 0,  -- varies by curve
  an_rank := 0,   -- varies by curve
  discrepancy := 0  -- BSD claims this
}

end MetaMillennium.Problems.BSD
