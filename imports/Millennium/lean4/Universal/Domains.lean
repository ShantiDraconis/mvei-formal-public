-- Universal/Domains.lean
import Universal.Basics

namespace Universal

/-- Identificadores simbólicos para os 14 domínios. -/
inductive DomainId
  | RH       -- Riemann Hypothesis
  | NS       -- Navier–Stokes
  | YM       -- Yang–Mills
  | FA       -- Functional Analysis
  | OD       -- Spectral Operators / Differential Operators
  | Hodge
  | Poincare
  | AlgTop
  | DiffGeom
  | BSD
  | AnalyticNT
  | AlgArithmetic
  | PvsNP
  | CompLogic
  deriving DecidableEq, Repr

open DomainId

/-- Estrutura que emparelha um `DomainId` com um `MathDomain`. -/
/-- Estrutura que emparelha um DomainId com um MathDomain. -/
structure LabeledDomain where
  id  : DomainId
  dom : MathDomain

/-- A família dos 14 domínios; aqui deixamos abstrata, para você
    depois instanciar com modelos concretos (ou toy models). -/
structure DomainFamily where
  RH_dom       : MathDomain
  NS_dom       : MathDomain
  YM_dom       : MathDomain
  FA_dom       : MathDomain
  OD_dom       : MathDomain
  Hodge_dom    : MathDomain
  Poincare_dom : MathDomain
  AlgTop_dom   : MathDomain
  DiffGeom_dom : MathDomain
  BSD_dom      : MathDomain
  ANT_dom      : MathDomain
  AA_dom       : MathDomain
  PvsNP_dom    : MathDomain
  CompLog_dom  : MathDomain

/-- Lista dos 14 domínios rotulados. -/
def DomainFamily.toList (F : DomainFamily) : List LabeledDomain :=
  [ ⟨RH,       F.RH_dom⟩
  , ⟨NS,       F.NS_dom⟩
  , ⟨YM,       F.YM_dom⟩
  , ⟨FA,       F.FA_dom⟩
  , ⟨OD,       F.OD_dom⟩
  , ⟨Hodge,    F.Hodge_dom⟩
  , ⟨Poincare, F.Poincare_dom⟩
  , ⟨AlgTop,   F.AlgTop_dom⟩
  , ⟨DiffGeom, F.DiffGeom_dom⟩
  , ⟨BSD,      F.BSD_dom⟩
  , ⟨AnalyticNT, F.ANT_dom⟩
  , ⟨AlgArithmetic, F.AA_dom⟩
  , ⟨PvsNP,    F.PvsNP_dom⟩
  , ⟨CompLogic, F.CompLog_dom⟩
  [
    ⟨RH, F.RH_dom⟩,
    ⟨NS, F.NS_dom⟩,
    ⟨YM, F.YM_dom⟩,
    ⟨FA, F.FA_dom⟩,
    ⟨OD, F.OD_dom⟩,
    ⟨Hodge, F.Hodge_dom⟩,
    ⟨Poincare, F.Poincare_dom⟩,
    ⟨AlgTop, F.AlgTop_dom⟩,
    ⟨DiffGeom, F.DiffGeom_dom⟩,
    ⟨BSD, F.BSD_dom⟩,
    ⟨AnalyticNT, F.ANT_dom⟩,
    ⟨AlgArithmetic, F.AA_dom⟩,
    ⟨PvsNP, F.PvsNP_dom⟩,
    ⟨CompLogic, F.CompLog_dom⟩
  ]

end Universal
