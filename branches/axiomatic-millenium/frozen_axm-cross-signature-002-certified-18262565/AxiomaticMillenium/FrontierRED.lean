namespace AxiomaticMillenium

/-- A transformation between two proposition-level stages. -/
abbrev Bridge (A B : Prop) := A → B

/--
A preserved frontier RED: the certified prefix `A` is available, while
the obligation `P` required by any target witness `B` is absent.

This certifies the boundary only. It does not prove the underlying open theorem.
-/
structure FrontierRED (A B P : Prop) where
  prefixWitness : A
  missing : ¬ P
  targetRequires : B → P

/-- A FrontierRED makes the current target unreachable under the encoded requirement. -/
theorem FrontierRED.target_unreachable
    {A B P : Prop} (r : FrontierRED A B P) : ¬ B := by
  intro hB
  exact r.missing (r.targetRequires hB)

/--
A formulation that is closed by falsification rather than left as an open bridge.
`A'` is a condition the route itself needs to preserve.
-/
structure ClosedFormulationRED (A A' PAlleged : Prop) where
  incompatible : A → ¬ A'
  closed : A ∧ PAlleged → False

/-- Closed formulations cannot be promoted to an open-bridge obligation under the same statement. -/
theorem ClosedFormulationRED.route_closed
    {A A' PAlleged : Prop}
    (f : ClosedFormulationRED A A' PAlleged)
    (hA : A) (hP : PAlleged) : False :=
  f.closed ⟨hA, hP⟩

/-- Publication taxonomy for preserved RED evidence. -/
inductive RedKind
  | openBridge
  | mathematicallyImpossibleBridge
  | closedByFalsification
  deriving Repr, DecidableEq

end AxiomaticMillenium
