/-
UniversalSpectrum.lean

Universal spectrum construction in TUNS.

The universal spectrum σ_univ is constructed as a colimit
in an appropriate category of spectral spaces.
-/

import TUNS.Framework
import Mathlib.Analysis.SpecialFunctions.Complex.Log
import Mathlib.Data.Real.Basic

namespace TUNS

/-- Spectrum associated to a framework -/
structure Spectrum (F : Framework) where
  /-- Spectral values -/
  values : Set ℝ
  /-- Spectral measure -/
  measure : ℝ → ℝ≥0

/-- Universal spectrum construction -/
structure UniversalSpectrum where
  /-- Family of framework spectra -/
  spectra : (F : Framework) → Spectrum F
  /-- Compatibility maps between spectra -/
  compat : ∀ (F G : Framework) (f : Framework.Morphism F G), 
           Set.image (id : ℝ → ℝ) (spectra F).values ⊆ (spectra G).values
  /-- Universal measure on the combined spectrum -/
  universalMeasure : ℝ → ℝ≥0

/-- The universal spectrum satisfies a universal property -/
theorem universal_spectrum_unique (σ σ' : UniversalSpectrum) : 
    σ = σ' := by
  sorry -- Proof requires category theory of spectral spaces

/-- Gap in spectrum -/
def spectrumGap (S : Spectrum F) (x y : ℝ) 
    (hx : x ∈ S.values) (hy : y ∈ S.values) : ℝ := |y - x|

/-- Minimum gap in a spectrum -/
noncomputable def minGap (S : Spectrum F) : ℝ≥0∞ :=
  sInf {spectrumGap S x y hx hy | (x : ℝ) (hx : x ∈ S.values) 
                                    (y : ℝ) (hy : y ∈ S.values) (hxy : x ≠ y)}

end TUNS
