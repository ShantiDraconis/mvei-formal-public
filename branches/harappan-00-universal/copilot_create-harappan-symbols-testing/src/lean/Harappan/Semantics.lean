/-
  Harappan Semantics
  
  Formal definitions for semantic relationships between signs,
  meanings, and archetypes.
-/

import Harappan.BasicTypes

namespace Harappan.Semantics

open Harappan

/-- Semantic relation types -/
inductive SemanticRelation
  | associated_with     -- General association
  | opposition          -- Opposing concepts (water/fire)
  | transformation      -- One transforms into another
  | containment         -- One contains another
  | generation          -- One generates another
  | part_of             -- Meronymic relation
  deriving DecidableEq, Repr

/-- A semantic edge in the graph -/
structure SemanticEdge where
  source : String
  target : String
  relation : SemanticRelation
  weight : Float
  deriving Repr

/-- A semantic graph -/
structure SemanticGraph where
  nodes : List String
  edges : List SemanticEdge
  deriving Repr

/-- Check if a node exists in the graph -/
def has_node (g : SemanticGraph) (node : String) : Bool :=
  g.nodes.contains node

/-- Check if an edge exists in the graph -/
def has_edge (g : SemanticGraph) (source target : String) : Bool :=
  g.edges.any (fun e => e.source = source ∧ e.target = target)

/-- Get neighbors of a node -/
def get_neighbors (g : SemanticGraph) (node : String) : List String :=
  g.edges.filterMap (fun e => 
    if e.source = node then some e.target
    else if e.target = node then some e.source
    else none)

/-- A sign-meaning assignment -/
structure SignMeaning where
  sign_id : SignId
  meanings : List String
  primary_meaning : String
  confidence : Float
  deriving Repr

/-- Semantic consistency: no sign has contradictory meanings -/
def meanings_consistent (m : SignMeaning) (opposing_pairs : List (String × String)) : Bool :=
  not (opposing_pairs.any (fun (a, b) => 
    m.meanings.contains a && m.meanings.contains b))

/-- A complete semantic interpretation -/
structure SemanticInterpretation where
  assignments : List SignMeaning
  graph : SemanticGraph
  h_all_signs_in_graph : ∀ a ∈ assignments, has_node graph a.primary_meaning

/-- Semantic field -/
structure SemanticField where
  name : String
  concepts : List String
  archetype : Archetype
  deriving Repr

/-- Predefined semantic fields -/
def water_field : SemanticField := {
  name := "aquatic"
  concepts := ["water", "flow", "fish", "river", "life"]
  archetype := .water
}

def fire_field : SemanticField := {
  name := "igneous"
  concepts := ["fire", "heat", "transformation", "light", "energy"]
  archetype := .fire
}

def boundary_field : SemanticField := {
  name := "liminal"
  concepts := ["boundary", "container", "limit", "vessel", "enclosure"]
  archetype := .boundary
}

/-- Check if a concept belongs to a semantic field -/
def in_field (concept : String) (field : SemanticField) : Bool :=
  field.concepts.contains concept

/-- Get the field for a concept -/
def get_field (concept : String) (fields : List SemanticField) : Option SemanticField :=
  fields.find? (fun f => in_field concept f)

/-- Theorem: Empty graph has no edges -/
theorem empty_graph_no_edges : 
  let g : SemanticGraph := { nodes := [], edges := [] }
  ∀ s t, has_edge g s t = false := by
  intro s t
  simp [has_edge, List.any]

/-- Theorem: Node membership is decidable -/
theorem node_membership_decidable (g : SemanticGraph) (node : String) :
  Decidable (has_node g node = true) := by
  simp [has_node]
  infer_instance

end Harappan.Semantics
