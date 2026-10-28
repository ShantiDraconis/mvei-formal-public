/-
  MetaMillennium.Problems.YM.YMDefinition
  Yang-Mills Mass Gap definition
-/

import MetaMillennium.Core.TheoryAndModel

namespace MetaMillennium.Problems.YM

open MetaMillennium.Core

/-- A compact simple Lie group (gauge group) -/
inductive GaugeGroup where
  | SU (n : Nat) -- SU(n)
  | SO (n : Nat) -- SO(n)
  | Sp (n : Nat) -- Sp(n)
  | G2
  | F4
  | E6
  | E7
  | E8
  deriving Repr, BEq

/-- Yang-Mills theory (abstract) -/
structure YangMillsTheory where
  /-- The gauge group -/
  gauge_group : GaugeGroup
  /-- Dimension of spacetime -/
  spacetime_dim : Nat := 4

/-- Existence of quantum Yang-Mills theory -/
def QYM_exists (ym : YangMillsTheory) : Prop :=
  True  -- Placeholder for rigorous construction

/-- Mass gap property -/
structure MassGap (ym : YangMillsTheory) where
  /-- The gap value -/
  delta : Float
  /-- It's positive -/
  is_positive : delta > 0

/-- Yang-Mills Millennium Problem -/
def YM_Millennium : Prop :=
  ∀ G : GaugeGroup,
    let ym := { gauge_group := G : YangMillsTheory }
    QYM_exists ym ∧ ∃ gap : MassGap ym, True

/-- YM as a sentence -/
def phi_YM : Sentence := {
  id := 1006
  repr := "∀G compact simple: QYM exists and has mass gap"
}

end MetaMillennium.Problems.YM
