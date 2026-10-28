import Mathlib

/--
Terminal seven-way closure combinator.

This theorem proves C only from:
* seven independently supplied implications Pᵢ → C; and
* one material disjunction P₁ ∨ ... ∨ P₇.

It does not manufacture any Pᵢ and contains no placeholder assumptions
beyond its explicit arguments.
-/
def fecha7 {P1 P2 P3 P4 P5 P6 P7 C : Prop}
  (p1c : P1 → C)
  (p2c : P2 → C)
  (p3c : P3 → C)
  (p4c : P4 → C)
  (p5c : P5 → C)
  (p6c : P6 → C)
  (p7c : P7 → C)
  (h : P1 ∨ P2 ∨ P3 ∨ P4 ∨ P5 ∨ P6 ∨ P7) : C := by
  rcases h with h | h | h | h | h | h | h
  · exact p1c h
  · exact p2c h
  · exact p3c h
  · exact p4c h
  · exact p5c h
  · exact p6c h
  · exact p7c h

/--
Fail-closed input bundle for the terminal closure.
No field is optional; constructing this structure requires all seven routes
and the material disjunction.
-/
structure Close7Inputs (P1 P2 P3 P4 P5 P6 P7 C : Prop) where
  p1c : P1 → C
  p2c : P2 → C
  p3c : P3 → C
  p4c : P4 → C
  p5c : P5 → C
  p6c : P6 → C
  p7c : P7 → C
  disjunction : P1 ∨ P2 ∨ P3 ∨ P4 ∨ P5 ∨ P6 ∨ P7

/-- A fully inhabited input bundle closes C. -/
theorem Close7Inputs.close
    {P1 P2 P3 P4 P5 P6 P7 C : Prop}
    (x : Close7Inputs P1 P2 P3 P4 P5 P6 P7 C) : C :=
  fecha7 x.p1c x.p2c x.p3c x.p4c x.p5c x.p6c x.p7c x.disjunction
