/-!
  Abstract instability scheme: approximate eigenvectors breaking coercivity.
-/
namespace LcRh
namespace AnalysisKernel

structure InstabilityWitness where
  sequence : Nat → Type
  boundFails : Prop

end AnalysisKernel
end LcRh
