import SEETV5.Axioms

namespace SEETV5

def faultImpliesShutdown (faultPresent : Bool) (next : SystemState) : Prop :=
  faultPresent = true → next = SystemState.shutdown

theorem no_actuation_without_enable
  (enable : Bool)
  (safety : SafetyState)
  (h : actuationAllowed enable safety) :
  enable = true := h.left

theorem no_actuation_without_safety
  (enable : Bool)
  (safety : SafetyState)
  (h : actuationAllowed enable safety) :
  safety = SafetyState.safe := h.right

end SEETV5
