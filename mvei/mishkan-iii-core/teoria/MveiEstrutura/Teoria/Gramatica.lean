/-
  Gramatica.lean — reformulacoes/TeoriaMishkan (MVEI; NÃO é do autor). Gerado por tools/teoria_mishkan.py.

  A língua dos sinais como teoria. Classes gramaticais dos 417 sinais do catálogo do autor
  (core/archaeology/HARAPPA_CATALOG.lean); gramática de fórmulas gerada pelos sinais-operadores; semântica
  booleana para os conectivos, modal S5 com os cinco sítios do catálogo como mundos e quantificadores sobre o
  domínio dos 417 sinais; leis de álgebra booleana, grupo do ⊕, axiomas K, T, 4 e 5, álgebra de conjuntos; a
  tradução τ para a notação moderna é bijetiva e preserva a semântica. Os símbolos dos 27 operadores são
  conferidos no kernel contra o texto do catálogo.
-/
import archaeology.HARAPPA_CATALOG

set_option autoImplicit false

namespace MveiTeoria
open HarappaCatalog

deriving instance DecidableEq for SignCategory

/-! ## Sinais e classes gramaticais -/

/-- O sinal de índice `n` do catálogo do autor (1 … 417). -/
def sinal (n : Nat) : HarappaSign := complete_harappa_catalog.getD (n - 1) sign_001

/-- O índice gravado em cada um dos 417 sinais é a posição dele no catálogo. -/
theorem sinal_index : ∀ n < 418, 1 ≤ n → (sinal n).index = n := by decide +kernel

/-- Sinal atestado: está no catálogo do autor (1 ≤ n ≤ 417). É o valor de verdade de um sinal-átomo. -/
abbrev atestado (n : Nat) : Prop := 1 ≤ n ∧ n ≤ 417

/-- `getD` dentro do comprimento devolve um elemento da lista. -/
theorem getD_mem {α : Type} (l : List α) (i : Nat) (d : α) (h : i < l.length) : l.getD i d ∈ l := by
  rw [List.getD_eq_getElem?_getD, List.getElem?_eq_getElem h, Option.getD_some]
  exact List.getElem_mem ..

theorem sinal_mem (n : Nat) (h : atestado n) : sinal n ∈ complete_harappa_catalog := by
  have hl : complete_harappa_catalog.length = 417 := HarappaCatalog.catalog_has_417_signs
  exact getD_mem _ _ _ (by omega)

/-- O repertório do catálogo: os 417 equivalentes modernos que o autor grava. -/
def repertorio : List String := complete_harappa_catalog.map (·.modern_equivalent)

/-- Classes gramaticais (classificação do MVEI pelo símbolo moderno que o catálogo grava em cada sinal-operador;
    os sinais 1 … 100 sem operador são numerais, valor = índice; os 101 … 417 são ideogramas da categoria do
    catálogo). -/
inductive Classe
  | quantificador | ligador | conectivo | constante | relacao | modal | funtor | conjunto | numeral
  | ideograma (c : SignCategory) | ausente
  deriving DecidableEq

/-- Os 27 sinais-operadores do catálogo: (índice, símbolo moderno gravado pelo autor, classe gramatical). -/
def operadores : List (Nat × String × Classe) := [
  (1, "∀ (for all)", .quantificador),
  (2, "∃ (there exists), 2", .quantificador),
  (3, "→ (implies), 3", .conectivo),
  (5, "⊕ (XOR), 5", .conectivo),
  (7, "∧ (and), 7", .conectivo),
  (11, "∨ (or), 11", .conectivo),
  (13, "¬ (not), 13", .conectivo),
  (17, "= (equals), 17", .relacao),
  (19, "∈ (element of), 19", .relacao),
  (23, "f(x) (function), 23", .funtor),
  (29, "∘ (compose), 29", .funtor),
  (31, "∀x∃y (for all x exists y), 31", .quantificador),
  (37, "⊢ (proves), 37", .relacao),
  (41, "⊨ (entails), 41", .relacao),
  (43, "□ (necessary), 43", .modal),
  (47, "◇ (possible), 47", .modal),
  (51, "∧₂ (extended and), 51", .conectivo),
  (53, "λx.E (abstraction), 53", .ligador),
  (59, "Πx:A.B (dependent product), 59", .quantificador),
  (61, "Σx:A.B (dependent sum), 61", .quantificador),
  (67, "⊥ (false/empty), 67", .constante),
  (71, "⊤ (true/unit), 71", .constante),
  (73, "≡ (iff), 73", .conectivo),
  (79, "⊆ (subset of), 79", .relacao),
  (83, "∪ (union), 83", .conjunto),
  (89, "∩ (intersection), 89", .conjunto),
  (97, "∅ (empty set), 97", .constante)]

