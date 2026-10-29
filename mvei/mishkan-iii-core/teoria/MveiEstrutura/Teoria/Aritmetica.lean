/-
  Aritmetica.lean — reformulacoes/TeoriaMishkan (MVEI; NÃO é do autor). Gerado por tools/teoria_mishkan.py.

  Classes numéricas dos sinais 1 … 100 (o valor do sinal é o índice) e conferência, no kernel, de cada
  afirmação aritmética que o texto do catálogo faz (122 afirmações: primos, quadrados, cubos, números
  triangulares e tetraédricos, fatorações e somas). Duas estão trocadas no texto do autor: 21 é triangular
  (não tetraédrico) e 35 é tetraédrico (não triangular). A lei que os dados seguem: todo primo ≤ 100 carrega
  um operador lógico, e todo sinal da categoria Logical é primo, menos o 51. Constantes astronômicas do
  catálogo contra os valores reais, com o erro de cada uma (micro-unidades), e o ângulo de ouro dos pilares.
-/
import MveiEstrutura.Teoria.Gramatica

set_option autoImplicit false

namespace MveiTeoria
open HarappaCatalog

/-! ## Classes numéricas -/

def ehPrimo (n : Nat) : Bool := 2 ≤ n && (List.range n).all (fun d => d < 2 || n % d != 0)
def ehComposto (n : Nat) : Bool := 4 ≤ n && !ehPrimo n
def ehQuadrado (n : Nat) : Bool := (List.range (n + 1)).any (fun k => k * k == n)
def ehCubo (n : Nat) : Bool := (List.range (n + 1)).any (fun k => k * k * k == n)
def ehTriangular (n : Nat) : Bool := (List.range (n + 1)).any (fun k => k * (k + 1) / 2 == n)
def ehTetraedrico (n : Nat) : Bool := (List.range (n + 1)).any (fun k => k * (k + 1) * (k + 2) / 6 == n)

/-- Afirmação aritmética sobre o valor de um sinal. -/
inductive Afirmacao
  | primo | composto | quadrado | cubo | triangular | tetraedrico
  /-- n = ∏ pᵉ -/
  | produto (fatores : List (Nat × Nat))
  /-- n = 1 + 2 + … + k -/
  | somaAte (k : Nat)
  deriving DecidableEq

def Afirmacao.vale (n : Nat) : Afirmacao → Bool
  | .primo => ehPrimo n
  | .composto => ehComposto n
  | .quadrado => ehQuadrado n
  | .cubo => ehCubo n
  | .triangular => ehTriangular n
  | .tetraedrico => ehTetraedrico n
  | .produto fs => (fs.map (fun f => f.1 ^ f.2)).foldl (· * ·) 1 == n
  | .somaAte k => (List.range (k + 1)).foldl (· + ·) 0 == n

