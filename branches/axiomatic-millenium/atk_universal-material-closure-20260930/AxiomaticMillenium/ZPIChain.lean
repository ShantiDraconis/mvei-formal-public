import AxiomaticMillenium.Identification

namespace AxiomaticMillenium

/--
End-to-end Z → P/I integration theorem.

The theorem reuses the canonical-identification, preservation and invariance
interfaces and proves that they compose without introducing new axioms.
-/
theorem zpi_chain_closes
    {X Canonical Y : Type}
    {P : X → Prop}
    {f : X → X}
    {obs : X → Y}
    (z : IdentificationOperator X Canonical)
    (p : PreservationOperator X P f)
    (i : InvarianceOperator X Y obs f)
    (x : X)
    (hx : P x) :
    ∃ c : Canonical,
      z.realize c = x ∧
      P (f x) ∧
      obs (f x) = obs x := by
  obtain ⟨c, hc⟩ := Z_closure_law z x
  exact ⟨c, hc, p.preserves x hx, i.invariant x⟩

end AxiomaticMillenium
