/- 
Stub for Fourier-Mellin transforms compatible with the truncated window ST.
-/
import Mathlib.Data.Real.Basic

namespace LcRh.Transforms

structure BandLimited where
  carrier : Type
  bandwidth : ℝ

def windowed (B : BandLimited) : Prop := True

end LcRh.Transforms
