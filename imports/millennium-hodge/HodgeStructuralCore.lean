import Mathlib

/-!
HodgeStructuralCore.lean

Executable algebraic kernel for the structural Hodge-gap decomposition.
It formalizes only the nested-subspace logic and does not assert universal
Hodge algebraicity.
-/


namespace HodgeStructuralCore

variable {𝕜 V : Type*} [Field 𝕜] [AddCommGroup V] [Module 𝕜 V]

structure GapData where
  alg : Submodule 𝕜 V
  mot : Submodule 𝕜 V
  hodge : Submodule 𝕜 V
  alg_le_mot : alg ≤ mot
  mot_le_hodge : mot ≤ hodge

namespace GapData

variable (G : GapData (𝕜 := 𝕜) (V := V))

/-- Algebraic classes viewed inside the motivated sector. -/
abbrev algInMot : Submodule 𝕜 G.mot :=
  G.alg.comap G.mot.subtype

/-- Motivated classes viewed inside the Hodge sector. -/
abbrev motInHodge : Submodule 𝕜 G.hodge :=
  G.mot.comap G.hodge.subtype

/-- Algebraic classes viewed inside the Hodge sector. -/
abbrev algInHodge : Submodule 𝕜 G.hodge :=
  G.alg.comap G.hodge.subtype

/-- Algebraization defect. -/
abbrev EA := G.mot ⧸ G.algInMot

/-- Hodge-to-motivated defect. -/
abbrev ET := G.hodge ⧸ G.motInHodge

/-- Full structural Hodge defect. -/
abbrev DH := G.hodge ⧸ G.algInHodge

def EAClosed : Prop := G.mot ≤ G.alg
def ETClosed : Prop := G.hodge ≤ G.mot
def DHClosed : Prop := G.hodge ≤ G.alg

def BridgesClosed : Prop := G.EAClosed ∧ G.ETClosed
def StructuralEndpoint : Prop := G.DHClosed

/-- The two exposed inclusions close exactly when the full inclusion closes. -/
theorem structural_closure :
    G.BridgesClosed ↔ G.StructuralEndpoint := by
  constructor
  · rintro ⟨hma, hhm⟩
    intro x hx
    exact hma (hhm hx)
  · intro hha
    constructor
    · intro x hx
      exact hha (G.mot_le_hodge hx)
    · intro x hx
      exact G.alg_le_mot (hha hx)

end GapData
end HodgeStructuralCore
