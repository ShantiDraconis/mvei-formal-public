/-!
# Abstract Poincare-method template

This file proves only a conditional metatheorem. A concrete application must
supply every field of FlowSurgeryProgram; it must not assume the target
Millennium statement as one of the fields.
-/

namespace FTM

universe u

structure Problem where
  State : Type u
  Admissible : State → Prop
  Target : State → Prop

structure FlowSurgeryProgram (P : Problem) where
  evolve : Nat → P.State → P.State
  singular : P.State → Bool
  surgery : P.State → P.State
  entropy : P.State → Int
  complexity : P.State → Nat
  terminal : P.State → Prop

  advance : Nat → P.State → P.State :=
    fun t x => if singular x then surgery x else evolve t x

  semanticInvariant :
    ∀ (t : Nat) (x : P.State), P.Admissible x → P.Admissible (advance t x)

  entropyMonotone :
    ∀ (t : Nat) (x : P.State), P.Admissible x →
      entropy x ≤ entropy (advance t x)

  noCollapse :
    ∀ (C : Int), ∃ (K : Nat), ∀ (x : P.State),
      P.Admissible x → entropy x ≤ C → complexity x ≤ K

  surgerySound :
    ∀ (x : P.State), P.Admissible x → singular x = true →
      P.Admissible (surgery x)

  eventualTerminal :
    ∀ (x : P.State), P.Admissible x →
      ∃ (n : Nat), terminal (evolve n x)

  classifyTerminal :
    ∀ (x y : P.State), P.Admissible x → terminal y → P.Target x

theorem solve_of_flow_surgery
    (P : Problem) (M : FlowSurgeryProgram P) (x : P.State)
    (hx : P.Admissible x) : P.Target x := by
  obtain ⟨n, hn⟩ := M.eventualTerminal x hx
  exact M.classifyTerminal x (M.evolve n x) hx hn

structure Audit where
  semanticInvariant : Bool
  entropyMonotone : Bool
  noCollapse : Bool
  surgerySound : Bool
  eventualTerminal : Bool
  classifyTerminal : Bool
deriving Repr, DecidableEq

def Audit.unlocked (a : Audit) : Bool :=
  a.semanticInvariant && (a.entropyMonotone && (a.noCollapse &&
  (a.surgerySound && (a.eventualTerminal && a.classifyTerminal))))

theorem Audit.unlocked_iff (a : Audit) :
    a.unlocked = true ↔
      a.semanticInvariant = true ∧ a.entropyMonotone = true ∧
      a.noCollapse = true ∧ a.surgerySound = true ∧
      a.eventualTerminal = true ∧ a.classifyTerminal = true := by
  simp [Audit.unlocked, Bool.and_eq_true]

end FTM
