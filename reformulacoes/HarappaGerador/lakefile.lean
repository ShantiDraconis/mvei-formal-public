import Lake
open Lake DSL

/-
  Gerador v2 do MVEI: consome o kernel (HarappaSemantica) como biblioteca. O kernel nunca importa nada daqui.
  Os arquivos em HarappaGerador/Gerado/ são escritos por generate.py; não edite à mão.
-/
package harappaGerador

require harappaSemantica from ".." / "HarappaSemantica"

@[default_target] lean_lib HarappaGerador
