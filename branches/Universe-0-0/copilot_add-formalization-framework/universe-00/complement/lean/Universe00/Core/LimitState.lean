/-
  Universe00/Core/LimitState.lean
  
  Limit state: the central object of the Complement Layer.
  
  A limit state represents a structural boundary where computation
  halts consistently without error, falsity, or crash.
  
  Key properties:
  - limit ≠ error (not an unintended failure)
  - limit ≠ false (not a logical value)
  - limit ≠ ∞ (not infinity)
  - limit = preservative halt (consistent boundary)
-/

namespace Universe00.Core

/-- Limit state: structural boundary with explanation -/
structure LimitState where
  tag    : String  -- Category of limit (e.g., "div", "halting", "regime")
  reason : String  -- Formal explanation of why limit occurred
  deriving Repr, BEq

namespace LimitState

/-- Create a limit state for division by zero -/
def divisionByZero : LimitState :=
  { tag := "div"
  , reason := "denominator is zero" }

/-- Create a limit state for halting problem -/
def haltingUndecidable : LimitState :=
  { tag := "halting"
  , reason := "structural undecidability" }

/-- Create a limit state for regime boundary -/
def regimeBoundary (from to : String) : LimitState :=
  { tag := "regime"
  , reason := s!"crossed from {from} to {to}" }

/-- Create a limit state for Gödel incompleteness -/
def godelSentence : LimitState :=
  { tag := "godel"
  , reason := "statement unprovable in system" }

/-- Create a limit state for infinity boundary -/
def infinityBoundary : LimitState :=
  { tag := "infinity"
  , reason := "requires infinite regime" }

/-- Create a custom limit state -/
def custom (tag reason : String) : LimitState :=
  { tag := tag
  , reason := reason }

/-- Get a human-readable description of the limit -/
def describe (ℓ : LimitState) : String :=
  s!"limit({ℓ.tag}): {ℓ.reason}"

end LimitState

end Universe00.Core
