import AxiomaticMillenium.CrossProblemParameterMatrices
import AxiomaticMillenium.TwoSidedClosure

namespace AxiomaticMillenium

/--
Truth evidence and process closure are independent axes.

positive=true, negative=false means a proof of the exact proposition has
been established.
positive=false, negative=true means a refutation has been established.
Both false means mathematically unresolved.
Both true is classically inconsistent for the same exact proposition and must
not be treated as an ordinary successful state.
-/
structure TruthBits where
  positive : Bool
  negative : Bool
  deriving Repr, DecidableEq, BEq

inductive TruthClass where
  | unknown
  | trueOnly
  | falseOnly
  | inconsistent
  deriving Repr, DecidableEq, BEq

def TruthBits.classify (t : TruthBits) : TruthClass :=
  match t.positive, t.negative with
  | false, false => .unknown
  | true, false => .trueOnly
  | false, true => .falseOnly
  | true, true => .inconsistent

inductive GateClosure where
  | open
  | closed
  deriving Repr, DecidableEq, BEq

inductive GateScope where
  | exact
  | aggregated
  deriving Repr, DecidableEq, BEq

structure GateState where
  closure : GateClosure
  truth : TruthBits
  scope : GateScope := .exact
  deriving Repr, DecidableEq, BEq

structure ClosureTrajectory where
  problem : String
  start : GateState
  middle : GateState
  endpoint : GateState
  note : String
  deriving Repr, DecidableEq

def closedTrue : GateState :=
  { closure := .closed, truth := { positive := true, negative := false } }

def closedFalse : GateState :=
  { closure := .closed, truth := { positive := false, negative := true } }

def closedUnknown : GateState :=
  { closure := .closed, truth := { positive := false, negative := false } }

def openUnknown : GateState :=
  { closure := .open, truth := { positive := false, negative := false } }

def openFalse : GateState :=
  { closure := .open, truth := { positive := false, negative := true } }

def openTrue : GateState :=
  { closure := .open, truth := { positive := true, negative := false } }

def semanticMeaning (g : GateState) : String :=
  match g.closure, g.truth.classify with
  | .closed, .trueOnly => "CLOSED_TRUE"
  | .closed, .falseOnly => "CLOSED_FALSE"
  | .closed, .unknown => "CLOSED_STATUS_ONLY"
  | .closed, .inconsistent => "CLOSED_INCONSISTENT"
  | .open, .trueOnly => "OPEN_WITH_POSITIVE_PART"
  | .open, .falseOnly => "OPEN_WITH_FALSIFIED_PART"
  | .open, .unknown => "OPEN_UNKNOWN"
  | .open, .inconsistent => "OPEN_INCONSISTENT"

def classicallyAdmissible (g : GateState) : Bool :=
  match g.scope with
  | .exact => g.truth.classify != .inconsistent
  | .aggregated => true

def rhTrajectory : ClosureTrajectory :=
  { problem := "RH"
    start := closedTrue
    middle := openTrue
    endpoint := openUnknown
    note := "Hilbert/Gram/log-majorant implications are proved; quantitative asymptotic producer remains open." }

def pnpTrajectory : ClosureTrajectory :=
  { problem := "PVSNP"
    start := closedTrue
    middle := { closure := .open, truth := { positive := true, negative := true }, scope := .aggregated }
    endpoint := openUnknown
    note := "P01 positive SAT-in-NP construction candidate exists; literal G21 fixed-point route is refuted; semantic lower-bound producer remains open. Mixed truth bits are aggregated across different subtargets and are not a contradiction." }

def nsTrajectory : ClosureTrajectory :=
  { problem := "NS"
    start := closedTrue
    middle := openFalse
    endpoint := openUnknown
    note := "Downstream signed-gain algebra is closed; amplitude-invariant fixed-delta route is refuted; genuine PDE signed-cancellation producer remains open." }

def hodgeTrajectory : ClosureTrajectory :=
  { problem := "HODGE"
    start := closedTrue
    middle := openTrue
    endpoint := openUnknown
    note := "Concrete target/adapter and special cases are proved; universal algebraicity realization remains open." }

def bsdTrajectory : ClosureTrajectory :=
  { problem := "BSD"
    start := closedTrue
    middle := openFalse
    endpoint := openUnknown
    note := "Typed arithmetic/analytic infrastructure is closed; the abstract unrelated-data universalization is refuted; same-curve rank/refined producer remains open." }

def ymTrajectory : ClosureTrajectory :=
  { problem := "YM"
    start := closedTrue
    middle := openTrue
    endpoint := openUnknown
    note := "Regulated/spectral downstream bridges are proved conditionally; genuine same-construction physical uniform-gap input remains open." }

def bealTrajectory : ClosureTrajectory :=
  { problem := "BEAL"
    start := closedTrue
    middle := openTrue
    endpoint := openUnknown
    note := "Common-prime endpoint equivalences and modular/conductor machinery are closed as implications; universal coprime exclusion remains open." }

def allClosureTrajectories : List ClosureTrajectory :=
  [rhTrajectory, pnpTrajectory, nsTrajectory, hodgeTrajectory,
   bsdTrajectory, ymTrajectory, bealTrajectory]

inductive MiddleStateFamily where
  | positiveOpen
  | falsifiedOpen
  | mixedSubtargets
  | unresolvedOnly
  deriving Repr, DecidableEq, BEq

def middleStateFamily (t : ClosureTrajectory) : MiddleStateFamily :=
  if t.problem == "PVSNP" then .mixedSubtargets
  else if t.middle.truth.positive && !t.middle.truth.negative then .positiveOpen
  else if !t.middle.truth.positive && t.middle.truth.negative then .falsifiedOpen
  else .unresolvedOnly

def positiveOpenGroup : List String :=
  allClosureTrajectories
    |>.filter (fun t => middleStateFamily t == .positiveOpen)
    |>.map (fun t => t.problem)

def falsifiedOpenGroup : List String :=
  allClosureTrajectories
    |>.filter (fun t => middleStateFamily t == .falsifiedOpen)
    |>.map (fun t => t.problem)

def mixedMiddleGroup : List String :=
  allClosureTrajectories
    |>.filter (fun t => middleStateFamily t == .mixedSubtargets)
    |>.map (fun t => t.problem)

theorem closure_trajectory_count :
    allClosureTrajectories.length = 7 := by
  decide

theorem positive_open_group_is_expected :
    positiveOpenGroup = ["RH", "HODGE", "YM", "BEAL"] := by
  decide

theorem falsified_open_group_is_expected :
    falsifiedOpenGroup = ["NS", "BSD"] := by
  decide

theorem mixed_middle_group_is_pvsnp :
    mixedMiddleGroup = ["PVSNP"] := by
  decide

theorem pvsnp_aggregated_middle_is_admissible :
    classicallyAdmissible pnpTrajectory.middle = true := by
  decide

theorem exact_both_state_is_rejected :
    classicallyAdmissible
      { closure := .closed,
        truth := { positive := true, negative := true },
        scope := .exact } = false := by
  decide

end AxiomaticMillenium
