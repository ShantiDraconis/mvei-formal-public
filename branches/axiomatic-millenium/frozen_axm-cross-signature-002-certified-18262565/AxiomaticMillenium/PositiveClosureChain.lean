import AxiomaticMillenium.RNCBChain
import AxiomaticMillenium.ZPIChain

namespace AxiomaticMillenium

/--
Integration theorem for the complete positive closure backbone currently
formalized in AXIOMATIC-MILLENIUM:

  R -> N -> C -> B
  plus
  Z -> P / I

U is treated as the producer precondition supplied by `a` and `ha`.
F is intentionally excluded because it is a negative/falsification status,
not a positive closure operator.
-/
theorem positive_closure_chain
    {A X I Y Canonical Obs : Type}
    {Good : A → Prop}
    {Q : I → Y → Prop}
    {Local : Nat → Prop}
    {Global T : Prop}
    {P : X → Prop}
    {f : X → X}
    {obs : X → Obs}
    (r : RealizationOperator A X)
    (u : UniformizationOperator I Y Q)
    (g : GlobalizationOperator Local Global)
    (b : EndpointBridge Unit (fun _ => Global) T)
    (z : IdentificationOperator X Canonical)
    (p : PreservationOperator X P f)
    (inv : InvarianceOperator X Obs obs f)
    (a : A)
    (ha : Good a)
    (realized_has_P : ∀ x, r.project x = a → P x) :
    ∃ x : X,
      r.project x = a ∧
      Good (r.project x) ∧
      ∃ F : I → Y,
        (∀ i, Q i (F i)) ∧
        T ∧
        ∃ c : Canonical,
          z.realize c = x ∧
          P (f x) ∧
          obs (f x) = obs x := by
  obtain ⟨x, hx, hgood, F, hF, hT⟩ :=
    rncb_chain_closes r u g b a ha
  have hxP : P x := realized_has_P x hx
  obtain ⟨c, hc, hPf, hInv⟩ :=
    zpi_chain_closes z p inv x hxP
  exact ⟨x, hx, hgood, F, hF, hT, c, hc, hPf, hInv⟩

end AxiomaticMillenium
