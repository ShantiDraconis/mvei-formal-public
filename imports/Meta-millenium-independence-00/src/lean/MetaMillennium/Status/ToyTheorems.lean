/-
  MetaMillennium.Status.ToyTheorems

  Theorems that ARE actually proven in this framework.
  These serve as demonstrations that the machinery works.
-/

import MetaMillennium.Core.TheoryAndModel
import MetaMillennium.Core.ConsistencyAndIndependence
import MetaMillennium.DualState.BiModel
import MetaMillennium.Models.ToyModels

namespace MetaMillennium.Status

open MetaMillennium
open MetaMillennium.Toy

/-! ## Proven Theorems

These are actual theorems with complete proofs (no `sorry`).
-/

/-- Theorem: ToyTheory is consistent -/
theorem toy_consistent : Consistent ToyTheory := toyTheory_consistent

/-- Theorem: α is independent of ToyTheory -/
theorem toy_alpha_independent : Independent ToyTheory α := α_independent

/-- Theorem: Swapping a bi-model twice returns the original -/
theorem bimodel_swap_involution {T : Theory} (B : BiModel T) : 
    B.swap.swap = B := swap_swap B

/-- Theorem: BoolTheory bi-model is a dual witness -/
theorem bool_dual_witness : 
    (boolBiModel.Mpos ⊨[BoolTheory] α) ∧ ¬(boolBiModel.Mneg ⊨[BoolTheory] α) :=
  boolBiModel_is_dual

/-- Theorem: NatTheory is consistent -/
theorem nat_consistent : Consistent NatTheory := natTheory_consistent

/-- Theorem: Double negation introduction -/
theorem dne (P : Prop) : P → ¬¬P := double_neg_intro P

/-- Theorem: Modus ponens -/
theorem mp (P Q : Prop) (hpq : P → Q) (hp : P) : Q := modus_ponens P Q hpq hp

/-! ## Summary

These theorems demonstrate:
1. The framework compiles and type-checks
2. Basic properties can be proven
3. Toy models work as expected
4. The dual-state machinery is operational

The framework is ready for more ambitious research.
-/

/-- List of proven theorems -/
def provenTheorems : List String := [
  "ToyTheory is consistent",
  "α is independent of ToyTheory",
  "BiModel swap is an involution",
  "BoolTheory has a dual witness for α",
  "NatTheory is consistent",
  "Double negation introduction",
  "Modus ponens"
]

end MetaMillennium.Status