/-- Cada símbolo da tabela é literalmente o `modern_equivalent` do sinal no catálogo do autor. -/
theorem operadores_no_catalogo : ∀ o ∈ operadores, (sinal o.1).modern_equivalent = o.2.1 := by decide +kernel

/-- Classe gramatical do sinal `n`. -/
def classe (n : Nat) : Classe :=
  match operadores.find? (fun o => o.1 == n) with
  | some o => o.2.2
  | none => if n = 0 ∨ 417 < n then .ausente else if n ≤ 100 then .numeral else .ideograma (sinal n).category

/-- Quantos sinais há em cada classe. -/
theorem contagem_classes :
    ((List.range 417).filter (fun i => classe (i + 1) == .conectivo)).length = 7 ∧
    ((List.range 417).filter (fun i => classe (i + 1) == .conjunto)).length = 2 ∧
    ((List.range 417).filter (fun i => classe (i + 1) == .constante)).length = 3 ∧
    ((List.range 417).filter (fun i => classe (i + 1) == .funtor)).length = 2 ∧
    ((List.range 417).filter (fun i => classe (i + 1) == .ideograma .Architectural)).length = 50 ∧
    ((List.range 417).filter (fun i => classe (i + 1) == .ideograma .Astronomical)).length = 50 ∧
    ((List.range 417).filter (fun i => classe (i + 1) == .ideograma .Biological)).length = 50 ∧
    ((List.range 417).filter (fun i => classe (i + 1) == .ideograma .Compound)).length = 67 ∧
    ((List.range 417).filter (fun i => classe (i + 1) == .ideograma .Geometric)).length = 50 ∧
    ((List.range 417).filter (fun i => classe (i + 1) == .ideograma .Symbolic)).length = 50 ∧
    ((List.range 417).filter (fun i => classe (i + 1) == .ligador)).length = 1 ∧
    ((List.range 417).filter (fun i => classe (i + 1) == .modal)).length = 2 ∧
    ((List.range 417).filter (fun i => classe (i + 1) == .numeral)).length = 73 ∧
    ((List.range 417).filter (fun i => classe (i + 1) == .quantificador)).length = 5 ∧
    ((List.range 417).filter (fun i => classe (i + 1) == .relacao)).length = 5 := by decide +kernel

/-! ## Gramática e semântica -/

/-- Os cinco sítios do catálogo: os mundos da semântica modal (□ vale em todos os sítios, ◇ em algum). -/
inductive Sitio | harappa | mohenjoDaro | dholavira | lothal | kalibangan
  deriving DecidableEq

def sitios : List Sitio := [.harappa, .mohenjoDaro, .dholavira, .lothal, .kalibangan]

theorem mem_sitios (w : Sitio) : w ∈ sitios := by cases w <;> simp [sitios]

/-- Valoração: em cada sítio, quais sinais-átomo valem. -/
abbrev Valoracao := Sitio → Nat → Bool

/-- Valoração canônica: um sinal vale, em todo sítio, quando está atestado no catálogo. -/
def valoracaoCanonica : Valoracao := fun _ n => decide (atestado n)

