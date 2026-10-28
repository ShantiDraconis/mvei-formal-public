namespace LeanWinWinLogic

/-- A proof of Q from either side of P. -/
structure WinWin (P Q : Prop) : Prop where
  viaPos : P → Q
  viaNeg : ¬ P → Q

/--
Constructive closure once excluded middle for the particular proposition P
is supplied explicitly.  No hidden classical instance is introduced here.
-/
theorem close {P Q : Prop} (w : WinWin P Q) (emP : P ∨ ¬ P) : Q :=
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

/-- Both sides cannot hold at once: the consistent reading of "both exist" is the case split. -/
theorem simultaneous_sides_impossible {P : Prop} : ¬ (P ∧ ¬ P) :=
  fun h => h.2 h.1

/--
Obstruction: if the opposite world `Opp` lands inside the complementary
branch, the missing half of a win-win is equivalent to the target itself.
Constructive.
-/
theorem missing_half_iff_target {Opp Branch Target : Prop}
    (hOpp : Opp → Branch) (hTarget : Target ↔ ¬ Opp) :
    (Branch → Target) ↔ Target :=
  ⟨fun half => hTarget.mpr fun o => hTarget.mp (half (hOpp o)) o, fun t _ => t⟩

/-- With the target itself as the split, the negative half is the whole target. -/
theorem self_target_missing_half {P : Prop} (emP : P ∨ ¬ P) : (¬ P → P) ↔ P :=
  ⟨fun h => match emP with
    | Or.inl hp => hp
    | Or.inr hnp => h hnp,
   fun hp _ => hp⟩

/--
The previous `bebedor` statement fixed the person `x` in advance:
`WinWin (∀ y, Drinks y) (Drinks x → ∀ y, Drinks y)`.  That is false in
general.  Counterexample: `Person := Bool`, `Drinks b := b = true`,
`x := true`.  Not everyone drinks, but `x` does.
-/
theorem bebedor_original_false :
    ¬ (∀ {Person : Type} (Drinks : Person → Prop) (x : Person),
        ((∀ y, Drinks y) ∨ ¬ (∀ y, Drinks y)) →
        WinWin (∀ y, Drinks y) (Drinks x → ∀ y, Drinks y)) := by
  intro h
  have hnot : ¬ (∀ y : Bool, y = true) := fun hall => Bool.false_ne_true (hall false)
  have w := h (fun b : Bool => b = true) true (Or.inr hnot)
  exact hnot (w.viaNeg hnot rfl)

/--
The drinker principle as a genuine win-win: in a nonempty pub there is
someone such that, if they drink, everyone drinks.  The person is chosen
after the case split.  Positive branch: anyone, here `x0`.  Negative branch:
a non-drinker.  Both the split and the non-drinker are explicit inputs, so
no classical axiom is used.
-/
theorem bebedor {Person : Type} (Drinks : Person → Prop) (x0 : Person)
    (emAll : (∀ y, Drinks y) ∨ ¬ (∀ y, Drinks y))
    (witness : ¬ (∀ y, Drinks y) → ∃ y, ¬ Drinks y) :
    ∃ x, Drinks x → ∀ y, Drinks y :=
  close
    ⟨fun hall => ⟨x0, fun _ => hall⟩,
     fun hnot => match witness hnot with
       | ⟨y, hy⟩ => ⟨y, fun hd => absurd hd hy⟩⟩
    emAll

/-- Classical form of the drinker principle (uses `Classical.em` and `Classical.byContradiction`). -/
theorem bebedor_classical {Person : Type} (Drinks : Person → Prop) (x0 : Person) :
    ∃ x, Drinks x → ∀ y, Drinks y :=
  bebedor Drinks x0 (Classical.em _)
    (fun h => Classical.byContradiction fun hne =>
      h fun y => Classical.byContradiction fun hy => hne ⟨y, hy⟩)

/--
Abstract Hecke/Deuring split: this packages the two real mathematical
branches but does not pretend to prove either branch.
-/
theorem heilbronnWinWin {P Q : Prop}
    (hecke : P → Q) (deuring : ¬ P → Q) : WinWin P Q :=
  ⟨hecke, deuring⟩

#print axioms LeanWinWinLogic.close
#print axioms LeanWinWinLogic.self_needs_full_proof
#print axioms LeanWinWinLogic.simultaneous_sides_impossible
#print axioms LeanWinWinLogic.missing_half_iff_target
#print axioms LeanWinWinLogic.self_target_missing_half
#print axioms LeanWinWinLogic.bebedor_original_false
#print axioms LeanWinWinLogic.bebedor
#print axioms LeanWinWinLogic.bebedor_classical
#print axioms LeanWinWinLogic.heilbronnWinWin

end LeanWinWinLogic
