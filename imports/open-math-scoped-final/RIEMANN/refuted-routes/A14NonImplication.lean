/-!
# A14 non-implication route registry

Classification: CLOSED_BY_COUNTERMODEL.

Expected frozen theorem exports from the external source artifact:
- A14_alone_not_sufficient_for_covering
- A14_alone_not_sufficient_for_testDefect
- A14_alone_not_sufficient_for_joint_decay

Their exact Lean bodies are not present in the current M-Core snapshot.
This file intentionally does not recreate them from weaker assumptions and
does not introduce axioms.
-/

namespace MCore.RH.RefutedRoutes

def routeState : String := "CLOSED_BY_COUNTERMODEL"

def expectedTheorems : List String := [
  "A14_alone_not_sufficient_for_covering",
  "A14_alone_not_sufficient_for_testDefect",
  "A14_alone_not_sufficient_for_joint_decay"
]

end MCore.RH.RefutedRoutes
