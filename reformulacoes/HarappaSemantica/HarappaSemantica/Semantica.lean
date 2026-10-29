/-
  HarappaSemantica/Semantica.lean — os sinais do catálogo de mishkan-iii-core lidos pelo campo `modern_equivalent`
  que o próprio autor escreveu, e interpretados na lógica de três valores (MVEI; não é arquivo do autor).

  Os arquivos gerados de mishkan escolhem o sinal que "codifica" cada problema por aritmética, `(3N mod 417)+1`, sem
  olhar o catálogo. Aqui a codificação é semântica: um sinal codifica um operador quando o `modern_equivalent` do
  autor começa com o símbolo desse operador. Tudo é conferido no kernel sobre os dados do catálogo (`decide`).

  Fatos sobre o catálogo que saem disso:
  * os operadores lógicos estão exatamente nos índices primos até 97, mais o 1 (∀) e o 51 (∧₂): a atribuição é
    construída (primos → operadores), não uma leitura arqueológica;
  * o sinal 13 (¬) lido em V3 tem um único ponto fixo, `i`; com o sinal 7 (∧), "a ∧ ¬a" nunca é verdadeiro;
  * os sinais que o gerador põe nos sete problemas (4, 7, 10, 13, 16, 19, 22 para N = 1..7) não têm relação com
    eles: 4, 10, 16 e 22 nem são operadores, e os outros são ∧, ¬ e ∈.
  Nada aqui diz algo sobre os Problemas do Milênio, nem é uma decifração da escrita do Indo: é a leitura que o
  catálogo do autor declara, verificada contra os dados dele.
-/
import HarappaSemantica.Catalogo
import Mathlib.Data.Nat.Prime.Defs

namespace HarappaSemantica

open HarappaCatalog

/-! ## 1. Leitura dos sinais pelo `modern_equivalent` do autor -/

inductive Operador where
  | paraTodo | existe | implica | xor | e | ou | nao | igual | pertence | funcao | compoe | paraTodoExiste
  | prova | acarreta | necessario | possivel | eEstendido | lambda | produto | soma | falso | verdadeiro
  | equivale | subconjunto | uniao | intersecao | vazio
  deriving DecidableEq, Repr

/-- Prefixo do `modern_equivalent` ↦ operador (os mais longos antes: `∀x∃y` antes de `∀`, `∧₂` antes de `∧`,
    `□ (` para não pegar `□²`). -/
def tabela : List (String × Operador) :=
  [("∀x∃y", .paraTodoExiste), ("∀", .paraTodo), ("∃", .existe), ("→", .implica), ("⊕", .xor), ("∧₂", .eEstendido),
   ("∧", .e), ("∨", .ou), ("¬", .nao), ("=", .igual), ("∈", .pertence), ("f(x)", .funcao), ("∘", .compoe),
   ("⊢", .prova), ("⊨", .acarreta), ("□ (", .necessario), ("◇", .possivel), ("λ", .lambda), ("Π", .produto),
   ("Σ", .soma), ("⊥", .falso), ("⊤", .verdadeiro), ("≡", .equivale), ("⊆", .subconjunto), ("∪", .uniao),
   ("∩", .intersecao), ("∅", .vazio)]

def leitura (s : HarappaSign) : Option Operador :=
  (tabela.find? fun p => p.1.toList.isPrefixOf s.modern_equivalent.toList).map (·.2)

/-- Codificação semântica: o sinal codifica o operador que o `modern_equivalent` do autor declara. -/
def codifica (s : HarappaSign) (o : Operador) : Prop := leitura s = some o

instance (s : HarappaSign) (o : Operador) : Decidable (codifica s o) := by unfold codifica; infer_instance

def sinais : List HarappaSign :=
  [sign_001, sign_002, sign_003, sign_004, sign_005, sign_006, sign_007, sign_008, sign_009, sign_010,
   sign_011, sign_012, sign_013, sign_014, sign_015, sign_016, sign_017, sign_018, sign_019, sign_020,
   sign_021, sign_022, sign_023, sign_024, sign_025, sign_026, sign_027, sign_028, sign_029, sign_030,
   sign_031, sign_032, sign_033, sign_034, sign_035, sign_036, sign_037, sign_038, sign_039, sign_040,
   sign_041, sign_042, sign_043, sign_044, sign_045, sign_046, sign_047, sign_048, sign_049, sign_050,
   sign_051, sign_052, sign_053, sign_054, sign_055, sign_056, sign_057, sign_058, sign_059, sign_060,
   sign_061, sign_062, sign_063, sign_064, sign_065, sign_066, sign_067, sign_068, sign_069, sign_070,
   sign_071, sign_072, sign_073, sign_074, sign_075, sign_076, sign_077, sign_078, sign_079, sign_080,
   sign_081, sign_082, sign_083, sign_084, sign_085, sign_086, sign_087, sign_088, sign_089, sign_090,
   sign_091, sign_092, sign_093, sign_094, sign_095, sign_096, sign_097, sign_098, sign_099, sign_100]

theorem sinais_tem_100 : sinais.length = 100 ∧ sinais.map (·.index) = (List.range 100).map (· + 1) := by decide

/-- Os conectivos que a V3 interpreta, lidos do catálogo. -/
theorem leituras_dos_conectivos :
    codifica sign_001 .paraTodo ∧ codifica sign_002 .existe ∧ codifica sign_003 .implica ∧
    codifica sign_007 .e ∧ codifica sign_011 .ou ∧ codifica sign_013 .nao ∧ codifica sign_073 .equivale ∧
    codifica sign_067 .falso ∧ codifica sign_071 .verdadeiro := by decide

