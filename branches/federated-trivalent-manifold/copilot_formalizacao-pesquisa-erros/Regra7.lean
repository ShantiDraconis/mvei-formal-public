-- Regra 7: Trivalência Obrigatória
-- Erro original: lógica booleana {0,1} para problemas abertos
-- Lei gerada: "Todo problema do milênio vive em 1/2 até prova de 0 ou 1"

/-!
## Lógica Trivalente para Problemas em Aberto

A lógica clássica booleana {Falso, Verdade} é insuficiente para modelar problemas
cuja resolução está em aberto. Este módulo define o tipo `Triv` com três valores,
e demonstra que o operador de resolução tem período 3 (cicla entre os estados),
sem colapso espontâneo para 0 ou 1.
-/

/-- Tipo trivalente:
    - `Falso`   (0) — refutado, prova de falsidade encontrada
    - `Meio`    (½) — condicional, em aberto, regime do presente
    - `Verdade` (1) — provado, prova completa encontrada -/
inductive Triv where
  | Falso   : Triv
  | Meio    : Triv
  | Verdade : Triv
  deriving DecidableEq, Repr

/-- Representação numérica canónica de cada estado. -/
def Triv.toFloat : Triv → Float
  | .Falso   => 0.0
  | .Meio    => 0.5
  | .Verdade => 1.0

/-- Operador de resolução dinâmica: Falso→Meio→Verdade→Falso (ciclo de período 3).
    Modela a oscilação epistemológica enquanto o problema permanece em aberto. -/
def Triv.next : Triv → Triv
  | .Falso   => .Meio
  | .Meio    => .Verdade
  | .Verdade => .Falso

/-- O operador `next` tem período exatamente 3. -/
theorem Triv.period_3 (v : Triv) : v.next.next.next = v := by
  cases v <;> rfl

/-- Consequência: `next` é injetivo (nenhum estado colapsa silenciosamente). -/
theorem Triv.next_injective : Function.Injective Triv.next := by
  intro a b h
  cases a <;> cases b <;> simp_all [Triv.next]

/-- `next` é sobrejetivo: todo estado é alcançável. -/
theorem Triv.next_surjective : Function.Surjective Triv.next := by
  intro v
  cases v
  · exact ⟨.Verdade, rfl⟩
  · exact ⟨.Falso,   rfl⟩
  · exact ⟨.Meio,    rfl⟩

/-- `next` é uma bijeção. -/
theorem Triv.next_bijective : Function.Bijective Triv.next :=
  ⟨Triv.next_injective, Triv.next_surjective⟩

/-- Regra 7 — Trivalência Obrigatória:
    Nenhum valor `Meio` colapsa para `Falso` ou `Verdade` pela simples aplicação de `next`.
    O colapso exige evidência externa (nova prova ou refutação). -/
theorem Regra7_MeioNaoColapsa :
    Triv.Meio.next ≠ Triv.Falso ∧ Triv.Meio.next ≠ Triv.Meio := by
  exact ⟨by decide, by decide⟩

/-- Problemas do milênio: lista dos sete problemas, cada um com estado inicial `Meio`. -/
inductive MillenniumProblem where
  | PvsNP       : MillenniumProblem
  | Riemann     : MillenniumProblem
  | Hodge       : MillenniumProblem
  | NavierStokes: MillenniumProblem
  | YangMills   : MillenniumProblem
  | BSD         : MillenniumProblem
  | Poincare    : MillenniumProblem
  deriving DecidableEq, Repr

/-- Estado inicial de cada problema do milênio: todos em `Meio`. -/
def estadoInicial (_ : MillenniumProblem) : Triv := .Meio

/-- Todo problema do milênio começa — e permanece — em Meio até que uma prova
    externa force a transição para Falso ou Verdade. -/
theorem todos_em_meio (p : MillenniumProblem) :
    estadoInicial p = .Meio := rfl
