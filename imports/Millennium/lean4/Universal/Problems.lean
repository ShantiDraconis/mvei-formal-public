-- Universal/Problems.lean
import Universal.Basics
import Universal.Domains

namespace Universal

/-- Um "Problema" como a estrutura interna Fᵢ (domínio + alguma marcação). -/
structure Problem where
  domain : MathDomain
  name   : String

/-- Família dos 14 problemas do tipo Millennium + complementos. -/
structure ProblemFamily where
  RH       : Problem
  NS       : Problem
  YM       : Problem
  FA       : Problem
  OD       : Problem
  Hodge    : Problem
  Poincare : Problem
  AlgTop   : Problem
  DiffGeom : Problem
  BSD      : Problem
  ANT      : Problem
  AA       : Problem
  PvsNP    : Problem
  CompLog  : Problem

/-- Category-like structure: aqui, os morphisms são morphisms de domínios
    que preservam a estrutura local/global. -/
structure ProblemMorphism (P Q : Problem) where
  mor : Morphism P.domain Q.domain

end Universal
