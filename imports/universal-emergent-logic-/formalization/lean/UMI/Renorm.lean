/-
Renormalization theory for UMI framework.
-/

import UMI.Core

-- Renormalization group flow
def RGFlow {X : Type*} [InnerProductSpace ℝ X] 
    (op : ℝ → LinearOp X) (scales : List ℝ) : List (LinearOp X) :=
  scales.map op

-- Scale invariance property
def ScaleInvariant {X : Type*} [InnerProductSpace ℝ X] 
    (op : ℝ → LinearOp X) : Prop :=
  ∀ T₁ T₂ : ℝ, T₁ > 0 → T₂ > 0 → 
    ∃ C : ℝ, C > 0 ∧ 
    ∀ x : X, ‖op T₁ |>.apply x‖ ≤ C * ‖op T₂ |>.apply x‖

-- Convergence of renormalization flow
def ConvergentRG {X : Type*} [InnerProductSpace ℝ X] 
    (scaleFn : ℝ → ℝ) : Prop :=
  ∃ L : ℝ, Filter.Tendsto scaleFn Filter.atTop (nhds L)
