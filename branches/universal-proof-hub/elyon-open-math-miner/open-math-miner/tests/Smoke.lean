import OpenMathMiner

open OpenMathMiner

def A : Signature where
  name := "A"
  Input := Nat
  Output := Nat
  admissible := fun _ => True
  relation := fun x y => y = x

def B : Signature where
  name := "B"
  Input := Nat
  Output := Nat
  admissible := fun _ => True
  relation := fun x y => y = x

def idBridge : Bridge A B where
  mapInput := id
  mapOutput := id
  admissible_preserved := by
    intro x hx
    exact hx
  closure_transport := by
    intro x y hx hy
    exact hy

theorem solvedB : Solved B := by
  intro x hx
  exact ⟨x, rfl⟩

example : Solved A :=
  transportSolved idBridge solvedB

#check OpenMathMiner.transportSolved
#check OpenMathMiner.no_two_outcomes
