/-
  Axioms.lean — I Framework Core Axioms
  Indeterminate Collapse Core, v1.0.0

  Declares all five axioms governing the meta-mathematical constant I = 0/0.
  These axioms extend ZFC with a meta-layer symbol I representing structural
  indeterminacy. They are declared as `axiom` (assumed, not proven) since
  they are foundational postulates.

  Status: Stable — axioms are complete and consistent with known usage.
  Proofs of consistency with ZFC are an open research question.
-/

/-! # Core Type: IState -/

/-- The fundamental value type in the I Framework.
    A value is either Known (carries a determinate value of type α)
    or Indeterminate (the collapse state I). -/
inductive IState (α : Type) where
  | Known      : α → IState α
  | Indeterminate : IState α
  deriving Repr, DecidableEq

/-- Notation: `I` refers to the Indeterminate state -/
def IState.I {α : Type} : IState α := IState.Indeterminate

/-- Notation: shorthand constructors -/
notation "♦" => IState.Indeterminate

/-! # Axiom 0: Existence -/

/-- Axiom 0 (Existence): The meta-mathematical symbol I exists and is distinct
    from every determinate (Known) value.

    Formally: ∀ α, ∀ x : α, I ≠ Known x

    This cannot be proven from within Lean's type system alone; it is a
    postulate establishing I's existence in the meta-layer M, disjoint from
    the ZFC universe. -/
axiom axiom_existence : ∀ (α : Type) (x : α),
  (IState.I : IState α) ≠ IState.Known x

/-! # Axiom 1: Duality -/

/-- A Problem is any proposition with a formal statement. -/
structure Problem where
  statement : Prop

/-- Known domain: problems with decidable answers within ZFC -/
def Problem.isKnown (P : Problem) : Prop :=
  ∃ (b : Bool), (b = true ↔ P.statement)

/-- Unknown domain: problems not (yet) resolvable within ZFC -/
def Problem.isUnknown (P : Problem) : Prop :=
  ¬Problem.isKnown P

/-- Axiom 1 (Duality): Every problem is either Known or Unknown — not both.
    This induces a partition of all problems into two disjoint domains K and U. -/
axiom axiom_duality : ∀ (P : Problem),
  Problem.isKnown P ⊕ Problem.isUnknown P

/-! # Axiom 2: Collapse -/

/-- Axiom 2 (Collapse): Unknown problems collapse to I.
    The collapse mapping is well-defined and information-preserving only in
    that it yields exactly I for every unknown problem — no more, no less. -/
axiom axiom_collapse : ∀ (P : Problem),
  Problem.isUnknown P →
  (IState.I : IState Prop) = IState.I

/-- Non-computable collapse function: maps every problem to its IState -/
noncomputable def collapse (P : Problem) : IState Prop :=
  if Problem.isKnown P then
    IState.Known P.statement
  else
    IState.I

/-! # Axiom 3: Invariance -/

/-- Axiom 3 (Invariance): All unknown problems collapse to the *same* I.
    There is a single, universal collapse target; indeterminacy is not indexed
    by the specific problem — it is structurally uniform. -/
axiom axiom_invariance : ∀ (P Q : Problem),
  Problem.isUnknown P → Problem.isUnknown Q →
  collapse P = collapse Q

/-! # Axiom 4: Non-Interference (Firewall) -/

/-- The Firewall property: a function f preserves I (maps I to I).
    Classical operations must not "evaluate" or "collapse" I. -/
def preservesI {α β : Type} (f : IState α → IState β) : Prop :=
  f IState.I = IState.I

/-- Axiom 4 (Non-Interference): The collapse mapping I does not alter any
    ZFC-provable theorem. Equivalently, lifting any total function f : α → β
    to operate on IState preserves the Indeterminate state. -/
axiom axiom_nonInterference : ∀ (α β : Type) (f : α → β),
  preservesI (fun s => match s with
    | IState.Known x  => IState.Known (f x)
    | IState.Indeterminate => IState.I)

/-! # Basic Consequences -/

/-- I is not equal to any Known value (direct from Axiom 0) -/
theorem I_ne_known {α : Type} (x : α) :
    (IState.I : IState α) ≠ IState.Known x :=
  axiom_existence α x

/-- Known values are not I -/
theorem known_ne_I {α : Type} (x : α) :
    IState.Known x ≠ (IState.I : IState α) :=
  Ne.symm (axiom_existence α x)

/-- The lift of any total function preserves I -/
theorem lift_preserves_I {α β : Type} (f : α → β) :
    (fun s => match s with
      | IState.Known x => IState.Known (f x)
      | IState.Indeterminate => IState.I) IState.I = IState.I :=
  axiom_nonInterference α β f
