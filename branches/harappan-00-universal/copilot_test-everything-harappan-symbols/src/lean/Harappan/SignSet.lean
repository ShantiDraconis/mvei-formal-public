/-
  Harappan Universal Testbed - Sign Set
  
  Formalization of the Harappan sign inventory.
-/

import Harappan.BasicTypes

namespace Harappan

/-- A Harappan sign with its properties -/
structure Sign where
  signId : SignId
  position : Position
  frequency : Float
  h_freq_bounds : 0 ≤ frequency ∧ frequency ≤ 1
  deriving Repr

/-- A sign sequence (inscription) -/
def SignSequence := List Sign

/-- Check if a sign sequence is well-formed -/
def SignSequence.wellFormed (seq : SignSequence) : Prop :=
  match seq with
  | [] => True
  | [_] => True
  | s :: rest =>
    -- First sign should be in initial position
    (seq.head?.map (·.position) = some Position.initial) ∧
    -- Last sign should be in final position  
    (seq.getLast?.map (·.position) = some Position.final)

/-- The set of all known signs -/
structure SignSet where
  signs : List Sign
  h_nonempty : signs.length > 0
  h_unique : signs.map (·.signId) |>.Nodup

/-- Get a sign by ID from the set -/
def SignSet.get? (ss : SignSet) (id : SignId) : Option Sign :=
  ss.signs.find? (fun s => s.signId == id)

/-- Total frequency should sum to approximately 1 -/
def SignSet.frequencyConsistent (ss : SignSet) : Prop :=
  let total := ss.signs.foldl (fun acc s => acc + s.frequency) 0
  total ≤ 1.1 ∧ total ≥ 0.9

/-- Sign clusters based on properties -/
structure SignCluster where
  name : String
  members : List SignId
  criterion : Sign → Bool

/-- Check if all members satisfy the cluster criterion -/
def SignCluster.consistent (c : SignCluster) (ss : SignSet) : Prop :=
  c.members.all fun id =>
    match ss.get? id with
    | some s => c.criterion s
    | none => false

end Harappan