/-- Fórmulas da língua dos sinais: os átomos são sinais e cada operador é um sinal-operador do catálogo
    (⊤ 71, ⊥ 67, ¬ 13, ∧ 7, ∨ 11, → 3, ⊕ 5, ≡ 73, □ 43, ◇ 47). -/
inductive FormulaH
  | atomo (n : Nat)
  | verum
  | falsum
  | nao (a : FormulaH)
  | e (a b : FormulaH)
  | ou (a b : FormulaH)
  | implica (a b : FormulaH)
  | xor (a b : FormulaH)
  | equiv (a b : FormulaH)
  | necessario (a : FormulaH)
  | possivel (a : FormulaH)
  deriving DecidableEq

/-- Os sinais com que a fórmula se escreve (notação prefixa: operador, depois os argumentos). -/
def FormulaH.sinais : FormulaH → List Nat
  | .atomo n => [n]
  | .verum => [71]
  | .falsum => [67]
  | .nao a => 13 :: a.sinais
  | .e a b => 7 :: (a.sinais ++ b.sinais)
  | .ou a b => 11 :: (a.sinais ++ b.sinais)
  | .implica a b => 3 :: (a.sinais ++ b.sinais)
  | .xor a b => 5 :: (a.sinais ++ b.sinais)
  | .equiv a b => 73 :: (a.sinais ++ b.sinais)
  | .necessario a => 43 :: a.sinais
  | .possivel a => 47 :: a.sinais

/-- Os dez operadores da gramática estão na tabela de operadores do catálogo. -/
theorem operadores_da_gramatica :
    ∀ n ∈ [71, 67, 13, 7, 11, 3, 5, 73, 43, 47], (operadores.find? (fun o => o.1 == n)).isSome = true := by decide

/-- Semântica: conectivos booleanos; □ e ◇ quantificam sobre os cinco sítios (S5). -/
def evalH (v : Valoracao) (w : Sitio) : FormulaH → Bool
  | .atomo n => v w n
  | .verum => true
  | .falsum => false
  | .nao a => !evalH v w a
  | .e a b => evalH v w a && evalH v w b
  | .ou a b => evalH v w a || evalH v w b
  | .implica a b => !evalH v w a || evalH v w b
  | .xor a b => Bool.xor (evalH v w a) (evalH v w b)
  | .equiv a b => evalH v w a == evalH v w b
  | .necessario a => sitios.all (fun u => evalH v u a)
  | .possivel a => sitios.any (fun u => evalH v u a)

/-- Fórmulas na notação moderna (lógica modal proposicional clássica). -/
inductive FormulaM
  | var (n : Nat)
  | top
  | bot
  | neg (a : FormulaM)
  | conj (a b : FormulaM)
  | disj (a b : FormulaM)
  | imp (a b : FormulaM)
  | xor (a b : FormulaM)
  | iff (a b : FormulaM)
  | box (a : FormulaM)
  | dia (a : FormulaM)
  deriving DecidableEq

def evalM (v : Valoracao) (w : Sitio) : FormulaM → Bool
  | .var n => v w n
  | .top => true
  | .bot => false
  | .neg a => !evalM v w a
  | .conj a b => evalM v w a && evalM v w b
  | .disj a b => evalM v w a || evalM v w b
  | .imp a b => !evalM v w a || evalM v w b
  | .xor a b => Bool.xor (evalM v w a) (evalM v w b)
  | .iff a b => evalM v w a == evalM v w b
  | .box a => sitios.all (fun u => evalM v u a)
  | .dia a => sitios.any (fun u => evalM v u a)

/-- τ: o dicionário sinal → símbolo moderno. -/
def tau : FormulaH → FormulaM
  | .atomo n => .var n
  | .verum => .top
  | .falsum => .bot
  | .nao a => .neg (tau a)
  | .e a b => .conj (tau a) (tau b)
  | .ou a b => .disj (tau a) (tau b)
  | .implica a b => .imp (tau a) (tau b)
  | .xor a b => .xor (tau a) (tau b)
  | .equiv a b => .iff (tau a) (tau b)
  | .necessario a => .box (tau a)
  | .possivel a => .dia (tau a)

