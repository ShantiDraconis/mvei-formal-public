/-
  MetaMillennium.Bridges.BridgeOverview
  Overview of the three bridges to independence
-/

import MetaMillennium.Forcing.ForcingToDualState
import MetaMillennium.InnerModels.InnerModelsToDualState
import MetaMillennium.LargeCardinals.LC_ToDualState

namespace MetaMillennium.Bridges

open MetaMillennium.Core

/-- The three bridges to independence -/
inductive Bridge where
  | forcing      -- Cohen-style forcing extensions
  | innerModels  -- L and core models
  | largeCardinals -- Measurable, Woodin, etc.
  deriving Repr, BEq

/-- Description of each bridge -/
def Bridge.description : Bridge → String
  | .forcing => "Forcing: construct generic extensions M[G] with new truths"
  | .innerModels => "Inner Models: find L-like models with different truths"
  | .largeCardinals => "Large Cardinals: use hierarchy of consistency strength"

/-- When to use each bridge -/
def Bridge.whenToUse : Bridge → String
  | .forcing => "Use when the sentence involves 'high' set-theoretic content (CH, MA, etc.)"
  | .innerModels => "Use when comparing constructible vs full universe"
  | .largeCardinals => "Use when strength calibration matters"

/-- Combining bridges -/
def combined_approach : String :=
  "The bridges can be combined: " ++
  "1. Start with L (inner model) " ++
  "2. Add forcing extension " ++
  "3. Consider large cardinal hypotheses " ++
  "This gives a rich landscape of models."

/-- Summary for each Millennium Problem -/
def millennium_bridge_summary : List (String × Bridge × String) := [
  ("RH", .forcing, "Unlikely to help due to absoluteness"),
  ("P vs NP", .forcing, "Might help with non-standard models"),
  ("NS", .innerModels, "Analysis is absolute between L and V"),
  ("BSD", .innerModels, "Arithmetic, absolute"),
  ("Hodge", .largeCardinals, "Might be LC-sensitive"),
  ("YM", .forcing, "Awaiting formalization")
]

end MetaMillennium.Bridges
