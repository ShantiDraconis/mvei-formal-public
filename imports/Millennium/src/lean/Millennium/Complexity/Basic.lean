/-
  Basic definitions for computational complexity.
-/

namespace Millennium.Complexity

/-- A binary string -/
abbrev BinaryString := List Bool

/-- A language is a set of binary strings -/
def Language := Set BinaryString

/-- Input size -/
def inputSize (x : BinaryString) : ℕ := x.length

/-- A polynomial bound -/
structure PolynomialBound where
  degree : ℕ
  coefficient : ℕ
  evaluate : ℕ → ℕ := fun n => coefficient * n ^ degree + coefficient

/-- Check if a function is polynomially bounded -/
def IsPolynomiallyBounded (f : ℕ → ℕ) : Prop :=
  ∃ (p : PolynomialBound), ∀ n, f n ≤ p.evaluate n

/-- A decision algorithm (abstract) -/
structure Algorithm where
  name : String
  timeComplexity : ℕ → ℕ

/-- An algorithm is polynomial-time -/
def Algorithm.isPolynomialTime (a : Algorithm) : Prop :=
  IsPolynomiallyBounded a.timeComplexity

/-- An algorithm decides a language -/
structure Decider (L : Language) extends Algorithm where
  decides : ∀ x : BinaryString, Bool
  correct : ∀ x, decides x = true ↔ x ∈ L

end Millennium.Complexity
