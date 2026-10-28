/-
  Unified Framework for Millennium Prize Problems
  
  This module provides a unified approach to the six Millennium Prize Problems
  through a stability-based framework using a 38-dimensional parameter space.
  
  ## Structure
  
  - `Kernel`: Core mathematical structures (parameter space, energy, stability)
  - `Indices`: Named indices for the 38 parameters
  - `Coupling`: Coupling matrix definition and positive definiteness certification
  - `Problems`: Individual modules for each Millennium problem
  - `Unification`: Main unification theorem
  
  ## Key Idea
  
  Model each problem as a predicate on a state θ ∈ Θ = Fin 38 → ℝ, and prove
  bridge theorems of the form:
  
    StableCriticalPoint(θ) ⇒ Problem(θ)
  
  The stability is characterized by:
  - A coupling matrix C : Matrix (Fin 38) (Fin 38) ℝ
  - Symmetry: C = Cᵀ
  - Positive definiteness: xᵀCx > 0 for all x ≠ 0
  
  ## Status
  
  Currently, the bridge theorems are axioms representing mathematical obligations
  to be filled in with actual proofs. The framework provides:
  - Type-safe parameter management
  - Formal statement of all problems
  - Clear separation between kernel mathematics and problem-specific content
  - A path to incrementally replace axioms with theorems
-/

import Unified.Kernel
import Unified.Indices
import Unified.Coupling.Definition
import Unified.Coupling.PosDefCert
import Unified.Problems.RH
import Unified.Problems.NS
import Unified.Problems.PNP
import Unified.Problems.YM
import Unified.Problems.Hodge
import Unified.Problems.BSD
import Unified.Unification