set_option maxRecDepth 200000 in
/-- **Os operadores estão nos primos**: um sinal do catálogo tem leitura de operador exatamente quando o índice é
    primo, ou é 1 (∀) ou 51 (∧₂). -/
theorem operadores_nos_primos :
    ∀ s ∈ sinais, (leitura s).isSome = true ↔ (s.index = 1 ∨ s.index = 51 ∨ Nat.Prime s.index) := by
  decide

set_option maxRecDepth 200000 in
/-- A frequência declarada cai estritamente com o índice (1247 no sinal 1, 15 no sinal 100): a ordem do catálogo
    é a ordem de frequência, outro traço de construção, não de corpus. -/
theorem frequencia_decrescente : (sinais.map (·.frequency)).Chain' (· > ·) := by decide

set_option maxRecDepth 200000 in
/-- A soma das frequências declaradas e as categorias: 68 numéricos, 21 lógicos, 6 astronômicos, 5 geométricos. -/
theorem frequencia_total_e_categorias :
    (sinais.map (·.frequency)).sum = 15310 ∧
    (sinais.filter fun s => match s.category with | .Numeric => true | _ => false).length = 68 ∧
    (sinais.filter fun s => match s.category with | .Logical => true | _ => false).length = 21 ∧
    (sinais.filter fun s => match s.category with | .Astronomical => true | _ => false).length = 6 ∧
    (sinais.filter fun s => match s.category with | .Geometric => true | _ => false).length = 5 := by decide

/-! ## 2. Interpretação em três valores (Kleene) -/

inductive V3 where
  | f | i | t
  deriving DecidableEq, Repr

open V3

def neg : V3 → V3
  | t => f
  | f => t
  | i => i

def conj : V3 → V3 → V3
  | f, _ => f
  | _, f => f
  | t, t => t
  | _, _ => i

def disj : V3 → V3 → V3
  | t, _ => t
  | _, t => t
  | f, f => f
  | _, _ => i

def unario : Operador → Option (V3 → V3)
  | .nao => some neg
  | _ => none

def binario : Operador → Option (V3 → V3 → V3)
  | .e => some conj
  | .ou => some disj
  | .implica => some fun a b => disj (neg a) b
  | .equivale => some fun a b => conj (disj (neg a) b) (disj (neg b) a)
  | _ => none

/-- Semântica de um sinal do catálogo: o conectivo de Kleene do operador que o autor declara. -/
def semUn (s : HarappaSign) : Option (V3 → V3) := (leitura s).bind unario
def semBin (s : HarappaSign) : Option (V3 → V3 → V3) := (leitura s).bind binario

/-- O sinal 13 do catálogo (¬) tem exatamente um ponto fixo em V3: o indeterminado. -/
theorem sinal_13_ponto_fixo : ∃ g, semUn sign_013 = some g ∧ ∀ a, g a = a ↔ a = i :=
  ⟨neg, rfl, fun a => by cases a <;> decide⟩

/-- Com o sinal 7 (∧) e o sinal 13 (¬) do catálogo, "a ∧ ¬a" nunca é verdadeiro, e é `i` exatamente em `i`. -/
theorem sinais_7_13_contradicao :
    ∃ gE gN, semBin sign_007 = some gE ∧ semUn sign_013 = some gN ∧
      ∀ a, gE a (gN a) ≠ t ∧ (gE a (gN a) = i ↔ a = i) :=
  ⟨conj, neg, rfl, rfl, fun a => by cases a <;> decide⟩

/-- Com o sinal 3 (→), "a → a" é verdadeiro só nos valores determinados. -/
theorem sinal_3_reflexividade : ∃ g, semBin sign_003 = some g ∧ ∀ a, g a a = t ↔ a ≠ i :=
  ⟨fun a b => disj (neg a) b, rfl, fun a => by cases a <;> decide⟩

/-- Com o sinal 73 (≡), "a ≡ ¬a" (autorreferência) nunca é verdadeiro; vale `i` exatamente em `i`. -/
theorem sinal_73_autorreferencia :
    ∃ gQ gN, semBin sign_073 = some gQ ∧ semUn sign_013 = some gN ∧ ∀ a, gQ a (gN a) ≠ t ∧ (gQ a (gN a) = i ↔ a = i) :=
  ⟨fun a b => conj (disj (neg a) b) (disj (neg b) a), neg, rfl, rfl, fun a => by cases a <;> decide⟩

/-! ## 3. O mapeamento do gerador contra o catálogo -/

/-- Sinal que `correspondence_N_<P>` usa: `(3N mod 417)+1`. -/
def sinalDoGerador (n : Nat) : Nat := 3 * n % 417 + 1

/-- Para N = 1..7 (Riemann, Hodge, Yang–Mills, Navier–Stokes, BSD, Poincaré, P vs NP), o gerador escolhe os sinais
    4, 7, 10, 13, 16, 19 e 22; pelo catálogo, quatro deles não são operador nenhum e os outros são ∧, ¬ e ∈. -/
theorem gerador_sem_semantica :
    (List.range 7).map (fun k => sinalDoGerador (k + 1)) = [4, 7, 10, 13, 16, 19, 22] ∧
    leitura sign_004 = none ∧ leitura sign_007 = some .e ∧ leitura sign_010 = none ∧ leitura sign_013 = some .nao ∧
    leitura sign_016 = none ∧ leitura sign_019 = some .pertence ∧ leitura sign_022 = none := by decide

end HarappaSemantica
