/-
AxiomGate stub for the operational Weil Explicit Formula. This keeps the spec
core frozen while backends supply compatible realizations.
-/
namespace LcRh.AxiomGates

/-!
`WeilExplicitGate` acts as a placeholder axiom that downstream backends can
refine. It is intentionally minimal to avoid premature commitments.
-/
axiom WeilExplicitGate : Prop

/- The gate is linked to trivial-term cancellation on BT. -/
axiom TrivialTermsNormalized : Prop

end LcRh.AxiomGates
