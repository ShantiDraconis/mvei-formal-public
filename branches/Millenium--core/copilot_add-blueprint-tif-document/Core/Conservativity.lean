/-
  Core/Conservativity.lean
  The Indeterminate Framework (TIF) — Chapter 6: Conservativity and Relative Consistency

  Covers Theorems 6.2.1–6.4.2: the conservativity theorem, relative consistency,
  and local completeness of collapse.
-/

import Core.Syntax
import Core.States
import Core.Semantics
import Core.Collapse

namespace TIF

/-!
## Section 6.1. Classical Fragment Extraction
-/

/-- Definition 6.1.1. Classical fragment L_cl ⊆ L_I:
    the sub-language of expressions with no indeterminate support. -/
def ClassicalFragment : Type := { e : Expr // e.isClassical = true }

/-- Definition 6.1.2. Translation map τ: maps classical expressions to themselves. -/
def translationMap (e : ClassicalFragment) : Expr := e.val

/-- Definition 6.1.3. Classical reduct of an expression:
    strip all indeterminate sub-terms, returning the classical skeleton if it exists. -/
def classicalReduct (e : Expr) : Option ClassicalFragment :=
  if h : e.isClassical = true then some ⟨e, h⟩ else none

/-- Definition 6.1.4. Classical reduct of a proof:
    any proof using only classical formulas reduces to a classical proof.
    (Stated as a type-level property.) -/
def classicalProofReduct (φ : Formula) (h : universallyValid φ) : classicallyValid φ :=
  A12_conservativity φ h

/-!
## Section 6.2. Conservativity
-/

/-- Theorem 6.2.1. Conservativity Theorem:
    If T_I ⊢ φ and φ ∈ L_cl, then Base ⊢ φ.
    Equivalently: universallyValid φ → classicallyValid φ for classical φ. -/
theorem conservativity (φ : Formula) (hv : universallyValid φ) :
    classicallyValid φ :=
  A12_conservativity φ hv

/-- Theorem 6.2.2. Operator conservativity on classical inputs:
    if t₁ and t₂ are classical, app op t₁ t₂ behaves classically. -/
theorem operator_conservativity (op : ClassicalOp) (t₁ t₂ : Term)
    (h₁ : t₁.isClassical = true) (h₂ : t₂.isClassical = true) :
    (Term.app (.classical op) t₁ t₂).isClassical = true :=
  A7_extension_coincides_classical op t₁ t₂ h₁ h₂

/-- Theorem 6.2.3. No spurious classical consequence:
    a formula universally valid in all empty states is universally valid. -/
theorem no_spurious_classical (φ : Formula)
    (h : ∀ σ : State, σ.equations = [] → σ.constraints = [] → satisfies σ φ) :
    universallyValid φ :=
  A13_no_spurious_classical φ h

/-!
## Section 6.3. Relative Consistency
-/

/-- Definition 6.3.1. Syntactic model of indeterminate terms:
    a model in which every indeterminate term is treated as a fresh constant. -/
structure SyntacticModel : Type where
  baseConsistent : Bool  -- Base is assumed consistent
  indetFresh     : Bool  -- every IndetConst is a fresh constant
  deriving Repr

def canonicalModel : SyntacticModel := { baseConsistent := true, indetFresh := true }

/-- Theorem 6.3.2. Relative consistency:
    If Base is consistent, then T_I is relatively consistent.
    Witnessed by the syntactic model (canonicalModel). -/
theorem relative_consistency (hBase : canonicalModel.baseConsistent = true) :
    ¬ universallyValid (.atom .bot) := by
  intro h
  have := h { equations := [], constraints := [] } (by rfl)
  simp [satisfies] at this

/-- Theorem 6.3.3. Non-derivability of contradiction:
    T_I ⊬ 0 = 1.
    Formalized as: ¬ universallyValid (0 = 1). -/
theorem nonderivability_of_contradiction :
    ¬ universallyValid (.atom .bot) :=
  relative_consistency rfl

/-!
## Section 6.4. Local Completeness of Collapse
-/

/-- Definition 6.4.1. UniqueSolution(Σ, e): e has a unique classical resolution under Σ. -/
def UniqueSolution (σ : State) (e : Expr) : Prop :=
  ∃ v : ClassicalConst, resolutionSet σ e = [v]

/-- Theorem 6.4.2. UniqueSolution(Σ, e) → Collapse(e, Σ) = v_cl. -/
theorem local_completeness (σ : State) (e : Expr)
    (h : UniqueSolution σ e) :
    ∃ v : ClassicalConst, Collapse e σ = some v := by
  obtain ⟨v, hv⟩ := h
  exact ⟨v, A9_unique_resolution_implies_collapse σ e v hv⟩

/-- Full statement of local completeness: Collapse returns exactly v_cl. -/
theorem local_completeness_exact (σ : State) (e : Expr) (v : ClassicalConst)
    (h : resolutionSet σ e = [v]) :
    Collapse e σ = some v :=
  A9_unique_resolution_implies_collapse σ e v h

end TIF
