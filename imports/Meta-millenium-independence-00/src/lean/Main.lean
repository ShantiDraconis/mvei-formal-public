/-
  Meta-Millennium Independence Framework
  Main entry point
-/

import MetaMillennium.Core.LogicBasics
import MetaMillennium.Core.TheoryAndModel
import MetaMillennium.Core.ConsistencyAndIndependence
import MetaMillennium.Core.ThreeStateLogic
import MetaMillennium.DualState.DualStateDefinition
import MetaMillennium.DualState.BiModel
import MetaMillennium.DualState.DualStateLemmas
import MetaMillennium.Problems.MillenniumSentences

def main : IO Unit := do
  IO.println "Meta-Millennium Independence Framework"
  IO.println "======================================"
  IO.println "Exploring formal independence of the Millennium Problems"
  IO.println ""
  IO.println "Modules:"
  IO.println "  - Core: Logic basics, theory, model, consistency"
  IO.println "  - DualState: DS(T, φ), BiModel framework"
  IO.println "  - Problems: Millennium problem formalizations"
  IO.println "  - Bridges: Forcing, Inner Models, Large Cardinals"
