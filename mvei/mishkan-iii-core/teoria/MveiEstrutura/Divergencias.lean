/-
  MveiEstrutura/Divergencias.lean — reformulacoes/TeoriaMishkan (MVEI; NÃO é do autor). Gerado por tools/teoria_mishkan.py.

  As divergências entre o texto do autor e o kernel (DIVERGENCES.md): sinais 21 e 35 com as classes trocadas,
  o conceito 425 excluído à força, `logical_preservation` lido pela precedência do ↔, e as 71
  `absolute_precedence_N` falsas como escritas. Só depende da camada concreta (não dos arquivos do autor).
-/
import MveiEstrutura.Mishkan

set_option autoImplicit false

namespace MveiDivergencias
open MveiEstrutura.Mishkan MveiEstrutura.Mishkan.Formal

/-! ## 1. Sinais 21 e 35: as classes estão trocadas no texto do catálogo -/

/-- O texto do autor chama 21 de tetraédrico e 35 de triangular; é o contrário: 21 = 1 + … + 6 = T₆ (a soma que o
    próprio texto escreve está certa) e 35 = Tet₅ (1, 4, 10, 20, 35). -/
theorem sinais_21_35 :
    (MveiTeoria.sinal 21).logical_interpretation = "Tetrahedral number, 21 = 1+2+3+4+5+6" ∧
    (MveiTeoria.sinal 35).logical_interpretation = "Triangular number, 35 = 5×7" ∧
    MveiTeoria.ehTetraedrico 21 = false ∧ MveiTeoria.ehTriangular 21 = true ∧
    MveiTeoria.ehTriangular 35 = false ∧ MveiTeoria.ehTetraedrico 35 = true := by decide +kernel

/-! ## 2. Conceito 425: a data do gerador contradiz o axioma do autor -/

/-- O gerador das datas modernas (1600 + N mod 425) dá 1600 ao conceito 425, e `modern_mathematics` do autor exige
    > 1600. -/
theorem conceito_425 : MveiTeoria.geradorModerno 425 = 1600 ∧ ¬ MveiTeoria.geradorModerno 425 > 1600 := by decide

/-- Em QUALQUER interpretação em que valem a lei de datação do gerador e o axioma do autor, nenhum conceito tem id 425:
    a exclusão na camada concreta é forçada, não uma escolha. -/
theorem nenhum_conceito_425 (C : Type) (ident : C → Nat) (data : C → Int) (autor : ∀ m, data m > 1600)
    (gerador : ∀ m n, ident m = n → 1 ≤ n ∧ n ≤ 600 → data m = MveiTeoria.geradorModerno n) :
    ∀ m, ident m ≠ 425 := by
  intro m hm
  have h1 := autor m
  rw [gerador m 425 hm ⟨by decide, by decide⟩] at h1
  exact absurd h1 (by decide)

/-! ## 3. `logical_preservation`: a precedência do ↔ -/

/-- O Lean lê `E₁ → E₂ → (h₁ → h₂) ↔ (m₁ → m₂)` como `(E₁ → E₂ → (h₁ → h₂)) ↔ (m₁ → m₂)`: `↔` (precedência 20) liga
    menos que `→` (25). Os dois lados abaixo são o mesmo termo (`Iff.rfl`). -/
theorem logical_preservation_leitura :
    (∀ (h1 h2 : HarappaSign) (m1 m2 : ModernConcept),
      encodes h1 m1 →
      encodes h2 m2 →
      (h1 → h2) ↔ (m1 → m2)) ↔
    (∀ (h1 h2 : HarappaSign) (m1 m2 : ModernConcept),
      ((encodes h1 m1 → encodes h2 m2 → (h1 → h2)) ↔ (m1 → m2))) := Iff.rfl

/-- Assim lido, o enunciado do autor é falso na interpretação: com h₁ = h₂ = sinal 2 (que não codifica o conceito 1)
    o lado esquerdo vale por vacuidade, e o conceito 1 é verdadeiro e o 500 não. -/
theorem logical_preservation_falso : ¬ (∀ (h1 h2 : HarappaSign) (m1 m2 : ModernConcept),
    encodes h1 m1 →
    encodes h2 m2 →
    (h1 → h2) ↔ (m1 → m2)) := by
  intro H
  have h2 : (MveiTeoria.sinal 2).index = 2 := MveiTeoria.sinal_index 2 (by decide) (by decide)
  have esq : encodes (MveiTeoria.sinal 2) (⟨1, by decide⟩ : ModernConcept) →
      encodes (MveiTeoria.sinal 2) (⟨500, by decide⟩ : ModernConcept) →
      (signVerdade (MveiTeoria.sinal 2) → signVerdade (MveiTeoria.sinal 2)) := by
    intro e1
    have e1' : (MveiTeoria.sinal 2).index = 1 := e1
    omega
  have dir := (H (MveiTeoria.sinal 2) (MveiTeoria.sinal 2) ⟨1, by decide⟩ ⟨500, by decide⟩).1 esq
  have : MveiTeoria.atestado 500 := dir (show MveiTeoria.atestado 1 by decide)
  exact absurd this.2 (by decide)

/-- Com os parênteses que a prova do autor pressupõe (`intros h1 h2 m1 m2 he1 he2`), o enunciado é teorema na
    interpretação: são as leis `implication_preservation` e `reverse_implication`. -/
theorem logical_preservation_com_parenteses : ∀ (h1 h2 : HarappaSign) (m1 m2 : ModernConcept),
    encodes h1 m1 →
    encodes h2 m2 →
    ((h1 → h2) ↔ (m1 → m2)) :=
  fun _ _ _ _ e1 e2 => ⟨implication_preservation e1 e2, reverse_implication e1 e2⟩

/-! ## 4. `absolute_precedence_N` (MILLENNIUM_SOLUTIONS, 71 teoremas): soma em vez de diferença -/

/-- Como escritas (`carbon14_date_N + modern_publication_N > 4000`), as 71 são falsas nos dados do autor: a data
    negativa de C14 é somada ao ano de publicação. -/
theorem absolute_precedence_falsas :
    ∀ k < 71, ¬ (MveiTeoria.carbonoMilenio.getD k 0 + MveiTeoria.publicacoes.getD k 0 > 4000) := by decide +kernel

/-- Com a diferença (ano de publicação − data de C14), as 71 valem. -/
theorem absolute_precedence_pela_diferenca :
    ∀ k < 71, MveiTeoria.publicacoes.getD k 0 - MveiTeoria.carbonoMilenio.getD k 0 > 4000 := by decide +kernel

end MveiDivergencias
