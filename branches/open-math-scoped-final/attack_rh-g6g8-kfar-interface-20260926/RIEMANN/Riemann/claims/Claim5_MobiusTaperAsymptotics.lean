import Riemann.claims.Claim5_ConcreteMobiusVasyuninData

namespace Riemann.claims

theorem tendsto_log_nat_atTop :
    Filter.Tendsto (fun N : ℕ => Real.log (N : ℝ))
      Filter.atTop Filter.atTop := by
  exact Real.tendsto_log_atTop.comp tendsto_natCast_atTop_atTop

theorem mobiusLinearTaper_tendsto_one
    (n : ℕ) (hn : 1 ≤ n) :
    Filter.Tendsto (fun N : ℕ => mobiusLinearTaper N n)
      Filter.atTop (nhds 1) := by
  have hratio :
      Filter.Tendsto (fun N : ℕ => Real.log n / Real.log (N : ℝ))
        Filter.atTop (nhds 0) := by
    exact tendsto_const_nhds.div_atTop tendsto_log_nat_atTop
  have hform :
      (fun N : ℕ => mobiusLinearTaper N n) =ᶠ[Filter.atTop]
        (fun N : ℕ => 1 - Real.log n / Real.log (N : ℝ)) := by
    filter_upwards [Filter.eventually_ge_atTop (max n 2)] with N hN
    have hnN : n ≤ N := le_trans (Nat.le_max_left _ _) hN
    have h2N : 2 ≤ N := le_trans (Nat.le_max_right _ _) hN
    have hN1 : 1 < N := lt_of_lt_of_le (by norm_num) h2N
    simp [mobiusLinearTaper, hn, hnN, hN1]
    have hlogN : Real.log (N : ℝ) ≠ 0 := by
      exact Real.log_ne_zero_of_pos_of_ne_one (by positivity)
        (by exact_mod_cast (ne_of_gt hN1))
    field_simp
    ring
  apply Filter.Tendsto.congr' hform.symm
  simpa using tendsto_const_nhds.sub hratio

theorem mobiusTaperCoeff_two_tendsto_one :
    Filter.Tendsto (fun N : ℕ => mobiusTaperCoeff N 2)
      Filter.atTop (nhds 1) := by
  have ht := mobiusLinearTaper_tendsto_one 2 (by norm_num)
  simpa [mobiusTaperCoeff, ArithmeticFunction.moebius_apply_prime (by norm_num : Nat.Prime 2)]
    using ht

theorem mobiusTaperCoeff_three_tendsto_one :
    Filter.Tendsto (fun N : ℕ => mobiusTaperCoeff N 3)
      Filter.atTop (nhds 1) := by
  have ht := mobiusLinearTaper_tendsto_one 3 (by norm_num)
  simpa [mobiusTaperCoeff, ArithmeticFunction.moebius_apply_prime (by norm_num : Nat.Prime 3)]
    using ht

#print axioms mobiusLinearTaper_tendsto_one
#print axioms mobiusTaperCoeff_two_tendsto_one
#print axioms mobiusTaperCoeff_three_tendsto_one

end Riemann.claims
