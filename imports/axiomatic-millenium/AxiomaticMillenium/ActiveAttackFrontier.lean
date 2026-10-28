import AxiomaticMillenium.MaterializerMiningLedger

namespace AxiomaticMillenium

structure ActiveAttackFrontier where
  lane : String
  exactResidual : String
  forbiddenFallback : List String
  sourceRepo : String
  sourceRef : String
  sourcePath : String
  deriving Repr, DecidableEq

def rhActiveFrontier : ActiveAttackFrontier :=
  { lane := "RH"
    exactResidual :=
      "exists K>=0 and coefficients c_N with coefficientEnergy(c_N) <= K/log(N+2) for every N"
    forbiddenFallback :=
      ["DNLimit wiring", "finite-N numerics as asymptotic proof",
       "BCF conditional RH+zeta-prime moment asymptotic"]
    sourceRepo := "ShantiDraconis/m-core-riemann"
    sourceRef := "1254eea21ecfe1d7c00f5f9971faa2039bb69710"
    sourcePath := "lean/MCore/RH/NB/CoefficientLogMajorantProducer.lean" }

def nsActiveFrontier : ActiveAttackFrontier :=
  { lane := "NS"
    exactResidual :=
      "ActualNS -> one uniform cBulk,deltaTail with BulkAbsorption + ExceptionalTailControl + cBulk+deltaTail<1"
    forbiddenFallback :=
      ["signed-gain downstream algebra", "hDynamic circularity",
       "unsigned absolute-value estimates without signed cancellation"]
    sourceRepo := "ShantiDraconis/navier-stokes-critical-barrier-audit"
    sourceRef := "f4762783f2ceea18a0ae03b47f07d5d0fefd4dd6"
    sourcePath := "audit/producer-first/UniversalBulkTailProducer.lean" }

def p02ActiveFrontier : ActiveAttackFrontier :=
  { lane := "P02"
    exactResidual :=
      "for every PolyDTMCandidate M construct x_M with CanonicalSAT(x_M) iff not DeclaredAccept(M,x_M)"
    forbiddenFallback :=
      ["literal fixed-point route", "different-input diagonalization",
       "self-reference without SAT semantic preservation"]
    sourceRepo := "ShantiDraconis/m-core-p-vs-np"
    sourceRef := "7fdb67ec47bf1ac1038a6854eee5e36be8ec3248"
    sourcePath := "lean/MCore/Real/P02SameInputProducer.lean" }

def activeAttackFrontiers : List ActiveAttackFrontier :=
  [rhActiveFrontier, nsActiveFrontier, p02ActiveFrontier]

theorem active_attack_frontier_count :
    activeAttackFrontiers.length = 3 := by
  decide

end AxiomaticMillenium
