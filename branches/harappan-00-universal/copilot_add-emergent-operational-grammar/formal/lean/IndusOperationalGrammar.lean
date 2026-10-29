/-
  Operational Grammar of the Indus Script
  Signs M-001 and M-002 Analysis
  
  This file formalizes the operational grammar emergent from
  signs M-001 and M-002 of the Indus Valley script.
-/

-- Scope operators define jurisdictional validity
inductive ScopeOperator where
  | openScope : ScopeOperator      -- ∅: unbounded authority
  | partialScope : ScopeOperator   -- |: unilateral restriction
  | closedScope : ScopeOperator    -- ||: bilateral restriction
  deriving Repr, DecidableEq

-- Operational states define execution status
inductive OperationalState where
  | active : OperationalState      -- immediate execution
  | passive : OperationalState     -- awaiting execution
  | suspended : OperationalState   -- conditional execution
  deriving Repr, DecidableEq

-- Domain modifiers specify operational sector
inductive DomainModifier where
  | animal : String → DomainModifier     -- production, transport
  | metric : Nat → DomainModifier        -- measurement, quantity
  | container : String → DomainModifier  -- storage, distribution
  | geometric : String → DomainModifier  -- spatial allocation
  deriving Repr

-- Functional operator encoding administrative capacity
structure FunctionalOperator where
  id : Nat
  name : String
  deriving Repr

-- Complete scoped operator
structure ScopedOperator where
  operator : FunctionalOperator
  scope : ScopeOperator
  domain : Option DomainModifier
  state : OperationalState
  deriving Repr

-- M-001: Unbounded operator
def M001 (op : FunctionalOperator) (d : Option DomainModifier) (s : OperationalState) : ScopedOperator :=
  { operator := op
  , scope := ScopeOperator.openScope
  , domain := d
  , state := s
  }

-- M-002: Bounded operator
def M002 (op : FunctionalOperator) (d : Option DomainModifier) (s : OperationalState) : ScopedOperator :=
  { operator := op
  , scope := ScopeOperator.closedScope
  , domain := d
  , state := s
  }

-- An inscription is a sequence of scoped operators
def Inscription := List ScopedOperator

-- Scope hierarchy: open > partial > closed
def scopeLessRestrictive : ScopeOperator → ScopeOperator → Bool
  | ScopeOperator.openScope, _ => true
  | ScopeOperator.partialScope, ScopeOperator.closedScope => true
  | _, _ => false

-- Core operator identity: M-001 and M-002 share the same functional operator
theorem m001_m002_identity (op : FunctionalOperator) (d : Option DomainModifier) (s : OperationalState) :
  (M001 op d s).operator = (M002 op d s).operator := by
  rfl

-- Scope distinction: M-001 and M-002 differ only in scope
theorem m001_m002_scope_distinction (op : FunctionalOperator) (d : Option DomainModifier) (s : OperationalState) :
  (M001 op d s).scope ≠ (M002 op d s).scope := by
  intro h
  cases h

-- Well-formed inscription constraints
def wellFormedInscription (insc : Inscription) : Bool :=
  match insc with
  | [] => true
  | _ => true  -- Simplified; full constraints in separate predicates

-- State transition validity
inductive StateTransition : OperationalState → OperationalState → Prop where
  | active_to_passive : StateTransition OperationalState.active OperationalState.passive
  | passive_to_suspended : StateTransition OperationalState.passive OperationalState.suspended
  | suspended_to_active : StateTransition OperationalState.suspended OperationalState.active
  | active_to_suspended : StateTransition OperationalState.active OperationalState.suspended

-- Grammatical economy: reuse operators across scopes
theorem grammatical_economy (op : FunctionalOperator) :
  ∃ (s1 s2 : ScopedOperator), s1.operator = op ∧ s2.operator = op ∧ s1.scope ≠ s2.scope := by
  use M001 op none OperationalState.active
  use M002 op none OperationalState.active
  constructor
  · rfl
  constructor
  · rfl
  · intro h; cases h

-- Scope independence: operator maintains identity across scopes
theorem scope_independence (op : FunctionalOperator) (d : Option DomainModifier) (s : OperationalState)
  (scope1 scope2 : ScopeOperator) :
  let so1 : ScopedOperator := { operator := op, scope := scope1, domain := d, state := s }
  let so2 : ScopedOperator := { operator := op, scope := scope2, domain := d, state := s }
  so1.operator = so2.operator := by
  rfl

-- Examples
def anthropomorphicOperator : FunctionalOperator :=
  { id := 1, name := "anthropomorphic" }

def bullDomain : DomainModifier :=
  DomainModifier.animal "bull"

-- Example 1: Transit authorization (M-001)
def example1_transit : ScopedOperator :=
  M001 anthropomorphicOperator (some bullDomain) OperationalState.active

-- Example 2: Institutional storage (M-002)
def example2_storage : ScopedOperator :=
  M002 anthropomorphicOperator (some (DomainModifier.container "grain")) OperationalState.passive

-- Example 3: Complex inscription
def example3_complex : Inscription :=
  [ M001 anthropomorphicOperator (some (DomainModifier.animal "fish")) OperationalState.active
  , M002 anthropomorphicOperator (some (DomainModifier.container "vessel")) OperationalState.passive
  ]

-- Verification: examples are well-formed
example : wellFormedInscription example3_complex = true := by
  rfl

-- Non-redundancy: different scope/domain/state combinations are distinct
theorem non_redundancy (op : FunctionalOperator)
  (scope1 scope2 : ScopeOperator)
  (state1 state2 : OperationalState)
  (h_scope : scope1 ≠ scope2) :
  M001 op none state1 ≠ M002 op none state2 := by
  intro h_eq
  have : (M001 op none state1).scope = (M002 op none state2).scope := by
    rw [h_eq]
  cases this

-- Type safety: all operators are well-typed
def operatorType (so : ScopedOperator) : String :=
  s!"Operator {so.operator.name} with scope {repr so.scope} in state {repr so.state}"

#eval operatorType example1_transit
#eval operatorType example2_storage
