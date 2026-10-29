/-
ATK-TRUNCATION-LAW-v1

Fail-closed truncation for proof search.

This file proves only the abstract law:
* search space is explicitly enumerable,
* blocking is decidable,
* loop closure requires a concrete witness producer,
* "not found" alone never implies closure.

No problem-specific P vs NP endpoint is proved here.
-/

namespace ATKTruncationLaw

universe u v

structure CompleteSearchSpace (Block : Type u) where
  enumerate : List Block
  complete : ∀ b : Block, b ∈ enumerate

structure BlockingPredicate (Block : Type u) where
  IsBlocking : Block → Prop
  decidableBlocking : DecidablePred IsBlocking

attribute [instance] BlockingPredicate.decidableBlocking

structure MinimalBlock
    (Block : Type u)
    (P : BlockingPredicate Block)
    (rank : Block → Nat) where
  block : Block
  isBlocking : P.IsBlocking block
  minimal : ∀ b, P.IsBlocking b → rank block ≤ rank b

structure LoopInvariant (State : Type u) where
  holds : State → Prop

structure ConcreteClosureWitness (Endpoint : Prop) where
  close : Endpoint

inductive SearchResult
    (Block : Type u)
    (State : Type v)
    (P : BlockingPredicate Block)
    (rank : Block → Nat)
    (Inv : LoopInvariant State)
  | found : MinimalBlock Block P rank → SearchResult Block State P rank Inv
  | exhausted : (∀ b : Block, ¬ P.IsBlocking b) → SearchResult Block State P rank Inv
  | loopDetected :
      (s : State) →
      Inv.holds s →
      SearchResult Block State P rank Inv

structure TruncationRule
    (Block : Type u)
    (State : Type v)
    (Endpoint : Prop)
    (P : BlockingPredicate Block)
    (rank : Block → Nat)
    (Inv : LoopInvariant State) where
  completeSpace : CompleteSearchSpace Block
  search :
    SearchResult Block State P rank Inv
  foundCloses :
    MinimalBlock Block P rank → ConcreteClosureWitness Endpoint
  exhaustedCloses :
    (∀ b : Block, ¬ P.IsBlocking b) → ConcreteClosureWitness Endpoint
  loopIsClosure :
    ∀ s : State, Inv.holds s → ConcreteClosureWitness Endpoint

theorem truncate
    {Block : Type u}
    {State : Type v}
    {Endpoint : Prop}
    {P : BlockingPredicate Block}
    {rank : Block → Nat}
    {Inv : LoopInvariant State}
    (r : TruncationRule Block State Endpoint P rank Inv) :
    ConcreteClosureWitness Endpoint := by
  cases h : r.search with
  | found m =>
      exact r.foundCloses m
  | exhausted hnone =>
      exact r.exhaustedCloses hnone
  | loopDetected s hs =>
      exact r.loopIsClosure s hs

theorem truncate_endpoint
    {Block : Type u}
    {State : Type v}
    {Endpoint : Prop}
    {P : BlockingPredicate Block}
    {rank : Block → Nat}
    {Inv : LoopInvariant State}
    (r : TruncationRule Block State Endpoint P rank Inv) :
    Endpoint := by
  exact (truncate r).close

structure WellFoundedLoopMeasure (State : Type u) where
  measure : State → Nat
  next : State → State
  decreases : ∀ s, measure (next s) < measure s

theorem loopMeasure_wellFounded
    {State : Type u}
    (m : WellFoundedLoopMeasure State) :
    WellFounded (fun a b => m.measure a < m.measure b) :=
  InvImage.wf m.measure Nat.lt_wfRel

/-
The key producer theorem required by any problem-specific instantiation.

A caller is NOT allowed to replace this with metadata saying
"loop detected".  It must construct an actual ConcreteClosureWitness.
-/
theorem loop_is_closure
    {State : Type u}
    {Endpoint : Prop}
    (Inv : LoopInvariant State)
    (produce : ∀ s : State, Inv.holds s → ConcreteClosureWitness Endpoint)
    {s : State}
    (hs : Inv.holds s) :
    ConcreteClosureWitness Endpoint :=
  produce s hs

/-
Likewise, exhaustion only closes when the caller proves true exhaustion
of the complete search space and provides a material closure witness.
-/
theorem exhausted_is_closure
    {Block : Type u}
    {Endpoint : Prop}
    (P : BlockingPredicate Block)
    (produce :
      (∀ b : Block, ¬ P.IsBlocking b) →
      ConcreteClosureWitness Endpoint)
    (h : ∀ b : Block, ¬ P.IsBlocking b) :
    ConcreteClosureWitness Endpoint :=
  produce h

end ATKTruncationLaw
