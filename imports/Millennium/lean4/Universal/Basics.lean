-- Universal/Basics.lean
import Mathlib.CategoryTheory.Category.Basic
import Mathlib.Data.Real.Basic
import Mathlib.Data.Complex.Basic
import Mathlib.Topology.Basic

universe u v w

namespace Universal

/-- Um domínio matemático abstrato como no framework:
/-- Um domínio matemático abstrato como no seu framework:
    X = espaço de estados
    L = estrutura local
    G = estrutura global
    loc, glob = projeções local/global
    energy = energia universal em 4 componentes (an, geo, ar, comp)
    timeParam = fluxo temporal interno
-/
structure MathDomain where
  X        : Type u
  L        : Type v
  G        : Type w
  loc      : X → L
  glob     : X → G
  energy   : X → (ℝ × ℝ × ℝ × ℝ)  -- (E_an, E_geo, E_ar, E_comp)
  timeParam : ℝ → X → X

namespace MathDomain

/-- Projeções da energia universal em cada componente. -/
def E_an   (A : MathDomain) (x : A.X) : ℝ := (A.energy x).1
def E_geo  (A : MathDomain) (x : A.X) : ℝ := (A.energy x).2.1
def E_ar   (A : MathDomain) (x : A.X) : ℝ := (A.energy x).2.2.1
def E_comp (A : MathDomain) (x : A.X) : ℝ := (A.energy x).2.2.2

end MathDomain

/-- Morfismo entre domínios, seguindo a definição:
/-- Morfismo entre domínios, seguindo a sua definição:
    só alteramos L e G, X é fixo (age "sobre" os invariantes).
    A cond. de comutatividade: glob_B (φL (loc_A x)) = φG (glob_A x).
-/
structure Morphism (A B : MathDomain) where
  φL : A.L → B.L
  φG : A.G → B.G
  commutes : ∀ x : A.X, φG (A.glob x) = B.glob (φL (A.loc x))

/-- Categoria dos domínios matemáticos. -/
instance : Category MathDomain where
  Hom A B := Morphism A B
  id A := {
    φL := id
    φG := id
    commutes := by intro x; rfl
  }
  comp {A B C} (f : Morphism A B) (g : Morphism B C) :=
  { φL := g.φL ∘ f.φL
    φG := g.φG ∘ f.φG
    commutes := by
      intro x
      -- Queremos: (g.φG ∘ f.φG) (A.glob x) = C.glob ((g.φL ∘ f.φL) (A.loc x))
      -- Expandimos:
      -- LHS = g.φG (f.φG (A.glob x)) = g.φG (B.glob (f.φL (A.loc x)))      (por f.commutes)
      --     = C.glob (g.φL (f.φL (A.loc x)))                              (por g.commutes)
      simp [Function.comp, f.commutes, g.commutes]
  }
    { φL := g.φL ∘ f.φL
      φG := g.φG ∘ f.φG
      commutes := by
        intro x
        -- Queremos: (g.φG ∘ f.φG) (A.glob x) = C.glob ((g.φL ∘ f.φL) (A.loc x))
        -- Expandimos:
        -- LHS = g.φG (f.φG (A.glob x)) = g.φG (B.glob (f.φL (A.loc x)))      (por f.commutes)
        --     = C.glob (g.φL (f.φL (A.loc x)))                              (por g.commutes)
        simp [Function.comp]
        rw [f.commutes]
        rw [g.commutes]
    }

end Universal
