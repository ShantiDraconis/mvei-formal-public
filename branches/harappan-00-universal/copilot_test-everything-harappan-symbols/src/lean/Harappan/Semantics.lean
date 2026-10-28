/-
  Harappan Universal Testbed - Semantics
  
  Formalization of semantic hypotheses and relationships.
-/

import Harappan.BasicTypes

namespace Harappan

/-- Semantic field (domain) -/
inductive SemanticField where
  | trade : SemanticField
  | religion : SemanticField
  | governance : SemanticField
  | agriculture : SemanticField
  | kinship : SemanticField
  | nature : SemanticField
  | artifact : SemanticField
  deriving Repr, BEq

/-- A semantic concept -/
structure Concept where
  name : String
  field : SemanticField
  archetypes : List Archetype
  deriving Repr

/-- A meaning hypothesis for a sign -/
structure MeaningHypothesis where
  signId : SignId
  meaning : String
  concept : Concept
  confidence : Confidence
  source : String
  deriving Repr

/-- Semantic relationship types -/
inductive SemanticRelation where
  | synonym : SemanticRelation
  | antonym : SemanticRelation
  | hypernym : SemanticRelation  -- "is-a"
  | hyponym : SemanticRelation   -- "kind-of"
  | meronym : SemanticRelation   -- "part-of"
  | holonym : SemanticRelation   -- "has-part"
  | association : SemanticRelation
  deriving Repr, BEq

/-- A semantic edge in the meaning graph -/
structure SemanticEdge where
  from_ : SignId
  to_ : SignId
  relation : SemanticRelation
  weight : Float
  deriving Repr

/-- Semantic graph for Harappan signs -/
structure SemanticGraph where
  nodes : List SignId
  edges : List SemanticEdge
  meanings : List MeaningHypothesis

/-- Find all signs related to a given sign -/
def SemanticGraph.relatedTo (g : SemanticGraph) (id : SignId) : List (SignId × SemanticRelation) :=
  g.edges.filterMap fun e =>
    if e.from_ == id then some (e.to_, e.relation)
    else if e.to_ == id then some (e.from_, e.relation)
    else none

/-- Check if two signs are semantically connected -/
def SemanticGraph.connected (g : SemanticGraph) (id1 id2 : SignId) : Bool :=
  g.edges.any fun e =>
    (e.from_ == id1 && e.to_ == id2) ||
    (e.from_ == id2 && e.to_ == id1)

/-- Get all meanings for a sign -/
def SemanticGraph.meaningsFor (g : SemanticGraph) (id : SignId) : List MeaningHypothesis :=
  g.meanings.filter (fun m => m.signId == id)

/-- Consistency: no sign should have contradictory primary meanings -/
def SemanticGraph.consistent (g : SemanticGraph) : Prop :=
  -- For each sign, meanings should not contradict
  g.nodes.all fun id =>
    let meanings := g.meaningsFor id
    -- Simplified: at most one high-confidence meaning
    (meanings.filter (fun m => m.confidence.value > 0.8)).length ≤ 1

end Harappan
