import FTM.PoincareMethod

/-!
# Millennium adapters

These are signatures, not solutions. They prevent an analogy from being
mistaken for an instantiated FlowSurgeryProgram.
-/

namespace FTM.Millennium

structure AdapterSpec where
  name : String
  stateMeaning : String
  flowCandidate : String
  entropyCandidate : String
  singularityMeaning : String
  surgeryCandidate : String
  terminalMeaning : String
  audit : FTM.Audit
deriving Repr

def allOpen : FTM.Audit :=
  { semanticInvariant := false
    entropyMonotone := false
    noCollapse := false
    surgerySound := false
    eventualTerminal := false
    classifyTerminal := false }

def pVsNP : AdapterSpec :=
  { name := "P versus NP"
    stateMeaning := "finite algorithms/circuits plus an invariant language"
    flowCandidate := "normalization or proof-complexity transformation; undefined"
    entropyCandidate := "lower-bound measure robust to barrier theorems"
    singularityMeaning := "hard instances under the fixed encoding"
    surgeryCandidate := "semantics-preserving decomposition with polynomial overhead"
    terminalMeaning := "a theorem separating or identifying the classes"
    audit := allOpen }

def riemann : AdapterSpec :=
  { name := "Riemann hypothesis"
    stateMeaning := "operator data whose determinant is proved equal to completed zeta"
    flowCandidate := "operator deformation preserving the determinant identity"
    entropyCandidate := "coercive spectral functional; undefined"
    singularityMeaning := "failure of self-adjoint spectral realization"
    surgeryCandidate := "zero-preserving repair; no candidate"
    terminalMeaning := "self-adjoint operator matching all nontrivial zeros"
    audit := allOpen }

def yangMills : AdapterSpec :=
  { name := "Yang-Mills existence and mass gap"
    stateMeaning := "gauge-invariant regularized quantum theories"
    flowCandidate := "renormalization flow with a constructed continuum limit"
    entropyCandidate := "coercive functional uniform in cutoff and volume"
    singularityMeaning := "loss of compactness, positivity, or continuum control"
    surgeryCandidate := "gauge-compatible step preserving axioms"
    terminalMeaning := "nontrivial 4D quantum theory with positive mass gap"
    audit := allOpen }

def hodge : AdapterSpec :=
  { name := "Hodge conjecture"
    stateMeaning := "smooth projective varieties with rational Hodge classes"
    flowCandidate := "algebraicity-aware deformation; Kahler-Ricci alone is insufficient"
    entropyCandidate := "functional controlling algebraic degeneration"
    singularityMeaning := "exit from the smooth projective category"
    surgeryCandidate := "algebraic modification with cycle compatibility"
    terminalMeaning := "rational (p,p) classes represented by algebraic cycles"
    audit := allOpen }

def navierStokes : AdapterSpec :=
  { name := "Navier-Stokes regularity"
    stateMeaning := "smooth divergence-free data and solution trajectories"
    flowCandidate := "the Navier-Stokes evolution itself"
    entropyCandidate := "scale-critical a priori regularity quantity"
    singularityMeaning := "finite-time blow-up in the official class"
    surgeryCandidate := "invalid unless it preserves the original PDE solution"
    terminalMeaning := "global smoothness or admissible breakdown"
    audit := allOpen }

def bsd : AdapterSpec :=
  { name := "Birch-Swinnerton-Dyer"
    stateMeaning := "elliptic curves over Q with all local/global arithmetic data"
    flowCandidate := "arithmetic deformation preserving L-function and rank semantics"
    entropyCandidate := "height/regulator/Selmer functional with monotonic law"
    singularityMeaning := "failure of descent or Selmer/Sha control"
    surgeryCandidate := "isogeny/descent with exact correction terms"
    terminalMeaning := "analytic order equals rank, with leading formula"
    audit := allOpen }

def adapters : List AdapterSpec :=
  [pVsNP, riemann, yangMills, hodge, navierStokes, bsd]

theorem no_adapter_is_claimed_unlocked :
    ∀ a ∈ adapters, a.audit.unlocked = false := by
  intro a ha
  simp [adapters] at ha
  rcases ha with rfl | rfl | rfl | rfl | rfl | rfl <;>
    decide

end FTM.Millennium
