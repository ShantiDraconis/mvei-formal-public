import TState.Endpoint

namespace TState

theorem exhaustive_iff_no_gap
    (P : ProblemSpec) (D : EndpointPartition P) :
    Exhaustive P D ↔ ¬ Nonempty (GapWitness P D) := by
  constructor
  · intro hex hgap
    rcases hgap with ⟨w⟩
    exact (gapWitness_refutes_exhaustive P D w) hex
  · intro hnogap s hs
    by_cases hp : D.positive s
    · exact Or.inl hp
    · by_cases hn : D.negative s
      · exact Or.inr hn
      · exfalso
        apply hnogap
        exact ⟨{
          state := s
          admissible := hs
          notPositive := hp
          notNegative := hn
        }⟩

theorem exclusive_iff_no_overlap
    (P : ProblemSpec) (D : EndpointPartition P) :
    Exclusive P D ↔ ¬ Nonempty (OverlapWitness P D) := by
  constructor
  · intro hexc hoverlap
    rcases hoverlap with ⟨w⟩
    exact (overlapWitness_refutes_exclusive P D w) hexc
  · intro hno s hs hboth
    apply hno
    exact ⟨{
      state := s
      admissible := hs
      positive := hboth.1
      negative := hboth.2
    }⟩

/-- Central characterization theorem for T:
endpoint validity is equivalent to absence of gap and overlap witnesses,
together with semantic adequacy. -/
theorem validEndpoint_iff_witness_free_adequate
    (P : ProblemSpec) (D : EndpointPartition P) :
    ValidEndpoint P D ↔
      (¬ Nonempty (GapWitness P D)) ∧
      (¬ Nonempty (OverlapWitness P D)) ∧
      Adequate P D := by
  constructor
  · intro h
    exact ⟨
      (exhaustive_iff_no_gap P D).mp h.1,
      (exclusive_iff_no_overlap P D).mp h.2.1,
      h.2.2
    ⟩
  · rintro ⟨hgap, hoverlap, hadeq⟩
    exact ⟨
      (exhaustive_iff_no_gap P D).mpr hgap,
      (exclusive_iff_no_overlap P D).mpr hoverlap,
      hadeq
    ⟩

end TState
