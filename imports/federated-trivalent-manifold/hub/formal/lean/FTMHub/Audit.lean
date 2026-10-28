import Init

namespace FTMHub

inductive Status where
  | proved
  | finiteCertificate
  | conditional
  | equivalent
  | conjectural
  | refuted
  | open
  deriving DecidableEq

def statusAllowsAutomaticProof : Status → Bool
  | Status.proved => true
  | Status.conditional => true
  | Status.finiteCertificate => false
  | Status.equivalent => false
  | Status.conjectural => false
  | Status.refuted => false
  | Status.open => false

theorem finiteCertificateNotAutomatic :
    statusAllowsAutomaticProof Status.finiteCertificate = false := rfl

theorem openNotAutomatic :
    statusAllowsAutomaticProof Status.open = false := rfl

theorem equivalentNotAutomatic :
    statusAllowsAutomaticProof Status.equivalent = false := rfl

inductive AllProved : List Status → Prop where
  | nil : AllProved []
  | cons : AllProved tail → AllProved (Status.proved :: tail)

def MayPromote (current : Status) (dependencies : List Status) : Prop :=
  current ≠ Status.refuted ∧ AllProved dependencies

theorem openDependencyBlocks (tail : List Status) :
    ¬ AllProved (Status.open :: tail) := by
  intro assumption
  cases assumption

theorem finiteDependencyBlocks (tail : List Status) :
    ¬ AllProved (Status.finiteCertificate :: tail) := by
  intro assumption
  cases assumption

structure Node where
  status : Status
  dependencies : List Status

def safeBase : Node where
  status := Status.proved
  dependencies := []

theorem safeBaseDependencies : safeBase.dependencies = [] := rfl

structure RadiiEncoding where
  center : Int
  delta : Int
  deltaSq : Int

def plusEncoding (r : RadiiEncoding) : Int := r.center + r.delta + r.deltaSq
def minusEncoding (r : RadiiEncoding) : Int := r.center - r.delta + r.deltaSq

end FTMHub
