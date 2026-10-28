namespace FinalProof

/-
FAIL-CLOSED SCAFFOLD ONLY.

These are intentionally comments rather than Lean declarations.
Declaring them as axioms or theorems without proofs would violate the
strict kernel protocol.

Required real signatures, once the underlying mathematical types exist:

  theorem tvcon_implies_g21
      (t : TotalVariableCoverageObligationNorm) :
      P02Target_G21 t := by
    -- OPEN_MATH: real derivation required

  theorem g21_implies_certificate
      (t : TotalVariableCoverageObligationNorm) :
      FinalExternalCertificate t := by
    -- OPEN_MATH: real derivation required

  theorem final_root :
      FINAL_ROOT_STATEMENT := by
    -- OPEN_MATH: compose only kernel-checked predecessors

Until those declarations exist with actual proof terms, FINAL_ROOT is
not a theorem of this Lean environment.
-/

end FinalProof
