/- 
  FormalSuite/I/NandCompleteBasis.lean

  Parallel NAND lane.  This file is intentionally standalone with respect
  to the multistate kernel implementation: it does not modify or reopen any
  existing source file.

  It formalizes standard Boolean gates as NAND-only expressions and gives
  a semantics-preserving compiler from a small Boolean circuit language to
  a pure NAND AST.

  No extra axioms. No proof placeholders.
-/

import FormalSuite.Core.Prelude

namespace FormalSuite.INand

/-! ## Boolean NAND basis -/

def bnand (a b : Bool) : Bool := !(a && b)

def bnotN (a : Bool) : Bool :=
  bnand a a

def bandN (a b : Bool) : Bool :=
  let t := bnand a b
  bnand t t

def borN (a b : Bool) : Bool :=
  bnand (bnand a a) (bnand b b)

def bnorN (a b : Bool) : Bool :=
  let t := borN a b
  bnand t t

def bxorN (a b : Bool) : Bool :=
  let t := bnand a b
  bnand (bnand a t) (bnand b t)

def bxnorN (a b : Bool) : Bool :=
  let t := bxorN a b
  bnand t t

def bimpN (a b : Bool) : Bool :=
  bnand a (bnand b b)

@[simp] theorem bnotN_eq (a : Bool) :
    bnotN a = !a := by
  cases a <;> rfl

@[simp] theorem bandN_eq (a b : Bool) :
    bandN a b = (a && b) := by
  cases a <;> cases b <;> rfl

@[simp] theorem borN_eq (a b : Bool) :
    borN a b = (a || b) := by
  cases a <;> cases b <;> rfl

@[simp] theorem bnorN_eq (a b : Bool) :
    bnorN a b = !(a || b) := by
  cases a <;> cases b <;> rfl

@[simp] theorem bxorN_eq (a b : Bool) :
    bxorN a b = Bool.xor a b := by
  cases a <;> cases b <;> rfl

@[simp] theorem bxnorN_eq (a b : Bool) :
    bxnorN a b = !(Bool.xor a b) := by
  cases a <;> cases b <;> rfl

@[simp] theorem bimpN_eq (a b : Bool) :
    bimpN a b = ((!a) || b) := by
  cases a <;> cases b <;> rfl

theorem nand_is_not_and (a b : Bool) :
    bnand a b = !(a && b) := rfl

theorem nor_is_not_or (a b : Bool) :
    bnorN a b = !(a || b) := by
  exact bnorN_eq a b

theorem xnor_is_not_xor (a b : Bool) :
    bxnorN a b = !(Bool.xor a b) := by
  exact bxnorN_eq a b

/-! ## Pure NAND syntax -/

inductive NandExpr (n : Nat) where
  | input : Fin n → NandExpr n
  | nand : NandExpr n → NandExpr n → NandExpr n
  deriving Repr

namespace NandExpr

def eval {n : Nat} (ρ : Fin n → Bool) : NandExpr n → Bool
  | .input i => ρ i
  | .nand a b => bnand (eval ρ a) (eval ρ b)

def nnot {n : Nat} (a : NandExpr n) : NandExpr n :=
  .nand a a

def nandAnd {n : Nat} (a b : NandExpr n) : NandExpr n :=
  let t := .nand a b
  .nand t t

def nandOr {n : Nat} (a b : NandExpr n) : NandExpr n :=
  .nand (.nand a a) (.nand b b)

def nandNor {n : Nat} (a b : NandExpr n) : NandExpr n :=
  let t := nandOr a b
  .nand t t

def nandXor {n : Nat} (a b : NandExpr n) : NandExpr n :=
  let t := .nand a b
  .nand (.nand a t) (.nand b t)

def nandXnor {n : Nat} (a b : NandExpr n) : NandExpr n :=
  let t := nandXor a b
  .nand t t

def nandImp {n : Nat} (a b : NandExpr n) : NandExpr n :=
  .nand a (.nand b b)

@[simp] theorem eval_nnot {n : Nat} (ρ : Fin n → Bool) (a : NandExpr n) :
    eval ρ (nnot a) = !(eval ρ a) := by
  cases h : eval ρ a <;> simp [nnot, eval, bnand, h]

@[simp] theorem eval_nandAnd {n : Nat} (ρ : Fin n → Bool)
    (a b : NandExpr n) :
    eval ρ (nandAnd a b) = (eval ρ a && eval ρ b) := by
  cases ha : eval ρ a <;> cases hb : eval ρ b <;>
    simp [nandAnd, eval, bnand, ha, hb]

@[simp] theorem eval_nandOr {n : Nat} (ρ : Fin n → Bool)
    (a b : NandExpr n) :
    eval ρ (nandOr a b) = (eval ρ a || eval ρ b) := by
  cases ha : eval ρ a <;> cases hb : eval ρ b <;>
    simp [nandOr, eval, bnand, ha, hb]

