namespace FTM.Truncation

def cutoff (N n : Nat) : Bool := decide (n < N)

def project {α : Type} [Zero α] (N : Nat) (x : Nat → α) : Nat → α :=
  fun n => if cutoff N n then x n else 0

theorem cutoff_idempotent (N n : Nat) :
    (if cutoff N n then cutoff N n else false) = cutoff N n := by
  cases h : cutoff N n <;> simp [h]

theorem project_idempotent {α : Type} [Zero α] (N : Nat) (x : Nat → α) :
    project N (project N x) = project N x := by
  funext n
  unfold project
  cases h : cutoff N n <;> simp [h]

-- This algebraic projection theorem gives no analytic remainder estimate.

end FTM.Truncation
