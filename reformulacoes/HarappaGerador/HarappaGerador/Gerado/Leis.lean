/-
  Gerado por reformulacoes/HarappaGerador/generate.py (MVEI). Não edite à mão.
  Leis clássicas na leitura de três valores dos sinais do catálogo: 28 valem, 12 não valem (refutadas com contraexemplo).
-/
import HarappaGerador.Gerado.Base

namespace HarappaGerador
open HarappaSemantica HarappaCatalog V3

/-- Sinal 3 (→), comutatividade. Não vale: contraexemplo f, i. -/
theorem sinal_003_comutatividade_falha : ¬ (∀ a b : V3, imp a b = imp b a) :=
  fun h => absurd (h V3.f V3.i) (by decide)

/-- Sinal 3 (→), associatividade. Não vale: contraexemplo f, f, f. -/
theorem sinal_003_associatividade_falha : ¬ (∀ a b c : V3, imp (imp a b) c = imp a (imp b c)) :=
  fun h => absurd (h V3.f V3.f V3.f) (by decide)

/-- Sinal 3 (→), idempotencia. Não vale: contraexemplo f. -/
theorem sinal_003_idempotencia_falha : ¬ (∀ a : V3, imp a a = a) :=
  fun h => absurd (h V3.f) (by decide)

/-- Sinal 3 (→), reflexiva verdadeira. Não vale: contraexemplo i. -/
theorem sinal_003_reflexiva_verdadeira_falha : ¬ (∀ a : V3, imp a a = V3.t) :=
  fun h => absurd (h V3.i) (by decide)

/-- Sinal 3 (→), monotona no refinamento. Vale. -/
theorem sinal_003_monotona_no_refinamento : ∀ a a' b b' : V3, ref a a' = true → ref b b' = true → ref (imp a b) (imp a' b') = true := by
  intro a a' b b'
  cases a <;> cases a' <;> cases b <;> cases b' <;> decide

/-- Sinal 7 (∧), comutatividade. Vale. -/
theorem sinal_007_comutatividade : ∀ a b : V3, conj a b = conj b a := by
  intro a b
  cases a <;> cases b <;> decide

/-- Sinal 7 (∧), associatividade. Vale. -/
theorem sinal_007_associatividade : ∀ a b c : V3, conj (conj a b) c = conj a (conj b c) := by
  intro a b c
  cases a <;> cases b <;> cases c <;> decide

/-- Sinal 7 (∧), idempotencia. Vale. -/
theorem sinal_007_idempotencia : ∀ a : V3, conj a a = a := by
  intro a
  cases a <;> decide

/-- Sinal 7 (∧), reflexiva verdadeira. Não vale: contraexemplo f. -/
theorem sinal_007_reflexiva_verdadeira_falha : ¬ (∀ a : V3, conj a a = V3.t) :=
  fun h => absurd (h V3.f) (by decide)

/-- Sinal 7 (∧), monotona no refinamento. Vale. -/
theorem sinal_007_monotona_no_refinamento : ∀ a a' b b' : V3, ref a a' = true → ref b b' = true → ref (conj a b) (conj a' b') = true := by
  intro a a' b b'
  cases a <;> cases a' <;> cases b <;> cases b' <;> decide

/-- Sinal 11 (∨), comutatividade. Vale. -/
theorem sinal_011_comutatividade : ∀ a b : V3, disj a b = disj b a := by
  intro a b
  cases a <;> cases b <;> decide

/-- Sinal 11 (∨), associatividade. Vale. -/
theorem sinal_011_associatividade : ∀ a b c : V3, disj (disj a b) c = disj a (disj b c) := by
  intro a b c
  cases a <;> cases b <;> cases c <;> decide

/-- Sinal 11 (∨), idempotencia. Vale. -/
theorem sinal_011_idempotencia : ∀ a : V3, disj a a = a := by
  intro a
  cases a <;> decide

/-- Sinal 11 (∨), reflexiva verdadeira. Não vale: contraexemplo f. -/
theorem sinal_011_reflexiva_verdadeira_falha : ¬ (∀ a : V3, disj a a = V3.t) :=
  fun h => absurd (h V3.f) (by decide)

/-- Sinal 11 (∨), monotona no refinamento. Vale. -/
theorem sinal_011_monotona_no_refinamento : ∀ a a' b b' : V3, ref a a' = true → ref b b' = true → ref (disj a b) (disj a' b') = true := by
  intro a a' b b'
  cases a <;> cases a' <;> cases b <;> cases b' <;> decide

/-- Sinal 73 (≡), comutatividade. Vale. -/
theorem sinal_073_comutatividade : ∀ a b : V3, equiv a b = equiv b a := by
  intro a b
  cases a <;> cases b <;> decide

/-- Sinal 73 (≡), associatividade. Vale. -/
theorem sinal_073_associatividade : ∀ a b c : V3, equiv (equiv a b) c = equiv a (equiv b c) := by
  intro a b c
  cases a <;> cases b <;> cases c <;> decide

/-- Sinal 73 (≡), idempotencia. Não vale: contraexemplo f. -/
theorem sinal_073_idempotencia_falha : ¬ (∀ a : V3, equiv a a = a) :=
  fun h => absurd (h V3.f) (by decide)

/-- Sinal 73 (≡), reflexiva verdadeira. Não vale: contraexemplo i. -/
theorem sinal_073_reflexiva_verdadeira_falha : ¬ (∀ a : V3, equiv a a = V3.t) :=
  fun h => absurd (h V3.i) (by decide)