@[simp] theorem eval_nandNor {n : Nat} (ρ : Fin n → Bool)
    (a b : NandExpr n) :
    eval ρ (nandNor a b) = !(eval ρ a || eval ρ b) := by
  cases ha : eval ρ a <;> cases hb : eval ρ b <;>
    simp [nandNor, nandOr, eval, bnand, ha, hb]

@[simp] theorem eval_nandXor {n : Nat} (ρ : Fin n → Bool)
    (a b : NandExpr n) :
    eval ρ (nandXor a b) = Bool.xor (eval ρ a) (eval ρ b) := by
  cases ha : eval ρ a <;> cases hb : eval ρ b <;>
    simp [nandXor, eval, bnand, ha, hb]

@[simp] theorem eval_nandXnor {n : Nat} (ρ : Fin n → Bool)
    (a b : NandExpr n) :
    eval ρ (nandXnor a b) = !(Bool.xor (eval ρ a) (eval ρ b)) := by
  cases ha : eval ρ a <;> cases hb : eval ρ b <;>
    simp [nandXnor, nandXor, eval, bnand, ha, hb]

@[simp] theorem eval_nandImp {n : Nat} (ρ : Fin n → Bool)
    (a b : NandExpr n) :
    eval ρ (nandImp a b) = (!(eval ρ a) || eval ρ b) := by
  cases ha : eval ρ a <;> cases hb : eval ρ b <;>
    simp [nandImp, eval, bnand, ha, hb]

end NandExpr

/-! ## Source circuit language -/

inductive Circuit (n : Nat) where
  | input : Fin n → Circuit n
  | notGate : Circuit n → Circuit n
  | andGate : Circuit n → Circuit n → Circuit n
  | orGate : Circuit n → Circuit n → Circuit n
  | nandGate : Circuit n → Circuit n → Circuit n
  | norGate : Circuit n → Circuit n → Circuit n
  | xorGate : Circuit n → Circuit n → Circuit n
  | xnorGate : Circuit n → Circuit n → Circuit n
  | impGate : Circuit n → Circuit n → Circuit n
  deriving Repr

namespace Circuit

def eval {n : Nat} (ρ : Fin n → Bool) : Circuit n → Bool
  | .input i => ρ i
  | .notGate a => !(eval ρ a)
  | .andGate a b => eval ρ a && eval ρ b
  | .orGate a b => eval ρ a || eval ρ b
  | .nandGate a b => bnand (eval ρ a) (eval ρ b)
  | .norGate a b => !(eval ρ a || eval ρ b)
  | .xorGate a b => Bool.xor (eval ρ a) (eval ρ b)
  | .xnorGate a b => !(Bool.xor (eval ρ a) (eval ρ b))
  | .impGate a b => !(eval ρ a) || eval ρ b

end Circuit

/-! ## Semantics-preserving compilation to NAND only -/

def compileNand {n : Nat} : Circuit n → NandExpr n
  | .input i => .input i
  | .notGate a => NandExpr.nnot (compileNand a)
  | .andGate a b => NandExpr.nandAnd (compileNand a) (compileNand b)
  | .orGate a b => NandExpr.nandOr (compileNand a) (compileNand b)
  | .nandGate a b => .nand (compileNand a) (compileNand b)
  | .norGate a b => NandExpr.nandNor (compileNand a) (compileNand b)
  | .xorGate a b => NandExpr.nandXor (compileNand a) (compileNand b)
  | .xnorGate a b => NandExpr.nandXnor (compileNand a) (compileNand b)
  | .impGate a b => NandExpr.nandImp (compileNand a) (compileNand b)

theorem compileNand_sound {n : Nat} (ρ : Fin n → Bool) (c : Circuit n) :
    NandExpr.eval ρ (compileNand c) = Circuit.eval ρ c := by
  induction c with
  | input i =>
      rfl
  | notGate a ih =>
      simp [compileNand, Circuit.eval, ih]
  | andGate a b iha ihb =>
      simp [compileNand, Circuit.eval, iha, ihb]
  | orGate a b iha ihb =>
      simp [compileNand, Circuit.eval, iha, ihb]
  | nandGate a b iha ihb =>
      simp [compileNand, Circuit.eval, NandExpr.eval, iha, ihb]
  | norGate a b iha ihb =>
      simp [compileNand, Circuit.eval, iha, ihb]
  | xorGate a b iha ihb =>
      simp [compileNand, Circuit.eval, iha, ihb]
  | xnorGate a b iha ihb =>
      simp [compileNand, Circuit.eval, iha, ihb]
  | impGate a b iha ihb =>
      simp [compileNand, Circuit.eval, iha, ihb]

/--
Every circuit built from NOT/AND/OR/NAND/NOR/XOR/XNOR/IMP has a pure
NAND expression with identical Boolean semantics.
-/
theorem exists_nand_realization {n : Nat} (c : Circuit n) :
    ∃ e : NandExpr n, ∀ ρ : Fin n → Bool,
      NandExpr.eval ρ e = Circuit.eval ρ c := by
  exact ⟨compileNand c, fun ρ => compileNand_sound ρ c⟩

end FormalSuite.INand
