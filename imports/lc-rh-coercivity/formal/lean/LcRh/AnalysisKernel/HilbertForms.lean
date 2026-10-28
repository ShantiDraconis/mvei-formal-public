/-!
  Abstract Hilbert form infrastructure used in the LC ⇒ RH kernel.
-/
namespace LcRh
namespace AnalysisKernel

structure HilbertForm (𝕂 : Type) where
  space : Type
  inner : space → space → 𝕂

end AnalysisKernel
end LcRh
/-
Hilbert form stubs for the Analysis Kernel. These placeholders keep the core
interface stable while backends implement closed forms.
-/
import Mathlib.Data.Real.Basic

namespace LcRh.AnalysisKernel

structure HilbertForm where
  carrier : Type
  inner : carrier → carrier → ℝ

def closed (F : HilbertForm) : Prop := True

end LcRh.AnalysisKernel
