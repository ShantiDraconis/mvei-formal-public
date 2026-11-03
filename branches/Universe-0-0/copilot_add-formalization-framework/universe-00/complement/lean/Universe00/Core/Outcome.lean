/-
  Universe00/Core/Outcome.lean
  
  Outcome type: the absolute core of the Complement Layer.
  
  Outcome wraps results to explicitly represent limits:
  - value(x): Normal computation result
  - limit(ℓ): Structural boundary hit
  
  Key law: No sensitive operator returns α directly.
  Everything goes through Outcome to make limits explicit.
-/

import Universe00.Core.LimitState

namespace Universe00.Core

/-- Outcome type: either a value or a limit state -/
inductive Outcome (α : Type) where
  | value : α → Outcome α
  | limit : LimitState → Outcome α
  deriving Repr

namespace Outcome

variable {α β γ : Type}

/-- Extract value from Outcome (unsafe, for proven cases only) -/
def unsafeGet : Outcome α → Option α
  | value x => some x
  | limit _ => none

/-- Check if outcome is a value -/
def isValue : Outcome α → Bool
  | value _ => true
  | limit _ => false

/-- Check if outcome is a limit -/
def isLimit : Outcome α → Bool
  | value _ => false
  | limit _ => true

/-- Map a function over an outcome -/
def map (f : α → β) : Outcome α → Outcome β
  | value x => value (f x)
  | limit ℓ => limit ℓ

/-- Monadic bind: compose operations that return Outcome -/
def bind (ma : Outcome α) (f : α → Outcome β) : Outcome β :=
  match ma with
  | value a => f a
  | limit ℓ => limit ℓ

/-- Pure: lift a value into Outcome -/
def pure (x : α) : Outcome α := value x

/-- Apply: apply a function in Outcome to a value in Outcome -/
def ap (mf : Outcome (α → β)) (ma : Outcome α) : Outcome β :=
  match mf, ma with
  | value f, value a => value (f a)
  | limit ℓ, _       => limit ℓ
  | _, limit ℓ       => limit ℓ

/-- Get the limit state if outcome is a limit -/
def getLimit : Outcome α → Option LimitState
  | value _ => none
  | limit ℓ => some ℓ

/-- Outcome forms a monad -/
instance : Monad Outcome where
  pure := pure
  bind := bind

/-- Functor instance -/
instance : Functor Outcome where
  map := map

/-- Alternative: choose first non-limit outcome -/
def orElse (ma mb : Outcome α) : Outcome α :=
  match ma with
  | value x => value x
  | limit _ => mb

/-- Catch a limit and provide alternative -/
def catchLimit (ma : Outcome α) (handler : LimitState → Outcome α) : Outcome α :=
  match ma with
  | value x => value x
  | limit ℓ => handler ℓ

/-- Sequence a list of outcomes -/
def sequence : List (Outcome α) → Outcome (List α)
  | [] => value []
  | (mx :: mxs) => do
      let x ← mx
      let xs ← sequence mxs
      return x :: xs

/-- Fold over a list with Outcome accumulator -/
def foldM (f : β → α → Outcome β) (init : β) : List α → Outcome β
  | [] => value init
  | (x :: xs) => do
      let acc ← f init x
      foldM f acc xs

end Outcome

end Universe00.Core
