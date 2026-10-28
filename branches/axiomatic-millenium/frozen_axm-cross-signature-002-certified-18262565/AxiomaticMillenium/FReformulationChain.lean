import AxiomaticMillenium.PositiveClosureChain

namespace AxiomaticMillenium

/--
A falsified formulation is permanently closed as an old route.
A replacement route is logically independent and must supply its own new premise.

This structure does not infer `New` from `¬ Old`.
-/
structure ReformulationRoute (Old New Target : Prop) where
  oldClosed : ¬ Old
  replacementSound : New → Target

theorem falsified_route_stays_closed
    {Old New Target : Prop}
    (r : ReformulationRoute Old New Target) :
    ¬ Old :=
  r.oldClosed

theorem replacement_route_closes_only_from_new
    {Old New Target : Prop}
    (r : ReformulationRoute Old New Target)
    (hNew : New) :
    Target :=
  r.replacementSound hNew

/--
Integration law for F:
- the old formulation remains refuted;
- closure can continue only through an independently supplied replacement.
-/
theorem f_reformulation_chain
    {Old New Target : Prop}
    (r : ReformulationRoute Old New Target)
    (hNew : New) :
    (¬ Old) ∧ Target :=
  ⟨r.oldClosed, r.replacementSound hNew⟩

end AxiomaticMillenium
