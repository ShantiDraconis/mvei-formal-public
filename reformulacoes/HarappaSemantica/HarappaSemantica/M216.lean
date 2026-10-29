/-
  HarappaSemantica/M216.lean — o glifo M216 de harappan-00-universal (`Provas/M216_Riemann.lean`) lido com a função
  zeta de verdade (MVEI; não é arquivo do autor).

  No arquivo do autor:
  * `Harappan_M216 s := s.re = 0.5` ("a linha crítica codificada na espinha do Peixe");
  * `nontrivial_zero s := s.re = 0.5 ∧ s.im ≠ 0.0`;
  * `nontrivial_satisfies_M216 : nontrivial_zero s → Harappan_M216 s`, fechado no kernel.
  Como `nontrivial_zero` já diz `s.re = 0.5`, o teorema vale por definição e não fala de ζ (`autor_circular`).

  Aqui "zero não trivial" é o do Mathlib: `riemannZeta s = 0`, `s` não é um dos zeros triviais `-2(n+1)` e `s ≠ 1`
  (as mesmas três hipóteses de `RiemannHypothesis`). Com isso o enunciado do autor, "todo zero não trivial satisfaz
  M216", é EXATAMENTE a Hipótese de Riemann (`m216_iff_riemann`): fica aberto, como ela.
-/
import Mathlib.NumberTheory.LSeries.RiemannZeta
import Mathlib.Tactic.NormNum.OfScientific

namespace HarappaSemantica.M216

/-- `Harappan_M216` do autor. -/
abbrev Harappan_M216 (s : ℂ) : Prop := s.re = 0.5

/-- `nontrivial_zero` do autor. -/
abbrev nontrivial_zero_autor (s : ℂ) : Prop := s.re = 0.5 ∧ s.im ≠ 0.0

/-- O teorema do autor vale por definição: a hipótese já é a conclusão. -/
theorem autor_circular (s : ℂ) : nontrivial_zero_autor s → Harappan_M216 s := fun h => h.1

/-- Zero não trivial da zeta, com as hipóteses de `RiemannHypothesis` do Mathlib. -/
abbrev ZeroNaoTrivial (s : ℂ) : Prop := riemannZeta s = 0 ∧ (¬∃ n : ℕ, s = -2 * (n + 1)) ∧ s ≠ 1

theorem meio : (0.5 : ℝ) = 1 / 2 := by norm_num

/-- **O M216 com a zeta real é a Hipótese de Riemann.** -/
theorem m216_iff_riemann : (∀ s, ZeroNaoTrivial s → Harappan_M216 s) ↔ RiemannHypothesis := by
  unfold RiemannHypothesis
  constructor
  · intro h s hz ht h1
    have h2 : s.re = 0.5 := h s ⟨hz, ht, h1⟩
    rw [h2, meio]
  · intro h s hs
    obtain ⟨hz, ht, h1⟩ := hs
    show s.re = 0.5
    rw [meio]
    exact h s hz ht h1

end HarappaSemantica.M216
