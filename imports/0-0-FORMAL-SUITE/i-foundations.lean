/-
  i-foundations.lean

  Fundamentos formais para a constante simbólica I
  (interpretada conceitualmente como "0/0", mas tratada aqui
  como um elemento abstrato em um corpo, com axiomas bem definidos).

  Este arquivo não contém nenhum `sorry`.
  Axiomas novos são isolados em uma typeclass específica, `IField`.
-/

import Mathlib.Data.Real.Basic
import Mathlib.Algebra.Field.Basic
import Mathlib.Tactic

namespace IConstant

universe u

/--
`IField α` é um *corpo* (no sentido usual de matemática)
dotado de um elemento distinguido `I : α`, que satisfaz:

* `I * I = I`  (idempotência multiplicativa)
* `I ≠ 0`

Interpretamos esse `I` como a versão formal da tua constante universal,
sem impor literalmente a operação `0 / 0` no nível de Lean.
-/
class IField (α : Type u) extends Field α where
  I : α
  I_mul_self : I * I = I
  I_ne_zero : I ≠ 0

namespace IField

variable {α : Type u} [IField α]

/-- Notação local para a constante universal `I`. -/
local notation "𝓘" => IField.I (α := α)

/-- Lema direto do axioma: `𝓘 * 𝓘 = 𝓘`. -/
@[simp] lemma I_mul_self : 𝓘 * 𝓘 = (𝓘 : α) :=
  IField.I_mul_self (α := α)

/-- `𝓘 ≠ 0`. -/
lemma I_ne_zero : (𝓘 : α) ≠ 0 :=
  IField.I_ne_zero (α := α)

/--
Definição auxiliar: um elemento `x : α` é idempotente multiplicativo
se satisfaz `x * x = x`.
-/
def isIdempotent (x : α) : Prop :=
  x * x = x

/-- A própria constante `𝓘` é idempotente, por definição. -/
lemma I_isIdempotent : isIdempotent (𝓘 : α) := by
  unfold isIdempotent
  exact I_mul_self

/--
Teorema fundamental: em qualquer `IField α`, o elemento distinguido `𝓘`
coincide com `1`. Ou seja, a combinação "campo + idempotência + não-nulidade"
força `𝓘 = 1`.
-/
lemma I_eq_one : (𝓘 : α) = (1 : α) := by
  -- Começamos de `𝓘 * 𝓘 = 𝓘`.
  -- Consideramos a expressão `𝓘 * 𝓘 - 𝓘`.
  -- Por `I_mul_self`, isto é igual a `𝓘 - 𝓘 = 0`.
  have h1 : 𝓘 * 𝓘 - 𝓘 = (0 : α) := by
    -- `sub_self 𝓘` diz que `𝓘 - 𝓘 = 0`. Reescrevemos usando `I_mul_self`.
    simpa [I_mul_self] using sub_self (𝓘 : α)

  -- Reescrevemos `𝓘 * 𝓘 - 𝓘` como `𝓘 * (𝓘 - 1)` usando distributividade:
  -- `a*b - a = a*b - a*1 = a*(b - 1)`.
  have h2 : 𝓘 * (𝓘 - 1) = (0 : α) := by
    -- `mul_sub` e `one_mul` vêm da estrutura de anel/corpo.
    -- `mul_sub 𝓘 𝓘 1` : `𝓘*(𝓘 - 1) = 𝓘*𝓘 - 𝓘*1`.
    have : 𝓘 * (𝓘 - 1) = 𝓘 * 𝓘 - 𝓘 := by
      simpa [mul_sub, one_mul]  -- equivale a `rfl` mas mais legível
    -- Agora usamos `h1 : 𝓘*𝓘 - 𝓘 = 0`.
    -- Substituímos o lado esquerdo.
    exact this ▸ h1

  -- Em um campo, `a * b = 0` implica `a = 0 ∨ b = 0`.
  have h3 : 𝓘 = 0 ∨ 𝓘 - 1 = 0 := mul_eq_zero.mp h2

  -- Descartamos o caso `𝓘 = 0` usando o axioma `I_ne_zero`.
  cases h3 with
  | inl hI =>
      -- Este ramo é impossível, pois contradiz `I_ne_zero`.
      exact False.elim (I_ne_zero hI)
  | inr hIm1 =>
      -- Se `𝓘 - 1 = 0`, então `𝓘 = 1`.
      exact sub_eq_zero.mp hIm1

/-- Versão marcada com `[simp]` de `I_eq_one`. -/
@[simp] lemma I_eq_one_simp : (𝓘 : α) = (1 : α) :=
  I_eq_one

