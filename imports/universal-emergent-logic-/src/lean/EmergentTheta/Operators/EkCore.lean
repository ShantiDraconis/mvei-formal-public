namespace EmergentTheta

/--
Axiomatic definition of an emergent operator `E_k` indexed by a natural number `k`.
For the purposes of the abstract framework, we treat `E_k` as a function
from a scale parameter `N : ℝ` (with `N ≥ 1`) to `ℝ`.
-/
structure EmergentOperator where
  k        : ℕ
  Ek       : ℝ → ℝ
  Ek_pos   : ∀ {N : ℝ}, N ≥ 1 → Ek N > 0
  main_term :
    ∃ Ck : ℝ, Ck > 0 ∧
      ∀ {N : ℝ}, N ≥ 2 →
        |Ek N - k| ≤ Ck * Real.sqrt N * (Real.log N) ^ k

/--
The universal theta hypothesis: there exists a universal exponent `θ = 1/2`
controlling the error for all emergent operators `E_k`.
This is the core meta-assumption of the framework.
-/
class UniversalTheta (θ : ℝ) : Prop :=
  (theta_is_half : θ = (1 / 2))

end EmergentTheta
