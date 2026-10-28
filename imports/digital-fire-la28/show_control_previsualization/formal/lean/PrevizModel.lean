namespace ShowControlPreviz

inductive CueMode where
  | simulation_only
  deriving DecidableEq, Repr

structure Cue where
  cueId : String
  mode : CueMode
  action : String

abbrev CueMap := List Cue

def isSimulationOnly (c : Cue) : Prop := c.mode = CueMode.simulation_only

def safeCueMap (m : CueMap) : Prop := ∀ c ∈ m, isSimulationOnly c

theorem singletonSafe (c : Cue) (h : c.mode = CueMode.simulation_only) :
    safeCueMap [c] := by
  intro x hx
  simp at hx
  rcases hx with rfl
  exact h

end ShowControlPreviz
