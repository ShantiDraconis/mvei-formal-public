/-
  Catalogo.lean — reformulacoes/SemanticaMishkan (MVEI; NÃO é do autor). Gerado por tools/semantica_mishkan.py a partir do
  mesmo texto da camada de nomes de mishkan-iii-core (core/MveiEstrutura/Mishkan.lean).

  Cópia literal das estruturas do catálogo do autor (core/archaeology/HARAPPA_CATALOG.lean): SignCategory, HarappaSign e o primeiro sinal.
-/
import Mathlib.Data.List.Basic
import Mathlib.Data.Nat.Basic

set_option autoImplicit false

namespace HarappaCatalog

inductive SignCategory
  | Numeric : SignCategory
  | Logical : SignCategory
  | Geometric : SignCategory
  | Biological : SignCategory
  | Astronomical : SignCategory
  | Architectural : SignCategory
  | Symbolic : SignCategory
  | Compound : SignCategory

structure HarappaSign where
  index : Nat
  visual_description : String
  frequency : Nat  -- Número de ocorrências conhecidas
  category : SignCategory
  logical_interpretation : String
  modern_equivalent : String
  evidence : String
  archaeological_sites : List String

def sign_001 : HarappaSign := {
  index := 1,
  visual_description := "Single vertical stroke",
  frequency := 1247,
  category := SignCategory.Numeric,
  logical_interpretation := "Unity, universal quantifier (∀)",
  modern_equivalent := "∀ (for all)",
  evidence := "Appears at beginning of many inscriptions, suggesting universal scope",
  archaeological_sites := ["Harappa", "Mohenjo-daro", "Dholavira"]
}

end HarappaCatalog
