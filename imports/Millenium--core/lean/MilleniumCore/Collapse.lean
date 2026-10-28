/-
  MilleniumCore.Collapse

  Defines the two collapse functions distinguished in Axiom Sheet v1.2, A6:

    collapseSem : Expr α → State α → Option α
      Semantic collapse  Collapse^sem_Σ : Expr_I ⇀ ℂ
      Returns `some v` iff the expression uniquely evaluates to v under
      all admissible valuations; returns `none` (undefined) otherwise.

    collapseOp  : Expr α → State α → Option α
      Operational collapse  Collapse^op_Σ : Expr_I → ℂ ∪ {⊥}
      Returns `some v` when there is a unique classical resolution;
      returns `none` (the blocked marker ⊥) otherwise.
      Always terminates (total function).

  In the Lean mechanization, both functions share the same type `Option α`:
    · `some v` = unique classical value v
    · `none`   = undefined (semantic) / blocked ⊥ (operational)

  The distinction between the two collapse variants is conceptual and
  documented in comments; it matters for the meta-theory (Lemma O in the
  Semantic Specification).

  Corresponds to:
    Axiom Sheet v1.2, A6–A8
    Semantic Specification, §6 (Collapse Definitions)
    Glossary, Operational Objects

  Note (scalar fragment): the codomain is `Option α` where `α` is the
  type of classical scalars.  When the framework is extended beyond the
  scalar fragment, the collapse codomain will be adjusted.
-/

import MilleniumCore.Eval

namespace MilleniumCore

section
variable {α : Type*} [Field α] [DecidableEq α]

/-!
## Semantic Collapse

Collapse^sem_Σ(e) = v  iff  ⟦e⟧_Σ = {v}
Otherwise undefined (returns `none`).

In the single-valuation skeleton, we use `evalState` as the canonical
admissible valuation.  Full set-quantification over Adm(Σ) is deferred to
a future version.

Axiom Sheet v1.2, A6 (semantic variant) and A7.
-/

/-- Semantic collapse of expression `e` under state `s`.

    Returns `some v` if `e` evaluates to the unique classical value `v`
    under the canonical valuation derived from `s`.
    Returns `none` if the expression is unresolved or blocked.

    Corresponds to Collapse^sem_Σ : Expr_I ⇀ ℂ  (Axiom Sheet v1.2, A6). -/
def collapseSem (s : State α) (dflt : α) (e : Expr α) : Option α :=
  evalState s dflt e

/-!
## Operational Collapse

Collapse^op_Σ(e) = v   if ⟦e⟧_Σ = {v}
                 = ⊥   otherwise  (⊥ represented as `none`)

Total function: always terminates.

Axiom Sheet v1.2, A6 (operational variant) and A8.
-/

/-- Operational collapse of expression `e` under state `s`.

    Returns `some v` if there is a unique classical resolution;
    returns `none`   (the blocked marker ⊥) otherwise.

    This is a total function — it never raises an error or diverges.

    Corresponds to Collapse^op_Σ : Expr_I → ℂ ∪ {⊥}  (Axiom Sheet v1.2, A6).

    In this v1 skeleton, `collapseSem` and `collapseOp` agree; the
    distinction becomes observable once multi-valuation semantics (full
    Adm(Σ) quantification) is added. -/
def collapseOp (s : State α) (dflt : α) (e : Expr α) : Option α :=
  evalState s dflt e

/-!
## Agreement Lemma (Skeleton v1)

In the single-valuation model, semantic and operational collapse agree:
  collapseOp s dflt e = collapseSem s dflt e

This is Lemma O from the Semantic Specification in the skeletal setting.
The non-trivial version (over all admissible valuations) is left for the
full semantic specification proof.
-/

theorem collapseOp_eq_collapseSem (s : State α) (dflt : α) (e : Expr α) :
    collapseOp s dflt e = collapseSem s dflt e := rfl

/-!
## Classical-Fragment Stability (A13)

If an expression `e` contains no `indet` constructor, its collapse under any
state agrees with direct classical evaluation.

In the single-valuation skeleton, this follows from `eval` reducing to
standard field operations on classical sub-expressions.
-/

/-- Classical expressions (no `indet`) evaluate to `some c` for a classical
    constant expression `c`, and collapse correctly. -/
theorem collapseConst_eq (s : State α) (dflt : α) (c : α) :
    collapseOp s dflt (.const c) = some c := rfl

end
end MilleniumCore
