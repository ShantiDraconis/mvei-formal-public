/-
ATK-TRUNCATION-LAW-v1
Fail-closed truncation protocol.

This file does NOT prove P ≠ NP and does NOT turn search failure into a theorem.
It proves only the abstract composition rule: loop closure is admissible iff
the loop case carries a concrete closure witness.
-/

namespace TruncationLaw

universe u v

structure MinimalBlock (Block : Type u) where
  block : Block

inductive SearchResult
    (Block : Type u)
    (ConcreteClosureWitness : Type v)
    (IsBlocking : Block → Prop)
    where
  | found :
      MinimalBlock Block →
      SearchResult Block ConcreteClosureWitness IsBlocking
  | exhausted :
      (∀ b : Block, ¬ IsBlocking b) →
      SearchResult Block ConcreteClosureWitness IsBlocking
  | loopDetected :
      ConcreteClosureWitness →
      SearchResult Block ConcreteClosureWitness IsBlocking

structure WellFoundedSearch (State : Type u) where
  rank : State → Nat
  step : State → State
  decreases : ∀ s, rank (step s) < rank s

theorem search_relation_wellFounded
    {State : Type u}
    (s : WellFoundedSearch State) :
    WellFounded (fun a b => s.rank a < s.rank b) :=
  InvImage.wf s.rank Nat.lt_wfRel

structure ClosureRule
    (Block : Type u)
    (ConcreteClosureWitness : Type v)
    (Endpoint : Prop)
    (IsBlocking : Block → Prop) where
  closeFound : MinimalBlock Block → Endpoint
  closeExhausted : (∀ b : Block, ¬ IsBlocking b) → Endpoint
  closeLoop : ConcreteClosureWitness → Endpoint

theorem truncate
    {Block : Type u}
    {ConcreteClosureWitness : Type v}
    {Endpoint : Prop}
    {IsBlocking : Block → Prop}
    (rule : ClosureRule Block ConcreteClosureWitness Endpoint IsBlocking)
    (result : SearchResult Block ConcreteClosureWitness IsBlocking) :
    Endpoint := by
  cases result with
  | found b =>
      exact rule.closeFound b
  | exhausted h =>
      exact rule.closeExhausted h
  | loopDetected witness =>
      exact rule.closeLoop witness

/--
Critical fail-closed property:
there is no constructor turning mere failure-to-find into loop closure.
The loop branch is inhabited only by an actual ConcreteClosureWitness.
-/
theorem loop_requires_witness
    {Block : Type u}
    {ConcreteClosureWitness : Type v}
    {IsBlocking : Block → Prop}
    (r : SearchResult Block ConcreteClosureWitness IsBlocking)
    (h : ∃ w, r = SearchResult.loopDetected w) :
    Nonempty ConcreteClosureWitness := by
  obtain ⟨w, _⟩ := h
  exact ⟨w⟩

end TruncationLaw
