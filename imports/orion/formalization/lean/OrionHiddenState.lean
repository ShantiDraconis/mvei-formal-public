namespace OrionHiddenState

universe u v

structure HiddenStateSystem where
  X : Type u
  O : Type v
  π : X → O
  residue : X → Nat
  signature : O → Nat
  transfer : Nat → Nat
  positivity : ∀ x, 0 < residue x → 0 < signature (π x)
  transferBound : ∀ x, residue x ≤ transfer (signature (π x))

abbrev NatMonotone (F : Nat → Nat) : Prop :=
  ∀ ⦃a b : Nat⦄, a ≤ b → F a ≤ F b

def SignatureBound (S : HiddenStateSystem) (B : Nat) : Prop :=
  ∀ x, S.signature (S.π x) ≤ B

theorem hiddenStatePrinciple (S : HiddenStateSystem) {x : S.X}
    (h : 0 < S.residue x) :
    0 < S.signature (S.π x) :=
  S.positivity x h

theorem quantitativeTransfer (S : HiddenStateSystem) (x : S.X) :
    S.residue x ≤ S.transfer (S.signature (S.π x)) :=
  S.transferBound x

theorem boundedHiddenOfBoundedSignature
    (S : HiddenStateSystem)
    {B : Nat}
    (hmono : NatMonotone S.transfer)
    (hbound : SignatureBound S B) :
    ∀ x, S.residue x ≤ S.transfer B := by
  intro x
  exact Nat.le_trans (S.transferBound x) (hmono (hbound x))

inductive DefectMode where
  | collapse
  | gap
  | boundedness
  deriving DecidableEq, Repr

def classifyDefect (defect threshold : Nat) : DefectMode :=
  if defect = 0 then DefectMode.collapse
  else if threshold ≤ defect then DefectMode.gap
  else DefectMode.boundedness

theorem classifyCollapse (threshold : Nat) :
    classifyDefect 0 threshold = DefectMode.collapse := by
  simp [classifyDefect]

theorem classifyGap {defect threshold : Nat}
    (h₀ : defect ≠ 0)
    (hgap : threshold ≤ defect) :
    classifyDefect defect threshold = DefectMode.gap := by
  simp [classifyDefect, h₀, hgap]

theorem classifyBoundedness {defect threshold : Nat}
    (h₀ : defect ≠ 0)
    (hgap : ¬ threshold ≤ defect) :
    classifyDefect defect threshold = DefectMode.boundedness := by
  simp [classifyDefect, h₀, hgap]

end OrionHiddenState
