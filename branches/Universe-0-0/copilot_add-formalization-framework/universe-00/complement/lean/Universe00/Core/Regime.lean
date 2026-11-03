/-
  Universe00/Core/Regime.lean
  
  Regime declarations for the Complement Layer.
  
  Every mathematical statement operates within a declared regime:
  - Classical: ZFC with excluded middle
  - Constructive: Constructive mathematics (no LEM)
  - Meadow: Meadow algebra (totalized division)
  - Paraconsistent: Paraconsistent logic (contradiction tolerance)
  - Extreme: Limit-aware mathematics (Complement Layer)
-/

namespace Universe00.Core

/-- Mathematical regime / formal system -/
inductive Regime where
  | Classical      : Regime  -- Classical mathematics (ZFC, LEM)
  | Constructive   : Regime  -- Constructive mathematics (no LEM)
  | Meadow         : Regime  -- Meadow algebra (totalized division)
  | Paraconsistent : Regime  -- Paraconsistent logic
  | Extreme        : Regime  -- Limit-aware (Complement Layer)
  deriving Repr, BEq, DecidableEq

namespace Regime

/-- Check if a regime is classical -/
def isClassical : Regime → Bool
  | Classical => true
  | _         => false

/-- Check if a regime is limit-aware -/
def isLimitAware : Regime → Bool
  | Extreme => true
  | _       => false

/-- Check if regime admits excluded middle -/
def hasExcludedMiddle : Regime → Bool
  | Classical      => true
  | Paraconsistent => true
  | _              => false

/-- Check if regime is total (no undefined operations) -/
def isTotal : Regime → Bool
  | Meadow => true
  | _      => false

/-- Regime transition structure -/
structure Transition (D₁ D₂ : Regime) where
  source : D₁ = D₁
  target : D₂ = D₂
  justification : String

/-- Create a regime transition with justification -/
def transition (D₁ D₂ : Regime) (reason : String) : Transition D₁ D₂ :=
  { source := rfl
  , target := rfl
  , justification := reason }

end Regime

end Universe00.Core