/-- As 122 afirmações aritméticas do texto do catálogo (sinais 1 … 100): (índice, texto do autor, afirmação). -/
def afirmacoes : List (Nat × String × Afirmacao) := [
  (2, "Duality, existential quantifier (∃), prime number 2", .primo),
  (3, "Trinity, implication (→), prime number 3", .primo),
  (5, "Pentad, XOR operation, prime number 5", .primo),
  (6, "Hexagonal structure, composite number 6 = 2×3", .composto),
  (6, "Hexagonal structure, composite number 6 = 2×3", .produto [(2, 1), (3, 1)]),
  (7, "Conjunction (∧), sacred number 7, prime", .primo),
  (8, "Octad, 8 = 2³, cubic structure", .produto [(2, 3)]),
  (9, "Perfect square, 9 = 3², completeness", .quadrado),
  (9, "Perfect square, 9 = 3², completeness", .produto [(3, 2)]),
  (10, "Decimal base, 10 = 2×5, fingers", .produto [(2, 1), (5, 1)]),
  (11, "Disjunction (∨), prime number 11", .primo),
  (12, "Zodiac, 12 months, 12 = 2²×3", .produto [(2, 2), (3, 1)]),
  (13, "Negation (¬), prime number 13", .primo),
  (14, "Double sacred, 14 = 2×7", .produto [(2, 1), (7, 1)]),
  (15, "Triangular number, 15 = 1+2+3+4+5", .triangular),
  (15, "Triangular number, 15 = 1+2+3+4+5", .somaAte 5),
  (16, "Perfect square, 16 = 4² = 2⁴", .quadrado),
  (16, "Perfect square, 16 = 4² = 2⁴", .produto [(4, 2)]),
  (16, "Perfect square, 16 = 4² = 2⁴", .produto [(2, 4)]),
  (17, "Equality (=), prime number 17", .primo),
  (18, "18 = 2×3²", .produto [(2, 1), (3, 2)]),
  (19, "Set membership (∈), prime number 19", .primo),
  (20, "Base-20 system component, 20 = 2²×5", .produto [(2, 2), (5, 1)]),
  (21, "Tetrahedral number, 21 = 1+2+3+4+5+6", .tetraedrico),
  (21, "Tetrahedral number, 21 = 1+2+3+4+5+6", .somaAte 6),
  (22, "22 = 2×11, letters in Hebrew alphabet", .produto [(2, 1), (11, 1)]),
  (23, "Function application f(x), prime 23", .primo),
  (24, "24 hours, 24 = 2³×3", .produto [(2, 3), (3, 1)]),
  (25, "Perfect square, 25 = 5²", .quadrado),
  (25, "Perfect square, 25 = 5²", .produto [(5, 2)]),
  (26, "26 = 2×13, letters in Latin alphabet", .produto [(2, 1), (13, 1)]),
  (27, "Perfect cube, 27 = 3³", .cubo),
  (27, "Perfect cube, 27 = 3³", .produto [(3, 3)]),
  (28, "Lunar month, 28 = 2²×7", .produto [(2, 2), (7, 1)]),
  (29, "Composition (∘), prime 29", .primo),
  (30, "30 days, 30 = 2×3×5", .produto [(2, 1), (3, 1), (5, 1)]),
  (31, "Quantifier alternation ∀x∃y, prime 31", .primo),
  (32, "32 = 2⁵, binary progression", .produto [(2, 5)]),
  (33, "33 = 3×11, sacred multiple", .produto [(3, 1), (11, 1)]),
  (34, "34 = 2×17", .produto [(2, 1), (17, 1)]),
  (35, "Triangular number, 35 = 5×7", .triangular),
  (35, "Triangular number, 35 = 5×7", .produto [(5, 1), (7, 1)]),
  (36, "Perfect square, 36 = 6² = 2²×3²", .quadrado),
  (36, "Perfect square, 36 = 6² = 2²×3²", .produto [(6, 2)]),
  (36, "Perfect square, 36 = 6² = 2²×3²", .produto [(2, 2), (3, 2)]),
  (37, "Entailment (⊢), prime 37", .primo),
  (38, "38 = 2×19", .produto [(2, 1), (19, 1)]),
  (39, "39 = 3×13", .produto [(3, 1), (13, 1)]),
  (40, "40 = 2³×5, biblical significance", .produto [(2, 3), (5, 1)]),
  (41, "Semantic consequence (⊨), prime 41", .primo),
  (42, "42 = 2×3×7, universal answer", .produto [(2, 1), (3, 1), (7, 1)]),
  (43, "Necessity (□), prime 43", .primo),
  (44, "44 = 2²×11", .produto [(2, 2), (11, 1)]),
  (45, "Triangular number, 45 = 1+...+9 = 3²×5", .triangular),
  (45, "Triangular number, 45 = 1+...+9 = 3²×5", .somaAte 9),
  (46, "46 = 2×23", .produto [(2, 1), (23, 1)]),
  (47, "Possibility (◇), prime 47", .primo),
  (48, "48 = 2⁴×3", .produto [(2, 4), (3, 1)]),
  (49, "Perfect square, 49 = 7²", .quadrado),
  (49, "Perfect square, 49 = 7²", .produto [(7, 2)]),
  (50, "50 = 2×5², jubilee", .produto [(2, 1), (5, 2)]),
  (51, "Logical AND continued contexts, 51 = 3×17", .produto [(3, 1), (17, 1)]),
  (52, "52 weeks = 1 year, 52 = 2²×13", .produto [(2, 2), (13, 1)]),
  (53, "Lambda abstraction (λ), prime 53", .primo),
  (54, "54 = 2×3³", .produto [(2, 1), (3, 3)]),
  (55, "Triangular number, 55 = 1+...+10 = 5×11", .triangular),
  (55, "Triangular number, 55 = 1+...+10 = 5×11", .somaAte 10),
  (56, "56 = 2³×7", .produto [(2, 3), (7, 1)]),
  (57, "57 = 3×19", .produto [(3, 1), (19, 1)]),
  (58, "58 = 2×29", .produto [(2, 1), (29, 1)]),
  (59, "Pi type (Π), prime 59", .primo),
  (60, "60 = 2²×3×5, sexagesimal base", .produto [(2, 2), (3, 1), (5, 1)]),
  (61, "Sigma type (Σ), prime 61", .primo),
  (62, "62 = 2×31", .produto [(2, 1), (31, 1)]),
  (63, "63 = 3²×7 = 7×9", .produto [(3, 2), (7, 1)]),
  (63, "63 = 3²×7 = 7×9", .produto [(7, 1), (9, 1)]),
  (64, "Perfect square, 64 = 8² = 2⁶", .quadrado),
  (64, "Perfect square, 64 = 8² = 2⁶", .produto [(8, 2)]),
  (64, "Perfect square, 64 = 8² = 2⁶", .produto [(2, 6)]),
  (65, "65 = 5×13", .produto [(5, 1), (13, 1)]),
  (66, "Triangular number, 66 = 1+...+11 = 2×3×11", .triangular),
  (66, "Triangular number, 66 = 1+...+11 = 2×3×11", .somaAte 11),
  (67, "Bottom type (⊥), prime 67", .primo),
  (68, "68 = 2²×17", .produto [(2, 2), (17, 1)]),
  (69, "69 = 3×23", .produto [(3, 1), (23, 1)]),
  (70, "70 = 2×5×7, biblical completeness", .produto [(2, 1), (5, 1), (7, 1)]),
  (71, "Top type (⊤), prime 71", .primo),
  (72, "72 = 2³×3², divine names, 1 degree precession", .produto [(2, 3), (3, 2)]),
  (73, "Logical equivalence (≡), prime 73", .primo),
  (74, "74 = 2×37", .produto [(2, 1), (37, 1)]),
  (75, "75 = 3×5²", .produto [(3, 1), (5, 2)]),
  (76, "76 = 2²×19", .produto [(2, 2), (19, 1)]),
  (77, "77 = 7×11, double sacred primes", .produto [(7, 1), (11, 1)]),
  (78, "Triangular number, 78 = 1+...+12 = 2×3×13", .triangular),
  (78, "Triangular number, 78 = 1+...+12 = 2×3×13", .somaAte 12),
  (79, "Subset (⊆), prime 79", .primo),
  (80, "80 = 2⁴×5", .produto [(2, 4), (5, 1)]),
  (81, "Perfect square, 81 = 9² = 3⁴", .quadrado),
  (81, "Perfect square, 81 = 9² = 3⁴", .produto [(9, 2)]),
  (81, "Perfect square, 81 = 9² = 3⁴", .produto [(3, 4)]),
  (82, "82 = 2×41", .produto [(2, 1), (41, 1)]),
  (83, "Set union (∪), prime 83", .primo),
  (84, "84 = 2²×3×7", .produto [(2, 2), (3, 1), (7, 1)]),
  (85, "85 = 5×17", .produto [(5, 1), (17, 1)]),
  (86, "86 = 2×43", .produto [(2, 1), (43, 1)]),
  (87, "87 = 3×29", .produto [(3, 1), (29, 1)]),
  (88, "88 = 2³×11", .produto [(2, 3), (11, 1)]),
  (89, "Set intersection (∩), prime 89", .primo),
  (90, "Right angle, 90° = 2×3²×5", .produto [(2, 1), (3, 2), (5, 1)]),
  (91, "Triangular number, 91 = 1+...+13 = 7×13", .triangular),
  (91, "Triangular number, 91 = 1+...+13 = 7×13", .somaAte 13),
  (92, "92 = 2²×23", .produto [(2, 2), (23, 1)]),
  (93, "93 = 3×31", .produto [(3, 1), (31, 1)]),
  (94, "94 = 2×47", .produto [(2, 1), (47, 1)]),
  (95, "95 = 5×19", .produto [(5, 1), (19, 1)]),
  (96, "96 = 2⁵×3", .produto [(2, 5), (3, 1)]),
  (97, "Empty set (∅), prime 97", .primo),
  (98, "98 = 2×7²", .produto [(2, 1), (7, 2)]),
  (99, "99 = 3²×11 = 9×11", .produto [(3, 2), (11, 1)]),
  (99, "99 = 3²×11 = 9×11", .produto [(9, 1), (11, 1)]),
  (100, "100 = 10² = 2²×5², decimal square", .produto [(10, 2)]),
  (100, "100 = 10² = 2²×5², decimal square", .produto [(2, 2), (5, 2)])]

