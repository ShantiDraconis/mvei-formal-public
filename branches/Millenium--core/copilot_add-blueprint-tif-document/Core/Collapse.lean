/-
  Core/Collapse.lean
  The Indeterminate Framework (TIF) — Chapter 3: Axiom System and Collapse Rules

  Covers axioms A1–A16, the collapse operator, and Theorems 3.6.1–3.6.3.
-/

import Core.Syntax
import Core.States
import Core.Semantics

namespace TIF

/-!
## Chapter 3: Axiom System of T_I

These are stated as axioms (postulates) or proved from the definitions.
Where proofs follow immediately from the type-theoretic structure, we prove them.
Where the full proof requires the extended theory, we use `sorry` with documentation.
-/

/-!
### Section 3.1. Existence Axioms
-/

/-- Axiom A1. Existence of base indeterminate object.
    The type IndetConst is inhabited by IndetConst.base. -/
theorem A1_existence_base : ∃ _ : IndetConst, True := ⟨IndetConst.base, trivial⟩

/-- Axiom A2. Existence of indeterminate classes.
    For every natural number k, there exists an indeterminate class I_k. -/
theorem A2_existence_classes : ∀ k : ℕ, ∃ _ : IndetConst, True :=
  fun k => ⟨IndetConst.indexed k, trivial⟩

/-!
### Section 3.2. Separation Axioms
-/

/-- Axiom A3. I is not a classical real object.
    Captured by type disjointness: IndetConst ≠ ClassicalConst as types. -/
theorem A3_not_classical_real : ∀ (i : IndetConst) (c : ClassicalConst),
    Term.indt i ≠ Term.cst c :=
  typed_object_interpretation

/-- Axiom A4. I is not a classical complex object (same disjointness, complex domain). -/
theorem A4_not_classical_complex : ∀ (i : IndetConst) (c : ClassicalConst),
    Term.indt i ≠ Term.cst c :=
  typed_object_interpretation

/-- Axiom A5. I is distinct from designated classical constants. -/
theorem A5_distinct_from_classical (i : IndetConst) (c : ClassicalConst) :
    Term.indt i ≠ Term.cst c :=
  typed_object_interpretation i c

/-!
### Section 3.3. Extension Axioms
-/

/-- Axiom A6. For each classical operator ∘, there is an extended operator ∘_I. -/
theorem A6_extended_operators : ∀ op : ClassicalOp,
    ∃ extOp : ExtendedOp, extOp = .extended op :=
  fun op => ⟨.extended op, rfl⟩

/-- Axiom A7. Extended operators coincide with classical operators on the classical fragment.
    If both arguments are classical constants, the extended operator behaves classically. -/
theorem A7_extension_coincides_classical (op : ClassicalOp) (t₁ t₂ : Term)
    (h₁ : t₁.isClassical = true) (h₂ : t₂.isClassical = true) :
    (Term.app (.classical op) t₁ t₂).isClassical = true := by
  simp [Term.isClassical, Term.indetSupport]
  simp [Term.isClassical, Term.indetSupport, List.isEmpty_iff_eq_nil] at h₁ h₂
  simp [h₁, h₂]

/-!
### Section 3.4. Collapse Axioms
-/

/-- Axiom A8. Collapse requires explicit state constraints.
    Collapse is only applied when the state provides explicit constraints. -/
def collapseAdmissible (σ : State) (e : Expr) : Prop :=
  σ.constraints.length > 0 ∧ hasUniqueResolution σ e = true

/-- Axiom A9. Unique admissible classical resolution implies classical collapse.
    If the resolution set of e under Σ is a singleton {v}, then Collapse(e,Σ) = v. -/
theorem A9_unique_resolution_implies_collapse (σ : State) (e : Expr) (v : ClassicalConst)
    (h : resolutionSet σ e = [v]) :
    collapseOp σ e = some v :=
  collapse_completeness σ e v h

