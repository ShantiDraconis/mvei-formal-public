inductive GateStatus
  | pass
  | blockingResidue
  | fail
deriving DecidableEq, Repr

structure TempleCertificate where
  gate1 : GateStatus
  gate2 : GateStatus
  gate3 : GateStatus
  gate4 : GateStatus
  gate5 : GateStatus
  gate6 : GateStatus
  gate7 : GateStatus
  gate8 : GateStatus
  chamber1 : GateStatus
  chamber2 : GateStatus
  chamber3 : GateStatus
  chamber4 : GateStatus
  chamber5 : GateStatus
  noPlacebo : Prop
  historicalTreeFrozen : Prop
  mcoreLocked : Prop

def allOuterGatesPass (c : TempleCertificate) : Prop :=
  c.gate1 = GateStatus.pass ∧
  c.gate2 = GateStatus.pass ∧
  c.gate3 = GateStatus.pass ∧
  c.gate4 = GateStatus.pass ∧
  c.gate5 = GateStatus.pass ∧
  c.gate6 = GateStatus.pass ∧
  c.gate7 = GateStatus.pass ∧
  c.gate8 = GateStatus.pass

def allInnerChambersPass (c : TempleCertificate) : Prop :=
  c.chamber1 = GateStatus.pass ∧
  c.chamber2 = GateStatus.pass ∧
  c.chamber3 = GateStatus.pass ∧
  c.chamber4 = GateStatus.pass ∧
  c.chamber5 = GateStatus.pass

def HolyOfHolies (c : TempleCertificate) : Prop :=
  allOuterGatesPass c ∧
  allInnerChambersPass c ∧
  c.noPlacebo ∧
  c.historicalTreeFrozen ∧
  c.mcoreLocked

inductive TempleStage
  | outside | g1 | g2 | g3 | g4 | g5 | g6 | g7 | g8
  | c1 | c2 | c3 | c4 | c5 | holyOfHolies
deriving DecidableEq, Repr

def allowedTransition (c : TempleCertificate) :
    TempleStage → TempleStage → Prop
  | TempleStage.outside, TempleStage.g1 => True
  | TempleStage.g1, TempleStage.g2 => c.gate1 = GateStatus.pass
  | TempleStage.g2, TempleStage.g3 => c.gate2 = GateStatus.pass
  | TempleStage.g3, TempleStage.g4 => c.gate3 = GateStatus.pass
  | TempleStage.g4, TempleStage.g5 => c.gate4 = GateStatus.pass
  | TempleStage.g5, TempleStage.g6 => c.gate5 = GateStatus.pass
  | TempleStage.g6, TempleStage.g7 => c.gate6 = GateStatus.pass
  | TempleStage.g7, TempleStage.g8 => c.gate7 = GateStatus.pass
  | TempleStage.g8, TempleStage.c1 => allOuterGatesPass c
  | TempleStage.c1, TempleStage.c2 => c.chamber1 = GateStatus.pass
  | TempleStage.c2, TempleStage.c3 => c.chamber2 = GateStatus.pass
  | TempleStage.c3, TempleStage.c4 => c.chamber3 = GateStatus.pass
  | TempleStage.c4, TempleStage.c5 => c.chamber4 = GateStatus.pass
  | TempleStage.c5, TempleStage.holyOfHolies =>
      c.chamber5 = GateStatus.pass ∧
      c.noPlacebo ∧
      c.historicalTreeFrozen ∧
      c.mcoreLocked
  | _, _ => False

theorem no_shortcut (c : TempleCertificate) :
    ¬ allowedTransition c TempleStage.outside TempleStage.holyOfHolies := by
  simp [allowedTransition]

theorem no_skip_G5 (c : TempleCertificate) :
    ¬ allowedTransition c TempleStage.g4 TempleStage.g6 := by
  simp [allowedTransition]

theorem no_skip_G5_from_G3 (c : TempleCertificate) :
    ¬ allowedTransition c TempleStage.g3 TempleStage.g6 := by
  simp [allowedTransition]

theorem messiah_route_requires_all_gates
    (c : TempleCertificate)
    (h : allowedTransition c TempleStage.g8 TempleStage.c1) :
    allOuterGatesPass c := by
  simpa [allowedTransition] using h

theorem entering_c1_implies_G5_pass
    (c : TempleCertificate)
    (h : allowedTransition c TempleStage.g8 TempleStage.c1) :
    c.gate5 = GateStatus.pass := by
  have hall : allOuterGatesPass c := by
    simpa [allowedTransition] using h
  exact hall.2.2.2.2.1

theorem holy_of_holies_requires_outer_gates
    (c : TempleCertificate)
    (h : HolyOfHolies c) :
    allOuterGatesPass c := by
  exact h.1

theorem holy_of_holies_requires_no_placebo
    (c : TempleCertificate)
    (h : HolyOfHolies c) :
    c.noPlacebo := by
  exact h.2.2.1
