import AxiomaticMillenium.TaxonomyBoundary

namespace AxiomaticMillenium

/--
One terminal lane: a concrete producer type together with the exact proposition
that the producer closes.

This structure does not assert that the producer is inhabited.
-/
structure TerminalLane where
  Producer : Type
  Target : Prop
  closes : Producer → Target

namespace TerminalLane

theorem closes_of_inhabited (L : TerminalLane) (h : Nonempty L.Producer) :
    L.Target := by
  rcases h with ⟨p⟩
  exact L.closes p

end TerminalLane

/--
Seven-lane terminal system.

The lane names are organizational only.  Each lane carries its own concrete
producer type and exact terminal target.  The final root is assembled only
after all seven lane targets have been discharged.
-/
structure SevenTerminalSystem where
  rh : TerminalLane
  pvsnp : TerminalLane
  yangMills : TerminalLane
  hodge : TerminalLane
  bsd : TerminalLane
  beal : TerminalLane
  navierStokes : TerminalLane

  FinalRoot : Prop
  assemble :
    rh.Target →
    pvsnp.Target →
    yangMills.Target →
    hodge.Target →
    bsd.Target →
    beal.Target →
    navierStokes.Target →
    FinalRoot

/--
The exact aggregate inhabitant payload.  No lane can be omitted and no
terminal proposition is assumed directly.
-/
structure SevenTerminalInhabitants (S : SevenTerminalSystem) where
  rh : Nonempty S.rh.Producer
  pvsnp : Nonempty S.pvsnp.Producer
  yangMills : Nonempty S.yangMills.Producer
  hodge : Nonempty S.hodge.Producer
  bsd : Nonempty S.bsd.Producer
  beal : Nonempty S.beal.Producer
  navierStokes : Nonempty S.navierStokes.Producer

/--
Universal terminal composition theorem.

This theorem is deliberately fail-closed: it cannot manufacture any of the
seven inhabitants.  It only proves that once each producer is genuinely
constructed, every lane target and the final root follow without further
open wiring.
-/
theorem universal_terminal_composition
    (S : SevenTerminalSystem)
    (H : SevenTerminalInhabitants S) :
    S.FinalRoot := by
  exact S.assemble
    (S.rh.closes_of_inhabited H.rh)
    (S.pvsnp.closes_of_inhabited H.pvsnp)
    (S.yangMills.closes_of_inhabited H.yangMills)
    (S.hodge.closes_of_inhabited H.hodge)
    (S.bsd.closes_of_inhabited H.bsd)
    (S.beal.closes_of_inhabited H.beal)
    (S.navierStokes.closes_of_inhabited H.navierStokes)

/--
External certificate payload.  The root itself is stored as data, together
with the exact aggregate producer evidence that generated it.
-/
structure ExternalCertificate (S : SevenTerminalSystem) where
  inhabitants : SevenTerminalInhabitants S
  root : S.FinalRoot

/--
No separate mathematical gap exists between the seven terminal inhabitants
and an external certificate.
-/
def external_certificate_of_inhabitants
    (S : SevenTerminalSystem)
    (H : SevenTerminalInhabitants S) :
    ExternalCertificate S :=
  { inhabitants := H
    root := universal_terminal_composition S H }

/--
Conversely, an external certificate cannot exist without the complete
seven-lane inhabitant payload.
-/
theorem external_certificate_requires_all
    {S : SevenTerminalSystem}
    (C : ExternalCertificate S) :
    SevenTerminalInhabitants S :=
  C.inhabitants

/--
A lane-specific falsification closes only the falsified formulation.  It
cannot synthesize a positive producer for a terminal lane.
-/
theorem falsification_is_route_local
    {S : Prop}
    (f : FalsifiedFormulation S) :
    ¬ S :=
  F_firewall f

#print axioms AxiomaticMillenium.TerminalLane.closes_of_inhabited
#print axioms AxiomaticMillenium.universal_terminal_composition
#print axioms AxiomaticMillenium.external_certificate_of_inhabitants
#print axioms AxiomaticMillenium.external_certificate_requires_all
#print axioms AxiomaticMillenium.falsification_is_route_local

end AxiomaticMillenium