/-- O texto de cada afirmação é o `logical_interpretation` do sinal no catálogo do autor. -/
theorem afirmacoes_no_catalogo : ∀ a ∈ afirmacoes, (sinal a.1).logical_interpretation = a.2.1 := by decide +kernel

/-- As duas afirmações trocadas no texto do autor. -/
def erros : List (Nat × Afirmacao) := [(21, .tetraedrico), (35, .triangular)]

/-- Todas as outras afirmações do catálogo são verdadeiras. -/
theorem afirmacoes_verdadeiras : ∀ a ∈ afirmacoes, (a.1, a.2.2) ∉ erros → a.2.2.vale a.1 = true := by decide +kernel

/-- As duas são falsas … -/
theorem erros_falsos : ∀ e ∈ erros, e.2.vale e.1 = false := by decide

/-- … e o texto troca as classes: 21 = T₆ é triangular, 35 = Tet₅ é tetraédrico. -/
theorem troca_21_35 : ehTriangular 21 = true ∧ ehTetraedrico 35 = true ∧ ehTriangular 35 = false := by decide

/-- A lei dos dados: todo primo ≤ 100 é um sinal-operador. -/
theorem primos_tem_operador : ∀ n < 101, ehPrimo n = true → (operadores.find? (fun o => o.1 == n)).isSome = true := by
  decide +kernel

