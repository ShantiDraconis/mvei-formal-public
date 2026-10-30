# DIVERGENCES — mishkan-iii-core: onde o texto do autor e o kernel discordam

Fonte: `ShantiDraconis/mishkan-iii-core`, commit `2e43209371b6c345d28b5dcabf4953bbb2cff104` (2026-09-18).
Cada entrada cita o texto do autor (arquivo e linha no commit acima) e o teorema que o kernel do Lean 4.19 confere.
Os teoremas estão em `MveiEstrutura/Divergencias.lean` desta pasta (namespace `MveiDivergencias`), que só depende da
camada concreta (`MveiEstrutura/Mishkan.lean`) e das teorias (`MveiEstrutura/Teoria/`), não dos arquivos do autor.
Nenhum usa axioma além de `propext`, `Classical.choice` e `Quot.sound`.

| # | Texto do autor | O que o kernel mostra | Teoremas |
|---|---|---|---|
| 1 | Sinais 21 e 35 com as classes numéricas trocadas | 21 é triangular, 35 é tetraédrico | `sinais_21_35` |
| 2 | Conceito 425 com data 1600, contra `modern_mathematics` (> 1600) | nenhuma interpretação tem o conceito 425; a exclusão é forçada | `conceito_425`, `nenhum_conceito_425` |
| 3 | `logical_preservation` sem parênteses em volta do `↔` | o Lean lê `(E₁ → E₂ → (h₁ → h₂)) ↔ (m₁ → m₂)`, falso na interpretação; com parênteses é teorema | `logical_preservation_leitura`, `logical_preservation_falso`, `logical_preservation_com_parenteses` |
| 4 | 71 `absolute_precedence_N` somam a data negativa de C14 ao ano | as 71 são falsas como escritas e verdadeiras com a diferença | `absolute_precedence_falsas`, `absolute_precedence_pela_diferenca` |
| 5 | 500 `meta_N_decidability`: `decidable_system system ↔ (∀ formula, Decidable (derivable system formula))` | `Decidable` é um tipo e `↔` só liga proposições: o enunciado não é bem formado; com `Nonempty (…)` (a leitura proposicional) e `decidable_system` definido assim, a prova do autor (`rfl`) fecha | patch `vinculo-provas` (tipo corrigido); `SemanticaMishkan.decidabilidade_classica` |

## 1. Sinais 21 e 35: classes trocadas

`core/archaeology/HARAPPA_CATALOG.lean`:

```lean
-- l.296 (sign_021)
logical_interpretation := "Tetrahedral number, 21 = 1+2+3+4+5+6",
-- l.450 (sign_035)
logical_interpretation := "Triangular number, 35 = 5×7",
```

21 = 1 + 2 + … + 6 = T₆ é triangular (a soma que o próprio texto escreve está certa; só o nome está errado). Os
tetraédricos são 1, 4, 10, 20, 35, …: 35 = Tet₅. `sinais_21_35` confere no kernel o texto dos dois sinais e as
quatro classes. Das 122 afirmações aritméticas do catálogo (primos, quadrados, cubos, triangulares, tetraédricos,
fatorações, somas), estas duas são as únicas falsas (`MveiTeoria.afirmacoes_verdadeiras`, `MveiTeoria.erros_falsos`
em `MveiEstrutura/Teoria/Aritmetica.lean`).

## 2. Conceito 425: data 1600 contra `modern_mathematics`

`core/proofs/FORMAL_VERIFICATIONS.lean`:

```lean
-- l.37 (axioma do autor)
axiom modern_mathematics : ∀ (concept : ModernConcept), concept.date > 1600
-- l.19969 (gerado)
theorem precedence_0425 : ∀ (h : HarappaSign) (m : ModernConcept), h.id = 425 → m.id = 425 → h.date < m.date := by
  …
  have h2 : m.date = 1600 := by …
```

As 600 datas modernas do gerador são 1600 + (N mod 425) (`MveiTeoria.Dados.so_o_425`, `modernDate_gerador` na
camada): o conceito 425 volta a 1600 e é o único que não passa de 1600. `nenhum_conceito_425` vale para qualquer
interpretação: se a lei de datação do gerador e o axioma do autor valem juntos, nenhum conceito tem id 425. Por isso
a camada concreta tem 599 conceitos, e `precedence_0425` vale nela por vacuidade (é a única exclusão forçada da
interpretação).