/-- Também útil na direção oposta. -/
@[simp] lemma one_eq_I_simp : (1 : α) = (𝓘 : α) :=
  I_eq_one.symm

/--
Lema: qualquer elemento idempotente e não-nulo em um campo é necessariamente `1`.
Esse resultado *não* supõe `IField`; ele vale em qualquer `Field α`.
-/
lemma eq_one_of_idempotent_of_ne_zero
    {α : Type u} [Field α] {x : α}
    (hx : x * x = x) (hx0 : x ≠ 0) :
    x = (1 : α) := by
  -- Construímos uma instância local de `IField α` onde a constante é `x`.
  classical
  let inst : IField α :=
    { toField    := ‹Field α›
      I          := x
      I_mul_self := hx
      I_ne_zero  := hx0 }

  -- Declaramos que esta instância é a que deve ser usada neste `by`.
  have : x = (1 : α) := by
    let _ : IField α := inst
    -- Agora podemos aplicar o teorema `I_eq_one` neste contexto,
    -- observando que `𝓘` é exatamente `x`.
    simpa [IField.I, inst] using
      (I_eq_one (α := α))

  exact this

/--
Unicidade da constante `I`: se `y` também for idempotente e não-nulo,
então `y = 𝓘`.

A prova é simples: ambos são iguais a `1` pelo lema anterior.
-/
lemma eq_I_of_idempotent_of_ne_zero
    {α : Type u} [Field α] [IField α]
    {y : α} (hy : y * y = y) (hy0 : y ≠ 0) :
    y = (𝓘 : α) := by
  -- `y = 1` e `𝓘 = 1`, logo `y = 𝓘`.
  have hy1 : y = (1 : α) :=
    eq_one_of_idempotent_of_ne_zero (α := α) hy hy0
  have hI1 : (𝓘 : α) = (1 : α) := I_eq_one
  -- Reescrevemos.
  calc
    y   = (1 : α) := hy1
    _   = (𝓘 : α) := by simpa [hI1]  -- 1 = 𝓘

/--
Como consequência dos axiomas, `𝓘 ^ 2 = 𝓘`.

Esta é só uma reformulação em termos de potência.
-/
@[simp] lemma I_pow_two : (𝓘 : α) ^ 2 = (𝓘 : α) := by
  -- `pow_two` diz que `x^2 = x*x`.
  simpa [pow_two, I_mul_self]

/--
Também vale que para qualquer `n ≥ 1`, `𝓘 ^ n = 𝓘`,
pois `𝓘 = 1` e, em um corpo, `1 ^ n = 1`.
-/
lemma I_pow_eq_I {n : Nat} (hn : 0 < n) :
    (𝓘 : α) ^ n = (𝓘 : α) := by
  -- Usamos o fato de que `𝓘 = 1`.
  have hI1 : (𝓘 : α) = (1 : α) := I_eq_one
  -- Substituímos `𝓘` por `1` em ambos os lados.
  calc
    (𝓘 : α) ^ n = (1 : α) ^ n := by simpa [hI1]
    _            = (1 : α)     := by
                      -- Lema padrão: `one_pow n = 1`.
                      simpa using (one_pow n : (1 : α) ^ n = (1 : α))
    _            = (𝓘 : α)     := by simpa [hI1]

end IField

/---------------------------------------------------------------/
/-- Um modelo concreto: o corpo dos reais com `I = 1`. -/
/---------------------------------------------------------------/

/--
Instância concreta de `IField ℝ`.

Isto garante que o conjunto de axiomas adotado não é contraditório:
ao menos um modelo explícito existe (os números reais com `I = 1`).
-/
instance realIField : IField ℝ where
  toField := inferInstance
  I       := (1 : ℝ)
  I_mul_self := by
    -- `1 * 1 = 1`
    simp
  I_ne_zero := by
    -- Lema clássico: `1 ≠ 0` em qualquer corpo não trivial.
    simpa using (one_ne_zero : (1 : ℝ) ≠ 0)

/--
Lema de verificação: no modelo real, a constante `I` é literalmente `1`.
Este é só um corolário direto de `I_eq_one`.
-/
@[simp] lemma real_I_eq_one :
    (IField.I (α := ℝ)) = (1 : ℝ) := by
  -- Aqui usamos a instância `realIField` definida acima.
  have : IField.I (α := ℝ) = (1 : ℝ) :=
    IField.I_eq_one (α := ℝ)
  simpa using this

end IConstant