/-- E todo sinal da categoria Logical é primo, menos o 51 = 3 × 17 (∧₂). -/
theorem logicos_sao_primos : ∀ n < 101, 1 ≤ n → (sinal n).category = .Logical → ehPrimo n = true ∨ n = 51 := by
  decide +kernel

/-- O cabeçalho do catálogo diz "Sinais Numéricos (1-50)" e "Sinais Lógicos (51-100)"; nos dados, 10 dos 50
    primeiros e só 11 dos 50 seguintes são da categoria Logical. -/
theorem cabecalho_vs_dados :
    ((List.range 50).filter (fun i => (sinal (i + 1)).category == .Logical)).length = 10 ∧
    ((List.range 50).filter (fun i => (sinal (i + 51)).category == .Logical)).length = 11 := by decide +kernel

/-! ## Constantes astronômicas do catálogo (micro-unidades: valor × 10⁶) -/

/-- mesLunarSideral: o catálogo usa 28 (dias); valor real 27.321662 (mês sideral 27,321662 d); erro 0.678338. -/
theorem erro_mesLunarSideral : (28000000 - 27321662 : Int).natAbs = 678338 := by decide
/-- mesLunarSinodico: o catálogo usa 28 (dias); valor real 29.530589 (mês sinódico 29,530589 d); erro 1.530589. -/
theorem erro_mesLunarSinodico : (28000000 - 29530589 : Int).natAbs = 1530589 := by decide
/-- mes30Sinodico: o catálogo usa 30 (dias); valor real 29.530589 (mês sinódico 29,530589 d); erro 0.469411. -/
theorem erro_mes30Sinodico : (30000000 - 29530589 : Int).natAbs = 469411 := by decide
/-- ano52Semanas: o catálogo usa 364 (dias); valor real 365.242190 (ano trópico 365,242190 d); erro 1.242190. -/
theorem erro_ano52Semanas : (364000000 - 365242190 : Int).natAbs = 1242190 := by decide
/-- ano12Meses: o catálogo usa 12 (meses sinódicos); valor real 12.368266 (365,242190 / 29,530589); erro 0.368266. -/
theorem erro_ano12Meses : (12000000 - 12368266 : Int).natAbs = 368266 := by decide
/-- precessao72: o catálogo usa 72 (anos por grau); valor real 71.587700 (precessão geral 50,28796″/ano (IAU 2006)); erro 0.412300. -/
theorem erro_precessao72 : (72000000 - 71587700 : Int).natAbs = 412300 := by decide
/-- dia24Horas: o catálogo usa 24 (horas); valor real 24.000000 (dia solar médio = 24 h (definição)); erro 0.000000. -/
theorem erro_dia24Horas : (24000000 - 24000000 : Int).natAbs = 0 := by decide

/-! ## Ângulo de ouro (orientação dos pilares do templo: 137,5° por pilar) -/

/-- √5 entre 2,2360679 e 2,2360680. -/
theorem raiz5 : 22360679 ^ 2 < 5 * 10 ^ 14 ∧ 5 * 10 ^ 14 < 22360680 ^ 2 := by decide

/-- O ângulo de ouro 360(2 − φ) = 540 − 180√5 está entre 137,507760 e 137,507778 graus (×10⁷, com os limites de √5);
    os 137,5° do autor ficam abaixo dele por 0,00776 a 0,00778 grau. -/
theorem angulo_de_ouro : 5400000000 - 180 * 22360680 = 1375077600 ∧ 5400000000 - 180 * 22360679 = 1375077780 ∧
    1375077600 - 1375000000 = 77600 := by decide

end MveiTeoria
