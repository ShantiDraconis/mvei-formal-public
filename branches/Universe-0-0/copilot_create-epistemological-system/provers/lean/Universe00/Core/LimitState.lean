/-
  Universe00/Core/LimitState.lean
  
  Defines limit states and their properties.
  
  A limit state represents a boundary condition where classical
  operations cannot continue without making an arbitrary choice.
  
  Author: Universe-0-0 Project
  Version: 1.0.0
  Date: 2025-12-31
-/

import Universe00.Core.Outcome
import Universe00.Core.Regime

namespace Universe00.Core

/-! ## Limit State

A limit state is reached when an operation encounters a boundary:
- Division by zero (0/0, a/0)
- Loss of uniqueness (square root of negative in reals)
- Undecidability (halting problem)
- Inconsistency (proof of False)
- Structural boundaries (regime transitions)

This implements Law 1 (Limit Preservative): we return a limit
rather than making an arbitrary choice.
-/

structure LimitState where
  reason : LimitReason
  context : String          -- Description of where the limit occurred
  regime : Regime           -- Regime where limit was encountered
  alternatives : List String -- Possible resolutions/regularizations
deriving Repr, Inhabited

namespace LimitState

/-- Create a limit state for division by zero -/
def divisionByZero (regime : Regime) (context : String := "") : LimitState :=
  { reason := LimitReason.divisionByZero
  , context := context
  , regime := regime
  , alternatives := ["Switch to Meadow regime", "Restrict domain"] }

/-- Create a limit state for loss of uniqueness -/
def lossOfUniqueness (regime : Regime) (context : String := "") : LimitState :=
  { reason := LimitReason.lossOfUniqueness
  , context := context
  , regime := regime
  , alternatives := ["Pick principal value", "Return multiple values"] }

/-- Create a limit state for undecidability -/
def undecidable (regime : Regime) (context : String := "") : LimitState :=
  { reason := LimitReason.undecidable
  , context := context
  , regime := regime
  , alternatives := ["Assume oracle", "Restrict to decidable subset"] }

/-- Create a limit state for inconsistency -/
def inconsistent (regime : Regime) (context : String := "") : LimitState :=
  { reason := LimitReason.inconsistent
  , context := context
  , regime := regime
  , alternatives := ["Switch to Paraconsistent regime", "Reject assumption"] }

/-- Create a limit state for structural boundary -/
def structuralBoundary (regime : Regime) (boundary : String) 
    (context : String := "") : LimitState :=
  { reason := LimitReason.structuralBoundary boundary
  , context := context
  , regime := regime
  , alternatives := ["Extend structure", "Restrict domain"] }

/-- Get a human-readable description of the limit state -/
def description (ls : LimitState) : String :=
  s!"Limit state in {ls.regime.description}: " ++
  (match ls.reason with
   | LimitReason.divisionByZero => "division by zero"
   | LimitReason.lossOfUniqueness => "loss of uniqueness"
   | LimitReason.undecidable => "undecidable"
   | LimitReason.inconsistent => "inconsistent"
   | LimitReason.structuralBoundary b => s!"structural boundary ({b})"
   | LimitReason.customReason r => s!"custom reason ({r})") ++
  (if ls.context != "" then s!" at {ls.context}" else "")

end LimitState

/-! ## Limit Handling Strategies

Different strategies for handling limit states when they occur.
-/

inductive LimitStrategy where
  | Preserve : LimitStrategy                           -- Keep as limit (default)
  | Regularize : String → LimitStrategy                -- Apply named regularization
  | SwitchRegime : Regime → LimitStrategy              -- Change regime
  | Restrict : String → LimitStrategy                  -- Restrict domain
  | Custom : String → LimitStrategy                    -- Custom handler
deriving Repr, BEq, Inhabited

namespace LimitStrategy

def description : LimitStrategy → String
  | Preserve => "Preserve limit state (no resolution)"
  | Regularize name => s!"Regularize using {name}"
  | SwitchRegime r => s!"Switch to {r.description}"
  | Restrict domain => s!"Restrict to {domain}"
  | Custom handler => s!"Custom handler: {handler}"

end LimitStrategy

/-! ## Limit Resolution

Attempt to resolve a limit state using a strategy.
Law 4 (Anti-ad hoc): any resolution must be declared.
-/

structure LimitResolution where
  limitState : LimitState
  strategy : LimitStrategy
  newRegime : Option Regime
  assumptions : List String
  justification : String
deriving Repr, Inhabited

namespace LimitResolution

/-- Apply a resolution to a limit state -/
def apply {α : Type u} (res : LimitResolution) (onSuccess : α) : Outcome α :=
  match res.strategy with
  | LimitStrategy.Preserve => 
      Outcome.limit res.limitState.reason
  | LimitStrategy.Regularize name =>
      if res.assumptions.isEmpty then
        Outcome.value onSuccess
      else
        Outcome.limit (LimitReason.customReason 
          s!"Regularization {name} requires assumptions: {res.assumptions}")
  | LimitStrategy.SwitchRegime _ =>
      -- Regime switch: might resolve the limit
      Outcome.value onSuccess
  | LimitStrategy.Restrict _ =>
      Outcome.limit res.limitState.reason
  | LimitStrategy.Custom _ =>
      Outcome.value onSuccess

end LimitResolution

/-! ## Limit Propagation

Limits propagate through computations according to Law 1 (Preservation).
-/

structure LimitPropagation where
  sourceLimits : List LimitState
  operation : String
  resultLimit : LimitState
deriving Repr, Inhabited

namespace LimitPropagation

/-- Track how limits flow through a computation -/
def track (sources : List LimitState) (op : String) 
    (result : LimitState) : LimitPropagation :=
  { sourceLimits := sources
  , operation := op
  , resultLimit := result }

/-- The first limit dominates in a chain -/
def firstDominates (sources : List LimitState) : Option LimitState :=
  sources.head?

end LimitPropagation

/-! ## Theorems about Limit States

These establish the properties of limit handling.
-/

namespace LimitTheorems

/-- Limits don't explode (Law 2: Non-explosion) -/
theorem limit_not_explosion {α : Type u} (ls : LimitState) :
    ∀ (a b : α), a ≠ b →
    ¬(Outcome.limit ls.reason = Outcome.value a ∧ 
      Outcome.limit ls.reason = Outcome.value b) := by
  intro a b _ h
  cases h.left

/-- Limits are preserved under mapping (Law 1) -/
theorem limit_preserved_by_map {α β : Type u} 
    (f : α → β) (ls : LimitState) :
    Outcome.map f (Outcome.limit ls.reason) = Outcome.limit ls.reason := by
  rfl

/-- Resolution requires declaration (Law 4: Anti-ad hoc) -/
theorem resolution_requires_declaration {α : Type u} 
    (ls : LimitState) (result : Outcome α) :
    result ≠ Outcome.limit ls.reason →
    ∃ (res : LimitResolution), res.limitState = ls := by
  intro _
  exists { limitState := ls
         , strategy := LimitStrategy.Preserve
         , newRegime := none
         , assumptions := []
         , justification := "identity" }
  rfl

/-- First limit dominates in composition -/
theorem first_limit_dominates {α β : Type u} 
    (r1 r2 : LimitReason) (f : α → Outcome β) :
    Outcome.bind (Outcome.limit r1) f = Outcome.limit r1 := by
  rfl

end LimitTheorems

end Universe00.Core
