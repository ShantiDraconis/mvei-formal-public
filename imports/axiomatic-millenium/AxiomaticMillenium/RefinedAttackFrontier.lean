import AxiomaticMillenium.ActiveAttackFrontier

namespace AxiomaticMillenium

/--
Refined RH frontier after the exact finite-dimensional Pythagorean identity.

The finite-N evidence shows that simple Mobius tapers carry a substantial
projection-gap penalty.  The next analytic target is therefore a controlled
correction to a Mobius-like baseline, not another blind one-parameter taper.
-/
def rhRefinedFrontier : ActiveAttackFrontier :=
  { lane := "RH"
    exactResidual :=
      "construct c_N = (-mu)*w_N + r_N and prove total coefficientEnergy(c_N) <= K/log(N+2); equivalently control the Gram energy of the correction/projection gap uniformly"
    forbiddenFallback :=
      ["finite-N fit promoted to asymptotic theorem",
       "BCF conditional RH+zeta-prime-moment estimate",
       "new taper scan without projection-gap control",
       "DNLimit rewiring"]
    sourceRepo := "ShantiDraconis/m-core-riemann"
    sourceRef := "audit/rh-optimal-pythagoras-materialized-20261001"
    sourcePath := "lean/MCore/RH/NB/CoefficientPythagoras.lean" }

/--
Current exact NS analytic obstruction: a signed far-field cancellation with
one full dimensionless factor r/rhoStar, followed by a uniform bulk/tail
budget strictly below one.
-/
def nsRefinedFrontier : ActiveAttackFrontier :=
  { lane := "NS"
    exactResidual :=
      "derive signed far-field cancellation gaining beta=1 (r/rhoStar) directly from the PDE-tested identity, then obtain uniform BulkAbsorption+ExceptionalTailControl with cBulk+deltaTail<1"
    forbiddenFallback :=
      ["hDynamic -> coherence -> hDynamic circularity",
       "unsigned absolute-value bound without cancellation",
       "rhoStar^-2 derivative-loss route"]
    sourceRepo := "ShantiDraconis/navier-stokes-critical-barrier-audit"
    sourceRef := "audit/ns-g1-adapter-materialized-20261001"
    sourcePath := "formal/G1/DynamicCampanato.lean" }

/--
Current exact P02 semantic obstruction: self-reference is useful only after a
realizer turns the fixed code into a canonical SAT instance whose truth value
is the negation of the declared acceptance of the same M on the same bits.
-/
def p02RefinedFrontier : ActiveAttackFrontier :=
  { lane := "P02"
    exactResidual :=
      "construct UniformEffectiveCoverage: for every M an EffectiveDiagonalCompiler and SATFixedPointRealizer whose bitsOf fixedCode satisfies CanonicalSAT iff not DeclaredAccept M on those same bits"
    forbiddenFallback :=
      ["bare Kleene fixed point",
       "literal fixed-point route already falsified",
       "different-input diagonal",
       "semantic flip without size/clock preservation"]
    sourceRepo := "ShantiDraconis/m-core-p-vs-np"
    sourceRef := "audit/p02-kernel-materialized-20261001"
    sourcePath := "lean/MCore/Real/P02EffectiveAlignment.lean" }

def refinedAttackFrontiers : List ActiveAttackFrontier :=
  [rhRefinedFrontier, nsRefinedFrontier, p02RefinedFrontier]

theorem refined_attack_frontier_count :
    refinedAttackFrontiers.length = 3 := by
  decide

end AxiomaticMillenium