/-- σ: o dicionário de volta. -/
def sigma : FormulaM → FormulaH
  | .var n => .atomo n
  | .top => .verum
  | .bot => .falsum
  | .neg a => .nao (sigma a)
  | .conj a b => .e (sigma a) (sigma b)
  | .disj a b => .ou (sigma a) (sigma b)
  | .imp a b => .implica (sigma a) (sigma b)
  | .xor a b => .xor (sigma a) (sigma b)
  | .iff a b => .equiv (sigma a) (sigma b)
  | .box a => .necessario (sigma a)
  | .dia a => .possivel (sigma a)

theorem sigma_tau (f : FormulaH) : sigma (tau f) = f := by
  induction f <;> simp_all [tau, sigma]

theorem tau_sigma (f : FormulaM) : tau (sigma f) = f := by
  induction f <;> simp_all [tau, sigma]

theorem tau_injective : Function.Injective tau := fun a b h => by
  rw [← sigma_tau a, ← sigma_tau b, h]

theorem tau_surjective : Function.Surjective tau := fun f => ⟨sigma f, tau_sigma f⟩

/-- A tradução preserva a semântica, em toda valoração e todo sítio. -/
theorem evalM_tau (v : Valoracao) (w : Sitio) (f : FormulaH) : evalM v w (tau f) = evalH v w f := by
  induction f generalizing w <;> simp_all [tau, evalM, evalH]

/-- Renomeação de átomos na notação moderna. -/
def renomear (s : Nat → Nat) : FormulaM → FormulaM
  | .var n => .var (s n)
  | .top => .top
  | .bot => .bot
  | .neg a => .neg (renomear s a)
  | .conj a b => .conj (renomear s a) (renomear s b)
  | .disj a b => .disj (renomear s a) (renomear s b)
  | .imp a b => .imp (renomear s a) (renomear s b)
  | .xor a b => .xor (renomear s a) (renomear s b)
  | .iff a b => .iff (renomear s a) (renomear s b)
  | .box a => .box (renomear s a)
  | .dia a => .dia (renomear s a)

theorem evalM_renomear (v : Valoracao) (s : Nat → Nat) (w : Sitio) (f : FormulaM) :
    evalM v w (renomear s f) = evalM (fun u n => v u (s n)) w f := by
  induction f generalizing w <;> simp_all [renomear, evalM]

