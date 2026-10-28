/-
  MilleniumCore.Expr

  Defines the inductive type `Expr α` representing the scalar fragment of
  the extended term language ℒ_I (Axiom Sheet v1.2, L2).

  The type parameter `α` stands for the type of classical scalar constants.
  For the set-theoretic scalar fragment, instantiate `α := ℂ`.
  For abstract algebraic reasoning, any `Field α` works.

  Constructors correspond to L2:
    · var  — a variable x ∈ Var
    · const — a classical constant c ∈ α (i.e., c ∈ ℂ in the scalar case)
    · indet — the constant symbol I of indeterminate sort (language declaration,
              not an existential axiom — Axiom Sheet v1.2, L1)
    · add, sub, mul, div — extended binary operators +ᵢ, -ᵢ, ×ᵢ, /ᵢ (L2)

  Note: The classical fragment ℒ_cl consists of Expr values that contain no
  `indet` constructor (Axiom Sheet v1.2, L3).
-/

import MilleniumCore.IndetClass

namespace MilleniumCore

/-- Variable names are represented as natural numbers (de Bruijn-free style:
    use `String` in a future version if needed for readability). -/
abbrev VarName := ℕ

/-- The inductive expression type for the scalar fragment of ℒ_I.

    `α` is the type of classical scalar constants (e.g., `ℂ` or `ℚ`).

    Constructors:
    - `var n`       : variable with index n  (n ∈ Var)
    - `const c`     : classical constant c   (c ∈ α ≅ ℂ)
    - `indet k`     : indeterminate class 𝒥ₖ; `indet IndetClass.i0` is the
                      canonical representation of the distinguished constant I
    - `add e₁ e₂`  : extended addition      (e₁ +ᵢ e₂)
    - `sub e₁ e₂`  : extended subtraction   (e₁ -ᵢ e₂)
    - `mul e₁ e₂`  : extended multiplication (e₁ ×ᵢ e₂)
    - `div e₁ e₂`  : extended division      (e₁ /ᵢ e₂)
-/
inductive Expr (α : Type*) : Type* where
  | var   : VarName → Expr α
  | const : α → Expr α
  | indet : IndetClass → Expr α
  | add   : Expr α → Expr α → Expr α
  | sub   : Expr α → Expr α → Expr α
  | mul   : Expr α → Expr α → Expr α
  | div   : Expr α → Expr α → Expr α
  deriving Repr

namespace Expr

/-- The canonical representation of the distinguished constant I
    (indeterminate sort, class 𝒥₀).  Axiom Sheet v1.2, L1. -/
def I {α : Type*} : Expr α := .indet IndetClass.i0

/-- An expression is *classical* (belongs to ℒ_cl) iff it contains no
    `indet` constructor.  Axiom Sheet v1.2, L3. -/
def isClassical {α : Type*} : Expr α → Bool
  | .var _       => true
  | .const _     => true
  | .indet _     => false
  | .add e₁ e₂  => e₁.isClassical && e₂.isClassical
  | .sub e₁ e₂  => e₁.isClassical && e₂.isClassical
  | .mul e₁ e₂  => e₁.isClassical && e₂.isClassical
  | .div e₁ e₂  => e₁.isClassical && e₂.isClassical

end Expr
end MilleniumCore
