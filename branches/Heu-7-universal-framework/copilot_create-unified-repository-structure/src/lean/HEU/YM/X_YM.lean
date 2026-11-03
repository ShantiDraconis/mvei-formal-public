/-
  HEU-7: Yang-Mills - Domain
  Definition of X_YM: compact simple gauge groups.
-/

namespace HEU.YM

/-- A compact simple Lie group (simplified). -/
inductive CompactSimpleGroup
  | SU (n : ℕ) (h : n ≥ 2)
  | SO (n : ℕ) (h : n ≥ 3)
  | Sp (n : ℕ) (h : n ≥ 1)
  | G2
  | F4
  | E6
  | E7
  | E8

/-- The domain X_YM: all compact simple Lie groups. -/
def X_YM : Set CompactSimpleGroup := Set.univ

/-- A Yang-Mills theory is specified by a gauge group. -/
structure YangMillsTheory where
  gaugeGroup : CompactSimpleGroup

/-- Placeholder for the mass gap of a Yang-Mills theory. -/
noncomputable def massGap (G : CompactSimpleGroup) : ℝ := sorry

/-- The mass gap conjecture: every Yang-Mills theory has positive mass gap. -/
def MassGap_Conjecture : Prop := ∀ G : CompactSimpleGroup, massGap G > 0

end HEU.YM
