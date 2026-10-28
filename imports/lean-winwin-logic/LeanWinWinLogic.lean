namespace LeanWinWinLogic

/-- A proof of Q from either side of P. -/
structure WinWin (P Q : Prop) where
  viaPos : P → Q
  viaNeg : ¬ P → Q

/--
Constructive closure once excluded middle for the particular proposition P
is supplied explicitly.  No hidden classical instance is introduced here.
-/
def close {P Q : Prop} (w : WinWin P Q) (emP : P ∨ ¬ P) : Q :=
  match emP with
  | Or.inl hp => w.viaPos hp
  | Or.inr hnp => w.viaNeg hnp

/--
The self-target case cannot manufacture P from the WinWin wrapper alone;
closure still needs the same excluded-middle payload.
-/
theorem self_needs_full_proof {P : Prop}
    (w : WinWin P P) (emP : P ∨ ¬ P) : P :=
  close w emP

/-- A minimal "drinker-style" branch split with the branch principle exposed. -/
theorem bebedor
    {Person : Type} (Drinks : Person → Prop) (x : Person)
    (emAll : (∀ y, Drinks y) ∨ ¬ (∀ y, Drinks y)) :
    WinWin (∀ y, Drinks y) (Drinks x → ∀ y, Drinks y) := by
  constructor
  · intro hall
    intro _
    exact hall
  · intro hnot
    intro hx
    exfalso
    exact hnot (fun _ => hx)

/--
Abstract Hecke/Deuring split: this packages the two real mathematical
branches but does not pretend to prove either branch.
-/
def heilbronnWinWin {P Q : Prop}
    (hecke : P → Q) (deuring : ¬ P → Q) : WinWin P Q :=
  ⟨hecke, deuring⟩

#print axioms LeanWinWinLogic.close
#print axioms LeanWinWinLogic.self_needs_full_proof
#print axioms LeanWinWinLogic.bebedor
#print axioms LeanWinWinLogic.heilbronnWinWin

end LeanWinWinLogic
