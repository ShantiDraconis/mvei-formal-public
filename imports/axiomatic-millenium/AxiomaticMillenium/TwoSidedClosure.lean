import AxiomaticMillenium.GlobalOpenMathCut

namespace AxiomaticMillenium

/--
A problem can be logically closed in one of two classical states:
proved carries a proof of P; refuted carries a proof of not-P.

This closes the status space, not automatically the positive conjecture.
-/
inductive MathematicalOutcome (P : Prop) : Type where
  | proved : P -> MathematicalOutcome P
  | refuted : (P -> False) -> MathematicalOutcome P

/-- Every proposition has a classically closed status. -/
theorem outcome_total (P : Prop) :
    Nonempty (MathematicalOutcome P) := by
  rcases Classical.em P with h | h
  · exact ⟨.proved h⟩
  · exact ⟨.refuted h⟩

/--
A bridge can be made total over both outcomes: consumers provide one
continuation for a proof and one for a refutation.
-/
def outcomeBridge
    {P Q : Prop}
    (onProved : P -> Q)
    (onRefuted : (P -> False) -> Q)
    (o : MathematicalOutcome P) : Q :=
  match o with
  | .proved h => onProved h
  | .refuted h => onRefuted h

/--
Two-sided closure theorem. If the same target Q follows from either a proof
or a refutation of P, then Q is classically closed without choosing a branch
in advance.
-/
theorem two_sided_closure
    {P Q : Prop}
    (onProved : P -> Q)
    (onRefuted : (P -> False) -> Q) :
    Q := by
  rcases Classical.em P with h | h
  · exact onProved h
  · exact onRefuted h

/-- Positive closure is available exactly when the outcome is the proved branch. -/
theorem proved_branch_closes_positive
    {P : Prop} (h : P) :
    P := by
  exact h

/-- Negative closure is available exactly when the outcome is the refuted branch. -/
theorem refuted_branch_closes_negative
    {P : Prop} (h : P -> False) :
    P -> False := by
  exact h

/--
A contradictory both-state package collapses classical consistency for P.
It is therefore not admitted as an ordinary successful closure state.
-/
theorem both_states_imply_false
    {P : Prop} (hp : P) (hn : P -> False) :
    False := hn hp

end AxiomaticMillenium

namespace AxiomaticMillenium

/--
Four-way audit envelope.  The both constructor is permitted only when
the caller supplies both proofs.  undetermined is a process state and
carries no mathematical conclusion.
-/
inductive MultistateOutcome (P : Prop) : Type where
  | proved : P -> MultistateOutcome P
  | refuted : (P -> False) -> MultistateOutcome P
  | both : P -> (P -> False) -> MultistateOutcome P
  | undetermined : MultistateOutcome P

/--
Mathematical content extractable from a multistate outcome.
undetermined deliberately maps to True, while both exposes contradiction.
-/
def MultistateOutcome.Semantics {P : Prop} : MultistateOutcome P -> Prop
  | .proved _ => P
  | .refuted _ => (P -> False)
  | .both _ _ => False
  | .undetermined => True

theorem multistateOutcome_sound
    {P : Prop} (o : MultistateOutcome P) :
    o.Semantics := by
  cases o with
  | proved hp => exact hp
  | refuted hn => exact hn
  | both hp hn => exact hn hp
  | undetermined => trivial

/--
A downstream bridge is mathematically branch-complete precisely when it can
consume either a positive or a negative resolution of P and produce the same Q.
-/
structure BranchCompleteBridge (P Q : Prop) where
  onProved : P -> Q
  onRefuted : (P -> False) -> Q

def BranchCompleteBridge.run
    {P Q : Prop}
    (B : BranchCompleteBridge P Q)
    (o : MathematicalOutcome P) : Q :=
  outcomeBridge B.onProved B.onRefuted o

theorem BranchCompleteBridge.closes
    {P Q : Prop}
    (B : BranchCompleteBridge P Q) :
    Q :=
  two_sided_closure B.onProved B.onRefuted

/--
When the target is the conjecture itself, the positive branch closes P and
the negative branch closes not-P.  The branch-independent mathematical target
is therefore the resolution object, not P alone.
-/
inductive ConjectureResolution (P : Prop) : Type where
  | proved : P -> ConjectureResolution P
  | refuted : (P -> False) -> ConjectureResolution P

theorem conjectureResolution_total (P : Prop) :
    Nonempty (ConjectureResolution P) := by
  rcases Classical.em P with h | h
  · exact ⟨.proved h⟩
  · exact ⟨.refuted h⟩

/--
A positive endpoint can only be extracted from the proved branch.
-/
def positiveProof? {P : Prop} :
    ConjectureResolution P -> Option (PLift P)
  | .proved hp => some ⟨hp⟩
  | .refuted _ => none

/--
A negative endpoint can only be extracted from the refuted branch.
-/
def negativeProof? {P : Prop} :
    ConjectureResolution P -> Option (PLift (P -> False))
  | .proved _ => none
  | .refuted hn => some ⟨hn⟩

theorem both_resolution_branches_exclusive
    {P : Prop}
    (hp : P)
    (hn : P -> False) :
    False := hn hp

#print axioms AxiomaticMillenium.multistateOutcome_sound
#print axioms AxiomaticMillenium.BranchCompleteBridge.closes
#print axioms AxiomaticMillenium.conjectureResolution_total
#print axioms AxiomaticMillenium.both_resolution_branches_exclusive

end AxiomaticMillenium
