import AxiomaticMillenium.RootContract
import AxiomaticMillenium.OpenObligation

namespace AxiomaticMillenium

/-- Exact upstream bridge obligation: the abstract interface and the fixed
official P/NP predicates share one language universe, and both predicates
must agree pointwise. -/
structure OfficialModelMatch
    (M : PvsNPOfficialModel)
    (officialP officialNP : M.Language → Prop) : Prop where
  p_match : ∀ L, M.officialP L ↔ officialP L
  np_match : ∀ L, M.officialNP L ↔ officialNP L

theorem official_model_match_transfers_separation
    {M : PvsNPOfficialModel}
    {officialP officialNP : M.Language → Prop}
    (m : OfficialModelMatch M officialP officialNP)
    (h : pvsnpSeparationStatement M) :
    ¬ ∀ L, officialP L ↔ officialNP L := by
  intro hEq
  apply h
  intro L
  exact (m.p_match L).trans ((hEq L).trans (m.np_match L).symm)

/-- Exact proof-search target for the third P-vs-NP frontier atom. -/
def officialModelMatchObligation
    (M : PvsNPOfficialModel)
    (officialP officialNP : M.Language → Prop) : OpenObligation :=
  { id := "ExternalModelMatch"
    target := OfficialModelMatch M officialP officialNP
    source := "m-core-p-vs-np/audit/repro_PNP.lean + Cook/Clay official P-vs-NP definitions" }

structure PvsNPFrontierInputs where
  p01 : Prop
  p02 : Prop
  externalModelMatch : Prop

structure PvsNPClosureWitness
    (M : PvsNPOfficialModel)
    (I : PvsNPFrontierInputs) where
  compose :
    I.p01 →
    I.p02 →
    I.externalModelMatch →
    pvsnpSeparationStatement M

def pvsnpP01Key : AtomKey := 1
def pvsnpP02Key : AtomKey := 2
def pvsnpExternalModelKey : AtomKey := 3

def pvsnpAtomSpace (I : PvsNPFrontierInputs) : AtomSpace :=
  { term := fun k =>
      if k = pvsnpP01Key then I.p01
      else if k = pvsnpP02Key then I.p02
      else if k = pvsnpExternalModelKey then I.externalModelMatch
      else False }

def pvsnpCandidateFrontier : Frontier :=
  { atoms := [pvsnpP01Key, pvsnpP02Key, pvsnpExternalModelKey]
    nodup := by decide }

def pvsnpRootContract
    (M : PvsNPOfficialModel)
    (I : PvsNPFrontierInputs)
    (W : PvsNPClosureWitness M I) :
    RootContract :=
  { root := pvsnpFrozenRoot M
    atomSpace := pvsnpAtomSpace I
    closureSchema := fun f => f.atoms = pvsnpCandidateFrontier.atoms
    closureSound := by
      intro f hAtoms hSchema
      have hp01 : I.p01 := by
        have h := hAtoms pvsnpP01Key
        have hm : pvsnpP01Key ∈ f.atoms := by
          rw [hSchema]
          simp [pvsnpCandidateFrontier, pvsnpP01Key]
        simpa [pvsnpAtomSpace, pvsnpP01Key, pvsnpP02Key,
          pvsnpExternalModelKey] using h hm
      have hp02 : I.p02 := by
        have h := hAtoms pvsnpP02Key
        have hm : pvsnpP02Key ∈ f.atoms := by
          rw [hSchema]
          simp [pvsnpCandidateFrontier, pvsnpP02Key]
        simpa [pvsnpAtomSpace, pvsnpP01Key, pvsnpP02Key,
          pvsnpExternalModelKey] using h hm
      have hext : I.externalModelMatch := by
        have h := hAtoms pvsnpExternalModelKey
        have hm : pvsnpExternalModelKey ∈ f.atoms := by
          rw [hSchema]
          simp [pvsnpCandidateFrontier, pvsnpExternalModelKey]
        simpa [pvsnpAtomSpace, pvsnpP01Key, pvsnpP02Key,
          pvsnpExternalModelKey] using h hm
      exact W.compose hp01 hp02 hext }

/-- Conditional EGC constructor.  It proves only that if all three frontier
atoms are supplied, the frozen root follows through the explicit compose term. -/
def pvsnpConditionalEGC
    (M : PvsNPOfficialModel)
    (I : PvsNPFrontierInputs)
    (W : PvsNPClosureWitness M I) :
    ConditionalExternalGlobalCertificate (pvsnpRootContract M I W) :=
  { frontier := pvsnpCandidateFrontier
    schema := rfl
    directDeps := []
    metadataFingerprint := "PVSNP-CONDITIONAL-EGC-v1" }

end AxiomaticMillenium
