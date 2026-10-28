import SPMG.Core

namespace SPMG

/-- An observer reads states from a geometry. -/
structure Observer (M : GeometryModel) where
  read : M.Geometry → M.State → M.State

/-- Two observers are operationally equivalent on a state when they return the same state. -/
def ObserverEquivalentOn
    {M : GeometryModel}
    (A B : Observer M) (g : M.Geometry) (s : M.State) : Prop :=
  A.read g s = B.read g s

theorem observer_equivalence_refl
    {M : GeometryModel}
    (A : Observer M) (g : M.Geometry) (s : M.State) :
    ObserverEquivalentOn A A g s := by
  rfl

theorem observer_equivalence_symm
    {M : GeometryModel}
    {A B : Observer M} {g : M.Geometry} {s : M.State}
    (h : ObserverEquivalentOn A B g s) :
    ObserverEquivalentOn B A g s := by
  exact h.symm

theorem observer_equivalence_trans
    {M : GeometryModel}
    {A B C : Observer M} {g : M.Geometry} {s : M.State}
    (hAB : ObserverEquivalentOn A B g s)
    (hBC : ObserverEquivalentOn B C g s) :
    ObserverEquivalentOn A C g s := by
  exact hAB.trans hBC

#print axioms observer_equivalence_refl
#print axioms observer_equivalence_symm
#print axioms observer_equivalence_trans

end SPMG
