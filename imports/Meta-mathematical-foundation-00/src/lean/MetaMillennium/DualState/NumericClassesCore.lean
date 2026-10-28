/-
  MetaMillennium.DualState.NumericClassesCore
  
  Core types for numeric classes.
-/

namespace MetaMillennium.DualState.NumericClasses

/-- Independence Numbers -/
structure IndependenceNumber where
  i_plus : ℝ≥0
  i_minus : ℝ≥0
  i_rel : ℝ≥0

/-- Axiomatizable Numbers -/
structure AxiomatizableNumber where
  min_axioms : ℕ
  
/-- Multimodel Numbers -/
structure MultimodelNumber where
  n_plus : ℕ
  n_minus : ℕ
  n_und : ℕ

/-- Equivalence-Breaking Numbers -/
structure EquivalenceBreakingNumber where
  fragility : ℝ≥0

/-- Critical Zero Numbers (for RH) -/
structure CriticalZeroNumber where
  on_critical_line : Bool
  deviation : ℝ≥0

/-- Separation Numbers (for P vs NP) -/
structure SeparationNumber where
  separation_strength : ℝ≥0
  barrier_count : ℕ

/-- Regularity Numbers (for NS) -/
structure RegularityNumber where
  space_reg : ℝ≥0
  time_reg : ℝ≥0
  has_singularity : Bool

/-- Mordell-Weil Rank Numbers (for BSD) -/
structure MordellWeilNumber where
  alg_rank : ℕ
  an_rank : ℕ
  discrepancy : ℤ

/-- Hodge Cycle Numbers -/
structure HodgeCycleNumber where
  hodge_dim : ℕ
  algebraic_dim : ℕ
  transcendental_dim : ℕ

/-- Mass Gap Numbers (for YM) -/
structure MassGapNumber where
  mass_gap : ℝ≥0
  exists_gap : Bool

/-- Structural Dependency Numbers -/
structure StructuralDependencyNumber where
  dependency_strength : ℝ≥0

/-- Obstruction Numbers -/
structure ObstructionNumber where
  obstruction_strength : ℝ≥0 ∪ {⊤}

/-- Dual-State Magnitude Numbers -/
structure DSMagnitudeNumber where
  magnitude : ℝ≥0

end MetaMillennium.DualState.NumericClasses
