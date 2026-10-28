/-
  SOF Operators - Structural Operators for Obstruction Framework

  This file defines the structural operators U, B, S, E and the
  obstruction operator Ω for the SOF framework.
-/

import SOF.Language

namespace SOF

/-
  STRUCTURAL OPERATORS

  The four structural operators measure properties of systems:

  U(S) : [0,1] - Unification level
  B(S,p) : [0,1] - Global regularity for problem p
  S(S) : [0,1] - Singularity handling capability
  E(S,p) : [0,1] - Structural expansion for problem p
-/

/-- Operator U: Unification -/
def OpU (s : System) : Float :=
  s.components.unification

/-- Operator B: Global Regularity (may depend on problem) -/
def OpB (s : System) (_p : Problem) : Float :=
  s.components.regularity

/-- Operator S: Singularity Handling -/
def OpS (s : System) : Float :=
  s.components.singularity

/-- Operator E: Structural Expansion (may depend on problem) -/
def OpE (s : System) (_p : Problem) : Float :=
  s.components.expansion

/-
  OBSTRUCTION WEIGHTS
-/

/-- Weight record for obstruction calculation -/
structure ObstructionWeights where
  w1 : Float  -- Weight for unification
  w2 : Float  -- Weight for regularity
  w3 : Float  -- Weight for singularity
  w4 : Float  -- Weight for expansion
  deriving Repr

/-- Valid weights: all non-negative and sum to 1 -/
def ObstructionWeights.valid (w : ObstructionWeights) : Prop :=
  w.w1 ≥ 0 ∧ w.w2 ≥ 0 ∧ w.w3 ≥ 0 ∧ w.w4 ≥ 0 ∧
  w.w1 + w.w2 + w.w3 + w.w4 = 1

/-- Default equal weights -/
def equalWeights : ObstructionWeights := {
  w1 := 0.25
  w2 := 0.25
  w3 := 0.25
  w4 := 0.25
}

/-
  THE OBSTRUCTION OPERATOR Ω

  The obstruction operator Ω(S,p) measures the structural obstruction
  to solving problem p in system S.

  Ω(S,p) = w₁(1 - U(S)) + w₂(1 - B(S,p)) + w₃(1 - S(S)) + w₄(1 - E(S,p))

  where w₁ + w₂ + w₃ + w₄ = 1 and all wᵢ ≥ 0.

  Ω = 0 means no obstruction (strong solution possible)
  Ω > 0 means obstruction exists
-/

/-- The obstruction operator with specified weights -/
def Omega (w : ObstructionWeights) (s : System) (p : Problem) : Float :=
  w.w1 * (1 - OpU s) +
  w.w2 * (1 - OpB s p) +
  w.w3 * (1 - OpS s) +
  w.w4 * (1 - OpE s p)

/-- Omega with default equal weights -/
def OmegaEq (s : System) (p : Problem) : Float :=
  Omega equalWeights s p

/-
  SYSTEM-SPECIFIC OBSTRUCTION VALUES
-/

/-- Classical system obstruction value for any problem -/
def omegaClassicalValue : Float := 0.5  -- (1-0)*0.25 + (1-0.5)*0.25 + (1-0.5)*0.25 + (1-0)*0.25 = 0.5

/-- Classical system has positive obstruction (computation) -/
theorem omega_classical_positive_compute (p : Problem) :
    OmegaEq .classical p = omegaClassicalValue := by
  native_decide

/-- Expanded system obstruction value for any problem -/
def omegaExpandedValue : Float := 0.0  -- All components are 1

/-- Unified system obstruction value for any problem -/
def omegaUnifiedValue : Float := 0.0  -- All components are 1

/-- Unified system has zero obstruction (computation) -/
theorem omega_unified_zero_compute (p : Problem) :
    OmegaEq .unified p = omegaUnifiedValue := by
  native_decide

/-
  LOGICAL PROMOTION OPERATOR

  The logical promotion operator states that in the unified system,
  weak solutions become strong solutions.

  WeakSol(S_new, p) => StrongSol(S_new, p)

  This is possible when Omega(S_new, p) = 0.
-/

/-- The logical promotion property for a system -/
def LogicalPromotion (s : System) : Prop :=
  ∀ p, WeakSol s p → StrongSol s p

/-- The unified system has logical promotion (axiom) -/
axiom unified_has_promotion : LogicalPromotion .unified

end SOF
