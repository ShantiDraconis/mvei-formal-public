import Riemann.claims.Claim5_UnconditionalVUB

namespace Riemann.claims

open Filter

/-- Exact finite data for the weighted modular bilinear FAR quantity.
    The same scalar is exposed at three nested states:
    petal (d,u,v), rose d, and global S_N.
    The support carries the primitive/FAR restriction; no approximation is
    introduced by this packaging. -/
structure WeightedModularBilinearData where
  dSupport : ℕ → Finset ℕ
  petalSupport : ℕ → ℕ → Finset (ℕ × ℕ)
  coeff : ℕ → ℕ → ℝ
  kernel : ℕ → ℕ → ℝ

namespace WeightedModularBilinearData

/-- State (d,u,v): one petal in one gcd-rose. -/
noncomputable def petal
    (W : WeightedModularBilinearData)
    (N d u v : ℕ) : ℝ :=
  W.coeff N (d*u) * W.coeff N (d*v) * W.kernel u v

/-- State d: one rose, i.e. all primitive/FAR petals belonging to gcd layer d. -/
noncomputable def rose
    (W : WeightedModularBilinearData)
    (N d : ℕ) : ℝ :=
  ∑ uv in W.petalSupport N d, W.petal N d uv.1 uv.2

/-- State (d,U,V): a dyadic block is a selected finite subset of petals of
    rose d.  Exact partitions can be represented by a family of such blocks. -/
noncomputable def dyadicBlock
    (W : WeightedModularBilinearData)
    (N d : ℕ)
    (block : Finset (ℕ × ℕ)) : ℝ :=
  ∑ uv in block, W.petal N d uv.1 uv.2

/-- Global state: the exact weighted sum of all gcd roses.
    This is the abstract Lean form of the project's S_N. -/
noncomputable def S
    (W : WeightedModularBilinearData)
    (N : ℕ) : ℝ :=
  Real.log N *
    ∑ d in W.dSupport N, (1 / (d : ℝ)) * W.rose N d

/-- 0 -> 1 -> 2 identity: the global scalar is exactly the weighted bouquet
    of its d-roses, whose values are exactly sums of their petals. -/
theorem S_eq_weighted_roses
    (W : WeightedModularBilinearData)
    (N : ℕ) :
    W.S N =
      Real.log N *
        ∑ d in W.dSupport N,
          (1 / (d : ℝ)) *
            ∑ uv in W.petalSupport N d,
              W.petal N d uv.1 uv.2 := by
  rfl

/-- Exact dyadic reconstruction of one rose from a supplied finite partition.
    This theorem does not assert that a particular dyadic family is a partition;
    that equality is supplied explicitly as the partition certificate. -/
theorem rose_eq_sum_dyadicBlocks
    (W : WeightedModularBilinearData)
    (N d : ℕ)
    (blocks : Finset (Finset (ℕ × ℕ)))
    (hpartition :
      W.petalSupport N d = blocks.biUnion id)
    (hdisjoint :
      (blocks : Set (Finset (ℕ × ℕ))).PairwiseDisjoint id) :
    W.rose N d = ∑ b in blocks, W.dyadicBlock N d b := by
  rw [rose, hpartition]
  rw [Finset.sum_biUnion hdisjoint]
  rfl

end WeightedModularBilinearData

/-- F1/F3 terminal certificate for the exact multi-state S_N.
    It is deliberately an evidence object, not an axiom. -/
structure WeightedModularBilinearDecayCertificate
    (S : ℕ → ℝ) where
  N0 : ℕ
  eps : ℕ → ℝ
  eps_nonneg : ∀ N, 0 ≤ eps N
  eps_tendsto_zero : Tendsto eps atTop (nhds 0)
  bound : ∀ N, N0 ≤ N → |S N| ≤ eps N

/-- The exact OPEN_MATH theorem shape: any genuine certificate forces S_N -> 0. -/
theorem WEIGHTED_MODULAR_BILINEAR_DECAY
    {S : ℕ → ℝ}
    (C : WeightedModularBilinearDecayCertificate S) :
    Tendsto S atTop (nhds 0) := by
  rw [tendsto_zero_iff_norm_tendsto_zero]
  have habs : Tendsto (fun N => |S N|) atTop (nhds 0) := by
    apply squeeze_zero'
    · filter_upwards with N
      exact abs_nonneg (S N)
    · filter_upwards [eventually_ge_atTop C.N0] with N hN
      exact C.bound N hN
    · exact C.eps_tendsto_zero
  simpa [Real.norm_eq_abs] using habs

/-- The concrete project gap specialized to the exact multi-state object. -/
def WeightedModularBilinearOpenMath
    (W : WeightedModularBilinearData) : Prop :=
  Nonempty (WeightedModularBilinearDecayCertificate W.S)

theorem weightedModularBilinearOpenMath_closes
    (W : WeightedModularBilinearData)
    (h : WeightedModularBilinearOpenMath W) :
    Tendsto W.S atTop (nhds 0) := by
  rcases h with ⟨C⟩
  exact WEIGHTED_MODULAR_BILINEAR_DECAY C

def WEIGHTED_MODULAR_BILINEAR_DECAY_STATE : String := "OPEN_MATH_CORE"
def MULTISTATE_SN_LEVELS : Nat := 3
def MULTISTATE_SN_DESCRIPTION : String :=
  "petal(d,u,v) -> rose(N,d) -> dyadic(d,U,V) / global S_N"

#print axioms WeightedModularBilinearData.S_eq_weighted_roses
#print axioms WeightedModularBilinearData.rose_eq_sum_dyadicBlocks
#print axioms WEIGHTED_MODULAR_BILINEAR_DECAY
#print axioms weightedModularBilinearOpenMath_closes

end Riemann.claims