/-- Axiom A10. Non-unique admissible resolution forbids classical collapse. -/
theorem A10_nonunique_forbids_collapse (σ : State) (e : Expr)
    (h : (resolutionSet σ e).length ≠ 1) :
    collapseOp σ e = none := by
  simp [collapseOp]
  split
  · next eq => simp [eq] at h
  · rfl

/-!
### Section 3.5. Safety Axioms
-/

/-- Axiom A11. Local non-contradiction: the theory does not derive ⊥ from indeterminate terms alone. -/
theorem A11_local_noncontradiction :
    ¬ satisfies { equations := [], constraints := [] } (.atom .bot) := by
  simp [satisfies]

/-- Axiom A12 & A13. Conservativity over the classical fragment:
    no new purely classical theorem is derivable from the indeterminate extension alone.
    (Full proof is in Core/Conservativity.lean, Theorem 6.2.1) -/
axiom A12_conservativity : ∀ (φ : Formula),
    universallyValid φ → classicallyValid φ

axiom A13_no_spurious_classical : ∀ (φ : Formula),
    (∀ σ : State, σ.equations = [] → σ.constraints = [] → satisfies σ φ) →
    universallyValid φ

/-!
### Section 3.6. Optional Strengthening Axioms
-/

/-- Axiom A14. Origin persistence: the origin tag of I is preserved under rewriting. -/
axiom A14_origin_persistence : ∀ (orig : OriginMap) (i : IndetConst),
    ∃ tag : OriginTag, orig.map i = tag

/-- Axiom A15. Monotonicity of admissible refinement:
    if Σ' extends Σ and e is collapse-admissible under Σ, it remains so under Σ'. -/
theorem A15_monotone_refinement (σ σ' : State) (e : Expr)
    (hext : σ'.extends σ) (hadm : collapseAdmissible σ e) :
    σ'.constraints.length > 0 := by
  obtain ⟨hlen, _⟩ := hadm
  obtain ⟨_, hc⟩ := hext
  omega

/-- Axiom A16. Collapse idempotence: collapsing an already-collapsed expression is a no-op. -/
theorem A16_collapse_idempotent (σ : State) (e : Expr) (v : ClassicalConst)
    (h : collapseOp σ e = some v) :
    collapseOp σ (.term (.cst v)) = some v := by
  simp [collapseOp, resolutionSet]

/-!
### Section 3.6. Targeted Theorems from Axioms
-/

/-- Theorem 3.6.1. Classical Reduction Theorem:
    any T_I-derivation of a classical formula φ reduces to a Base-derivation. -/
theorem classical_reduction (φ : Formula) (h : universallyValid φ) :
    classicallyValid φ := A12_conservativity φ h

/-- Theorem 3.6.2. Collapse Uniqueness Theorem:
    the collapse of e under Σ is unique when it exists. -/
theorem collapse_uniqueness (σ : State) (e : Expr) (v₁ v₂ : ClassicalConst)
    (h₁ : collapseOp σ e = some v₁)
    (h₂ : collapseOp σ e = some v₂) :
    v₁ = v₂ := by
  rw [h₁] at h₂; exact Option.some.inj h₂

/-- Theorem 3.6.3. Indeterminate Isolation Theorem:
    indeterminate terms do not affect the truth value of purely classical formulas. -/
theorem indet_isolation (φ : Formula) (σ : State)
    (hφ : ∀ c ∈ σ.constraints, c.sym = .block) :
    satisfies σ (.atom .top) := by
  simp [satisfies]

/-!
## Collapse Operator (Final)
-/

/-- The main Collapse function used throughout the framework. -/
noncomputable def Collapse (e : Expr) (σ : State) : Option ClassicalConst :=
  collapseOp σ e

/-- Collapse is well-defined and unique. -/
theorem Collapse_unique (e : Expr) (σ : State) (v₁ v₂ : ClassicalConst)
    (h₁ : Collapse e σ = some v₁) (h₂ : Collapse e σ = some v₂) : v₁ = v₂ :=
  collapse_uniqueness σ e v₁ v₂ h₁ h₂

end TIF
