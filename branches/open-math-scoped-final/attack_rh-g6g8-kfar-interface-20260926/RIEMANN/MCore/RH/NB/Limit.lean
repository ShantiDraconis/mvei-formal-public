import MCore.RH.NB.Antitone
import Mathlib.Topology.Order.MonotoneConvergence

namespace MCore.RH.NB
namespace NBHilbertData

variable (D : NBHilbertData)

theorem DN_bddBelow (rho : D.GeneratorFamily) :
    BddBelow (Set.range (D.DN rho)) := by
  refine ⟨0, ?_⟩
  rintro _ ⟨N, rfl⟩
  exact D.DN_nonneg rho N

noncomputable def DNLimit (rho : D.GeneratorFamily) : ℝ :=
  ⨅ N : ℕ, D.DN rho N

theorem tendsto_DN_DNLimit (rho : D.GeneratorFamily) :
    Filter.Tendsto (D.DN rho) Filter.atTop (nhds (D.DNLimit rho)) := by
  unfold DNLimit
  exact tendsto_atTop_ciInf (D.DN_antitone rho) (D.DN_bddBelow rho)

theorem DNLimit_nonneg (rho : D.GeneratorFamily) :
    0 ≤ D.DNLimit rho := by
  unfold DNLimit
  exact le_ciInf (fun N => D.DN_nonneg rho N)

theorem DNLimit_eq_zero_of_arbitrarily_small
    (rho : D.GeneratorFamily)
    (hsmall : ∀ ε : ℝ, 0 < ε → ∃ N : ℕ, D.DN rho N ≤ ε) :
    D.DNLimit rho = 0 := by
  have hnonneg : 0 ≤ D.DNLimit rho := D.DNLimit_nonneg rho
  apply le_antisymm ?_ hnonneg
  by_contra hnot
  have hpos : 0 < D.DNLimit rho := lt_of_not_ge hnot
  obtain ⟨N, hN⟩ := hsmall (D.DNLimit rho / 2) (half_pos hpos)
  have hinf : D.DNLimit rho ≤ D.DN rho N := by
    unfold DNLimit
    exact ciInf_le (D.DN_bddBelow rho) N
  linarith


end NBHilbertData
end MCore.RH.NB