## 3. `logical_preservation`: a precedência do `↔`

`core/proofs/FORMAL_VERIFICATIONS.lean`, l.143981:

```lean
theorem logical_preservation :
  ∀ (h1 h2 : HarappaSign) (m1 m2 : ModernConcept),
  encodes h1 m1 →
  encodes h2 m2 →
  (h1 → h2) ↔ (m1 → m2) := by
  intros h1 h2 m1 m2 he1 he2
  …
```

`↔` tem precedência 20 e `→` tem 25, então o Lean lê o corpo como `(encodes h1 m1 → encodes h2 m2 → (h1 → h2)) ↔
(m1 → m2)`; `logical_preservation_leitura` mostra que as duas grafias são o mesmo termo (`Iff.rfl`). Por isso a prova
do autor cai em `intros … he1 he2` ("introN failed, insufficient number of binders"). Assim lido, o enunciado é falso
na interpretação concreta (`logical_preservation_falso`: sinal 2 nos dois papéis, conceitos 1 e 500). Com os
parênteses que a prova pressupõe, `encodes h1 m1 → encodes h2 m2 → ((h1 → h2) ↔ (m1 → m2))`, é teorema
(`logical_preservation_com_parenteses`, pelas leis `implication_preservation` e `reverse_implication`).

## 4. `absolute_precedence_N`: soma em vez de diferença

`core/millennium/MILLENNIUM_SOLUTIONS.lean`, 71 teoremas (l.90320 … l.93050), todos da forma:

```lean
def carbon14_date_001 : Int := -2575        -- l.90301
def modern_publication_001 : Nat := 1862    -- l.90318
theorem absolute_precedence_001 :
  carbon14_date_001 + modern_publication_001 > 4000 := by …
```

−2575 + 1862 = −713: a data negativa é somada ao ano. Nas 71, C14 = −2580 + 5k e publicação = 1859 + 3·(k mod 50)
(`MveiTeoria.carbono_gerado`, `MveiTeoria.publicacoes_geradas`); `absolute_precedence_falsas` confere que nenhuma
passa de 4000 e `absolute_precedence_pela_diferenca` que, com publicação − C14, as 71 passam. No pipeline principal
essas 71 chegam ao kernel e caem com `⊢ False`. A causa não é a precedência do `↔` (isso é a entrada 3), é a
aritmética do enunciado.

## 5. `meta_N_decidability`: `Decidable` é um tipo

`core/proofs/FORMAL_VERIFICATIONS.lean`, 500 teoremas (`meta_0001_decidability` … `meta_0500_decidability`):

```lean
theorem meta_0001_decidability :
  ∀ (system : LogicalSystem),
  decidable_system system ↔
  (∀ (formula : Formula),
    Decidable (derivable system formula)) := by
  intro system
  rfl
```

`Decidable p` é uma classe de dados (`Type`), não uma proposição, e `↔` só aceita proposições: o Lean recusa o
enunciado ("application type mismatch"). É o único ajuste de enunciado do patch `vinculo-provas`: o lado direito
vira `Nonempty (∀ formula, Decidable (derivable system formula))`, e `decidable_system` passa a ser essa definição
(na camada de nomes e na camada concreta). Com isso a prova escrita pelo autor (`intro system; rfl`) fecha sem
mudança. Lido assim, o enunciado vale para qualquer sistema pela lógica clássica
(`SemanticaMishkan.decidabilidade_classica`): os 500 são verdadeiros por definição, não dizem nada sobre os sistemas.

## Reproduzir

Lean `leanprover/lean4:v4.19.0`, Mathlib `v4.19.0`. Na pasta `teoria/` do espelho público
(`mvei-formal-public/mvei/mishkan-iii-core/teoria`, que traz o catálogo do autor com os patches do MVEI):

```
lake exe cache get
lake build
```

No repositório do MVEI (`reformulacoes/TeoriaMishkan`), `python tools/teoria_mishkan.py --montar` copia antes os
arquivos do autor com os patches.