/-- Estruturas isomorfas (valorações iguais a menos de renomear os átomos) satisfazem as mesmas fórmulas. -/
theorem equiv_renomear (v v' : Valoracao) (s : Nat → Nat) (hv : ∀ w n, v w n = v' w (s n)) (w : Sitio)
    (f : FormulaH) : evalH v w f = evalM v' w (renomear s (tau f)) := by
  rw [evalM_renomear]
  have : (fun u n => v' u (s n)) = v := funext fun u => funext fun n => (hv u n).symm
  rw [this, evalM_tau]

/-! ## Álgebra: leis da álgebra booleana, do ⊕ e da lógica S5 -/

section Algebra
variable (v : Valoracao) (w : Sitio) (a b c : FormulaH)

theorem e_comut : evalH v w (.e a b) = evalH v w (.e b a) := by
  simp only [evalH]; cases evalH v w a <;> cases evalH v w b <;> rfl
theorem ou_comut : evalH v w (.ou a b) = evalH v w (.ou b a) := by
  simp only [evalH]; cases evalH v w a <;> cases evalH v w b <;> rfl
theorem e_assoc : evalH v w (.e (.e a b) c) = evalH v w (.e a (.e b c)) := by
  simp only [evalH]; cases evalH v w a <;> cases evalH v w b <;> cases evalH v w c <;> rfl
theorem ou_assoc : evalH v w (.ou (.ou a b) c) = evalH v w (.ou a (.ou b c)) := by
  simp only [evalH]; cases evalH v w a <;> cases evalH v w b <;> cases evalH v w c <;> rfl
theorem e_distrib_ou : evalH v w (.e a (.ou b c)) = evalH v w (.ou (.e a b) (.e a c)) := by
  simp only [evalH]; cases evalH v w a <;> cases evalH v w b <;> cases evalH v w c <;> rfl
theorem ou_distrib_e : evalH v w (.ou a (.e b c)) = evalH v w (.e (.ou a b) (.ou a c)) := by
  simp only [evalH]; cases evalH v w a <;> cases evalH v w b <;> cases evalH v w c <;> rfl
theorem absorcao : evalH v w (.e a (.ou a b)) = evalH v w a := by
  simp only [evalH]; cases evalH v w a <;> cases evalH v w b <;> rfl
theorem de_morgan_e : evalH v w (.nao (.e a b)) = evalH v w (.ou (.nao a) (.nao b)) := by
  simp only [evalH]; cases evalH v w a <;> cases evalH v w b <;> rfl
theorem de_morgan_ou : evalH v w (.nao (.ou a b)) = evalH v w (.e (.nao a) (.nao b)) := by
  simp only [evalH]; cases evalH v w a <;> cases evalH v w b <;> rfl
theorem dupla_negacao : evalH v w (.nao (.nao a)) = evalH v w a := by
  simp only [evalH]; cases evalH v w a <;> rfl
theorem terceiro_excluido : evalH v w (.ou a (.nao a)) = true := by
  simp only [evalH]; cases evalH v w a <;> rfl
theorem nao_contradicao : evalH v w (.e a (.nao a)) = false := by
  simp only [evalH]; cases evalH v w a <;> rfl
theorem implicacao_material : evalH v w (.implica a b) = evalH v w (.ou (.nao a) b) := by
  simp only [evalH]
theorem equiv_eh_nao_xor : evalH v w (.equiv a b) = evalH v w (.nao (.xor a b)) := by
  simp only [evalH]; cases evalH v w a <;> cases evalH v w b <;> rfl
theorem xor_comut : evalH v w (.xor a b) = evalH v w (.xor b a) := by
  simp only [evalH]; cases evalH v w a <;> cases evalH v w b <;> rfl
theorem xor_assoc : evalH v w (.xor (.xor a b) c) = evalH v w (.xor a (.xor b c)) := by
  simp only [evalH]; cases evalH v w a <;> cases evalH v w b <;> cases evalH v w c <;> rfl
theorem xor_neutro : evalH v w (.xor a .falsum) = evalH v w a := by
  simp only [evalH]; cases evalH v w a <;> rfl
theorem xor_inverso : evalH v w (.xor a a) = false := by
  simp only [evalH]; cases evalH v w a <;> rfl
theorem e_neutro : evalH v w (.e a .verum) = evalH v w a := by
  simp only [evalH]; cases evalH v w a <;> rfl
theorem ou_neutro : evalH v w (.ou a .falsum) = evalH v w a := by
  simp only [evalH]; cases evalH v w a <;> rfl

theorem nec_iff : evalH v w (.necessario a) = true ↔ ∀ u, evalH v u a = true := by
  simp only [evalH, List.all_eq_true]
  exact ⟨fun h u => h u (mem_sitios u), fun h u _ => h u⟩
theorem pos_iff : evalH v w (.possivel a) = true ↔ ∃ u, evalH v u a = true := by
  simp only [evalH, List.any_eq_true]
  exact ⟨fun ⟨u, _, h⟩ => ⟨u, h⟩, fun ⟨u, h⟩ => ⟨u, mem_sitios u, h⟩⟩
theorem imp_iff : evalH v w (.implica a b) = true ↔ (evalH v w a = true → evalH v w b = true) := by
  simp only [evalH]; cases evalH v w a <;> cases evalH v w b <;> simp
theorem nao_iff : evalH v w (.nao a) = true ↔ ¬ evalH v w a = true := by
  simp only [evalH]; cases evalH v w a <;> simp

/-- K: □(a → b) → (□a → □b). -/
theorem s5_K : evalH v w (.implica (.necessario (.implica a b)) (.implica (.necessario a) (.necessario b))) = true := by
  simp only [imp_iff, nec_iff]
  exact fun h1 h2 u => h1 u (h2 u)
/-- T: □a → a. -/
theorem s5_T : evalH v w (.implica (.necessario a) a) = true := by
  simp only [imp_iff, nec_iff]
  exact fun h => h w
/-- 4: □a → □□a. -/
theorem s5_4 : evalH v w (.implica (.necessario a) (.necessario (.necessario a))) = true := by
  simp only [imp_iff, nec_iff]
  exact fun h _ u => h u
/-- 5: ◇a → □◇a. -/
theorem s5_5 : evalH v w (.implica (.possivel a) (.necessario (.possivel a))) = true := by
  simp only [imp_iff, nec_iff, pos_iff]
  exact fun h _ => h
/-- Dualidade: □a = ¬◇¬a. -/
theorem dualidade_modal : evalH v w (.necessario a) = true ↔ evalH v w (.nao (.possivel (.nao a))) = true := by
  simp only [nao_iff, nec_iff, pos_iff]
  exact ⟨fun h ⟨u, hu⟩ => hu (h u), fun h u => Decidable.byContradiction fun hc => h ⟨u, hc⟩⟩

end Algebra

/-! ## Quantificadores (sinais 1 e 2) sobre o domínio do catálogo -/

/-- ∀ (sinal 1) sobre os 417 sinais. -/
def paraTodo (p : Nat → Bool) : Bool := (List.range 417).all (fun i => p (i + 1))
/-- ∃ (sinal 2) sobre os 417 sinais. -/
def existe (p : Nat → Bool) : Bool := (List.range 417).any (fun i => p (i + 1))

theorem nao_all (l : List Nat) (p : Nat → Bool) : (!l.all p) = l.any (fun n => !p n) := by
  induction l with
  | nil => rfl
  | cons x xs ih => simp only [List.all_cons, List.any_cons, Bool.not_and, ih]

/-- De Morgan dos quantificadores: ¬∀ = ∃¬. -/
theorem nao_paraTodo (p : Nat → Bool) : (!paraTodo p) = existe (fun n => !p n) := by
  unfold paraTodo existe; exact nao_all _ _

/-- Todo sinal do catálogo está atestado (∀ sobre o domínio). -/
theorem todos_atestados : paraTodo (fun n => decide (atestado n)) = true := by decide +kernel

/-! ## Álgebra de conjuntos (sinais 83 ∪, 89 ∩, 97 ∅, 79 ⊆, 19 ∈) -/

abbrev Conjunto := Nat → Bool
def uniao (A B : Conjunto) : Conjunto := fun n => A n || B n
def intersecao (A B : Conjunto) : Conjunto := fun n => A n && B n
def vazio : Conjunto := fun _ => false
def pertence (n : Nat) (A : Conjunto) : Prop := A n = true
def contido (A B : Conjunto) : Prop := ∀ n, pertence n A → pertence n B

theorem uniao_comut (A B : Conjunto) : uniao A B = uniao B A := funext fun n => Bool.or_comm (A n) (B n)
theorem intersecao_comut (A B : Conjunto) : intersecao A B = intersecao B A :=
  funext fun n => Bool.and_comm (A n) (B n)
theorem intersecao_distrib (A B C : Conjunto) :
    intersecao A (uniao B C) = uniao (intersecao A B) (intersecao A C) := funext fun n => by
  simp only [intersecao, uniao]; cases A n <;> cases B n <;> cases C n <;> rfl
theorem vazio_neutro (A : Conjunto) : uniao A vazio = A := funext fun n => by
  simp only [uniao, vazio]; cases A n <;> rfl
theorem nada_pertence_ao_vazio (n : Nat) : ¬ pertence n vazio := by simp [pertence, vazio]
theorem contido_uniao (A B : Conjunto) : contido A (uniao A B) := fun n h => by
  simp only [pertence, uniao] at *; rw [h]; rfl

end MveiTeoria
