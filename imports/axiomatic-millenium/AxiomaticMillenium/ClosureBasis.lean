import AxiomaticMillenium.DomainChecklist
import AxiomaticMillenium.Closure

namespace AxiomaticMillenium

/-- A named hypothesis used by a closure basis. -/
structure HypothesisSpec where
  id : String
  statement : Prop

def eraseHypothesisById (xs : List HypothesisSpec) (id : String) : List HypothesisSpec :=
  xs.filter (fun h => h.id != id)

/-- A finite basis and a domain-specific sufficiency predicate over hypothesis lists. -/
structure ClosureBasis where
  gap : Pattern
  hypotheses : List HypothesisSpec
  sufficientFor : List HypothesisSpec → Prop

/-- Minimality means the full basis is sufficient and removing any listed hypothesis
by identifier destroys sufficiency. No generic claim is made that such a basis exists. -/
structure MinimalClosureBasis where
  basis : ClosureBasis
  basisHolds : basis.sufficientFor basis.hypotheses
  irredundant :
    ∀ h ∈ basis.hypotheses,
      ¬ basis.sufficientFor (eraseHypothesisById basis.hypotheses h.id)

/-- Generic R-basis package. -/
structure RBasis (Abstract Actual : Type) where
  constructiveRealizer : RealizationOperator Abstract Actual
  obstructionCleared : Prop
  obstructionProof : obstructionCleared

/-- Generic N-basis package. -/
structure NBasis (X Y : Type) (Q : X → Y → Prop) where
  uniformizer : UniformizationOperator X Y Q
  uniformControl : Prop
  uniformControlProof : uniformControl

/-- Generic C-basis package. -/
structure CBasis (Local : Nat → Prop) (Global : Prop) where
  globalizer : GlobalizationOperator Local Global
  uniformAPrioriControl : Prop
  compactnessOrTightness : Prop
  limitStability : Prop
  hUniform : uniformAPrioriControl
  hCompact : compactnessOrTightness
  hStable : limitStability

theorem R_basis_closes
    {A X : Type} (b : RBasis A X)
    (Good : A → Prop) (a : A) (ha : Good a) :
    ∃ x : X, b.constructiveRealizer.project x = a ∧ Good (b.constructiveRealizer.project x) :=
  realization_closes b.constructiveRealizer Good a ha

theorem N_basis_closes
    {X Y : Type} {Q : X → Y → Prop}
    (b : NBasis X Y Q) :
    ∃ F : X → Y, ∀ x, Q x (F x) :=
  uniformization_closes b.uniformizer

theorem C_basis_closes
    {Local : Nat → Prop} {Global : Prop}
    (b : CBasis Local Global) : Global :=
  globalization_closes b.globalizer

end AxiomaticMillenium