/-- Sinal 73 (≡), monotona no refinamento. Vale. -/
theorem sinal_073_monotona_no_refinamento : ∀ a a' b b' : V3, ref a a' = true → ref b b' = true → ref (equiv a b) (equiv a' b') = true := by
  intro a a' b b'
  cases a <;> cases a' <;> cases b <;> cases b' <;> decide

/-- Sinais 3, 7, 11, 13 e 73: dupla negacao. Vale. -/
theorem dupla_negacao : ∀ a : V3, neg (neg a) = a := by
  intro a
  cases a <;> decide

/-- Sinais 3, 7, 11, 13 e 73: de morgan conj. Vale. -/
theorem de_morgan_conj : ∀ a b : V3, neg (conj a b) = disj (neg a) (neg b) := by
  intro a b
  cases a <;> cases b <;> decide

/-- Sinais 3, 7, 11, 13 e 73: de morgan disj. Vale. -/
theorem de_morgan_disj : ∀ a b : V3, neg (disj a b) = conj (neg a) (neg b) := by
  intro a b
  cases a <;> cases b <;> decide

/-- Sinais 3, 7, 11, 13 e 73: distributiva conj disj. Vale. -/
theorem distributiva_conj_disj : ∀ a b c : V3, conj a (disj b c) = disj (conj a b) (conj a c) := by
  intro a b c
  cases a <;> cases b <;> cases c <;> decide

/-- Sinais 3, 7, 11, 13 e 73: distributiva disj conj. Vale. -/
theorem distributiva_disj_conj : ∀ a b c : V3, disj a (conj b c) = conj (disj a b) (disj a c) := by
  intro a b c
  cases a <;> cases b <;> cases c <;> decide

/-- Sinais 3, 7, 11, 13 e 73: absorcao conj. Vale. -/
theorem absorcao_conj : ∀ a b : V3, conj a (disj a b) = a := by
  intro a b
  cases a <;> cases b <;> decide

/-- Sinais 3, 7, 11, 13 e 73: absorcao disj. Vale. -/
theorem absorcao_disj : ∀ a b : V3, disj a (conj a b) = a := by
  intro a b
  cases a <;> cases b <;> decide

/-- Sinais 3, 7, 11, 13 e 73: terceiro excluido. Não vale: contraexemplo i. -/
theorem terceiro_excluido_falha : ¬ (∀ a : V3, disj a (neg a) = V3.t) :=
  fun h => absurd (h V3.i) (by decide)

/-- Sinais 3, 7, 11, 13 e 73: nao contradicao falsa. Não vale: contraexemplo i. -/
theorem nao_contradicao_falsa_falha : ¬ (∀ a : V3, conj a (neg a) = V3.f) :=
  fun h => absurd (h V3.i) (by decide)

/-- Sinais 3, 7, 11, 13 e 73: nao contradicao nunca verdadeira. Vale. -/
theorem nao_contradicao_nunca_verdadeira : ∀ a : V3, conj a (neg a) ≠ V3.t := by
  intro a
  cases a <;> decide

/-- Sinais 3, 7, 11, 13 e 73: explosao. Não vale: contraexemplo i, f. -/
theorem explosao_falha : ¬ (∀ a b : V3, imp (conj a (neg a)) b = V3.t) :=
  fun h => absurd (h V3.i V3.f) (by decide)

/-- Sinais 3, 7, 11, 13 e 73: contraposicao. Vale. -/
theorem contraposicao : ∀ a b : V3, imp a b = imp (neg b) (neg a) := by
  intro a b
  cases a <;> cases b <;> decide

/-- Sinais 3, 7, 11, 13 e 73: modus ponens. Vale. -/
theorem modus_ponens : ∀ a b : V3, a = V3.t → imp a b = V3.t → b = V3.t := by
  intro a b
  cases a <;> cases b <;> decide

/-- Sinais 3, 7, 11, 13 e 73: peirce. Não vale: contraexemplo i, f. -/
theorem peirce_falha : ¬ (∀ a b : V3, imp (imp (imp a b) a) a = V3.t) :=
  fun h => absurd (h V3.i V3.f) (by decide)

/-- Sinais 3, 7, 11, 13 e 73: equivalencia como implicacoes. Vale. -/
theorem equivalencia_como_implicacoes : ∀ a b : V3, equiv a b = conj (imp a b) (imp b a) := by
  intro a b
  cases a <;> cases b <;> decide

/-- Sinais 3, 7, 11, 13 e 73: identidade conj. Vale. -/
theorem identidade_conj : ∀ a : V3, conj a V3.t = a := by
  intro a
  cases a <;> decide

/-- Sinais 3, 7, 11, 13 e 73: identidade disj. Vale. -/
theorem identidade_disj : ∀ a : V3, disj a V3.f = a := by
  intro a
  cases a <;> decide

/-- Sinais 3, 7, 11, 13 e 73: absorvente conj. Vale. -/
theorem absorvente_conj : ∀ a : V3, conj a V3.f = V3.f := by
  intro a
  cases a <;> decide

/-- Sinais 3, 7, 11, 13 e 73: absorvente disj. Vale. -/
theorem absorvente_disj : ∀ a : V3, disj a V3.t = V3.t := by
  intro a
  cases a <;> decide

/-- Sinais 3, 7, 11, 13 e 73: implicacao material classica nos determinados. Vale. -/
theorem implicacao_material_classica_nos_determinados : ∀ a b : V3, a ≠ V3.i → b ≠ V3.i → (imp a b = V3.t ↔ (a = V3.t → b = V3.t)) := by
  intro a b
  cases a <;> cases b <;> decide

end HarappaGerador
