/-
  Harappan Universal Testbed - Semantics
  ======================================
  
  This file defines semantic structures for Harappan signs.
  
  Key concepts:
  - Semantic categories and relations
  - Archetype mappings
  - Meaning hypotheses
-/

import Harappan.BasicTypes
import Harappan.SignSet

namespace Harappan.Semantics

-- Semantic category
inductive SemanticCategory
  | noun : SemanticCategory
  | verb : SemanticCategory
  | adjective : SemanticCategory
  | determinative : SemanticCategory
  | numeral : SemanticCategory
  | pronoun : SemanticCategory
  | particle : SemanticCategory
  | unknown : SemanticCategory
  deriving Repr, DecidableEq

-- Semantic relation types
inductive SemanticRelation
  | synonym : SemanticRelation       -- Same meaning
  | antonym : SemanticRelation       -- Opposite meaning
  | hypernym : SemanticRelation      -- More general
  | hyponym : SemanticRelation       -- More specific
  | meronym : SemanticRelation       -- Part of
  | holonym : SemanticRelation       -- Contains
  | associated : SemanticRelation    -- General association
  deriving Repr, DecidableEq

-- A meaning hypothesis for a sign
structure MeaningHypothesis where
  signId : SignId
  meaning : String
  category : SemanticCategory
  confidence : Float
  source : String
  relatedMeanings : List String := []

-- Semantic edge in graph
structure SemanticEdge where
  from : SignId
  to : SignId
  relation : SemanticRelation
  weight : Float := 1.0

-- Semantic graph
structure SemanticGraph where
  nodes : List SignId
  edges : List SemanticEdge

-- Check if graph contains a node
def SemanticGraph.hasNode (g : SemanticGraph) (sid : SignId) : Bool :=
  g.nodes.any (· == sid)

-- Get edges from a node
def SemanticGraph.edgesFrom (g : SemanticGraph) (sid : SignId) : List SemanticEdge :=
  g.edges.filter (·.from == sid)

-- Get edges to a node
def SemanticGraph.edgesTo (g : SemanticGraph) (sid : SignId) : List SemanticEdge :=
  g.edges.filter (·.to == sid)

-- Degree of a node (total edges)
def SemanticGraph.degree (g : SemanticGraph) (sid : SignId) : Nat :=
  (g.edgesFrom sid).length + (g.edgesTo sid).length

-- Find most connected node
def SemanticGraph.centralNode (g : SemanticGraph) : Option SignId :=
  g.nodes.foldl (fun acc sid =>
    match acc with
    | none => some sid
    | some best =>
      if g.degree sid > g.degree best then some sid else acc
  ) none

-- A semantic cluster is a group of related signs
structure SemanticCluster where
  name : String
  archetype : Archetype
  signs : List SignId
  coherence : Float  -- How tightly clustered

-- Semantic system: collection of hypotheses and relations
structure SemanticSystem where
  hypotheses : List MeaningHypothesis
  graph : SemanticGraph
  clusters : List SemanticCluster

-- Get all hypotheses for a sign
def SemanticSystem.hypothesesFor (sys : SemanticSystem) (sid : SignId) : List MeaningHypothesis :=
  sys.hypotheses.filter (·.signId == sid)

-- Get best (highest confidence) hypothesis for a sign
def SemanticSystem.bestHypothesis (sys : SemanticSystem) (sid : SignId) : Option MeaningHypothesis :=
  let hyps := sys.hypothesesFor sid
  hyps.foldl (fun acc h =>
    match acc with
    | none => some h
    | some best => if h.confidence > best.confidence then some h else acc
  ) none

-- Check if two signs are semantically related
def SemanticSystem.areRelated (sys : SemanticSystem) (s1 s2 : SignId) : Bool :=
  sys.graph.edges.any (fun e => 
    (e.from == s1 && e.to == s2) || (e.from == s2 && e.to == s1))

-- Theorem: Semantic relations are between existing nodes
theorem SemanticGraph.edge_nodes_exist (g : SemanticGraph) (e : SemanticEdge) :
    e ∈ g.edges → g.hasNode e.from ∧ g.hasNode e.to := by
  intro _
  sorry  -- Would need invariant on SemanticGraph construction

-- Average confidence of hypotheses
def SemanticSystem.averageConfidence (sys : SemanticSystem) : Float :=
  if sys.hypotheses.isEmpty then 0.0
  else
    let total := sys.hypotheses.foldl (fun acc h => acc + h.confidence) 0.0
    total / Float.ofNat sys.hypotheses.length

-- Count hypotheses by category
def SemanticSystem.categoryCount (sys : SemanticSystem) (cat : SemanticCategory) : Nat :=
  sys.hypotheses.filter (·.category == cat) |>.length

-- Partition of semantic categories
-- Theorem: Categories partition all hypotheses
theorem SemanticSystem.category_partition (sys : SemanticSystem) :
    sys.hypotheses.length = 
      sys.categoryCount .noun +
      sys.categoryCount .verb +
      sys.categoryCount .adjective +
      sys.categoryCount .determinative +
      sys.categoryCount .numeral +
      sys.categoryCount .pronoun +
      sys.categoryCount .particle +
      sys.categoryCount .unknown := by
  sorry  -- Requires proof about filter partitioning

-- An archetype assignment is consistent if similar signs have similar archetypes
def isConsistentArchetypeAssignment (clusters : List SemanticCluster) (graph : SemanticGraph) : Bool :=
  -- For each pair of related signs, check if they're in related clusters
  graph.edges.all (fun e =>
    let c1 := clusters.find? (fun c => c.signs.any (· == e.from))
    let c2 := clusters.find? (fun c => c.signs.any (· == e.to))
    match c1, c2 with
    | some cluster1, some cluster2 => 
      cluster1.archetype == cluster2.archetype || e.relation == .antonym
    | _, _ => true  -- Unclustered signs don't violate consistency
  )

end Harappan.Semantics
