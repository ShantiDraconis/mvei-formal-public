/-
  Gerado por reformulacoes/HarappaGerador/generate.py (MVEI). Não edite à mão.
  Como o kernel lê os sinais conectivos do catálogo (3, 7, 11, 13, 73).
-/
import HarappaGerador.Gerado.Base

namespace HarappaGerador
open HarappaSemantica HarappaCatalog V3

/-- O sinal 3 do catálogo (→) é lido pelo kernel como `imp`. -/
theorem sinal_003_e_imp : semBin sign_003 = some imp := rfl

/-- O sinal 7 do catálogo (∧) é lido pelo kernel como `conj`. -/
theorem sinal_007_e_conj : semBin sign_007 = some conj := rfl

/-- O sinal 11 do catálogo (∨) é lido pelo kernel como `disj`. -/
theorem sinal_011_e_disj : semBin sign_011 = some disj := rfl

/-- O sinal 73 do catálogo (≡) é lido pelo kernel como `equiv`. -/
theorem sinal_073_e_equiv : semBin sign_073 = some equiv := rfl

/-- O sinal 13 do catálogo (¬) é lido pelo kernel como `neg`. -/
theorem sinal_013_e_neg : semUn sign_013 = some neg := rfl

end HarappaGerador
