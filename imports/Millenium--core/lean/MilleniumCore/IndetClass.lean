/-
  MilleniumCore.IndetClass

  Defines the type of indetermination classes {𝒥₀, 𝒥₁, …}.

  In the mathematical presentation (Axiom Sheet v1.2, L1):
    - 𝒥₀ is the "0/0" origin class (A2).
    - Additional classes 𝒥ₖ allow future tracking of distinct indetermination
      origins (e.g. ∞/∞, symbolic unknowns).

  The distinguished constant I of indeterminate sort (L1, language declaration)
  is represented at the term level as `Expr.indet IndetClass.i0` (see Expr.lean).
-/

namespace MilleniumCore

/-- An indetermination class tag.  The natural number index distinguishes
    different origins of indetermination.  `IndetClass.mk 0` (written `i0`)
    is the canonical "0/0" class corresponding to 𝒥₀. -/
structure IndetClass where
  index : ℕ
  deriving DecidableEq, Repr

namespace IndetClass

/-- The distinguished class 𝒥₀: the "0/0" origin (A2 of Axiom Sheet v1.2). -/
def i0 : IndetClass := ⟨0⟩

/-- Convenience constructor for higher indetermination classes 𝒥ₖ. -/
def mk (k : ℕ) : IndetClass := ⟨k⟩

instance : ToString IndetClass where
  toString c := s!"𝒥{c.index}"

end IndetClass
end MilleniumCore
