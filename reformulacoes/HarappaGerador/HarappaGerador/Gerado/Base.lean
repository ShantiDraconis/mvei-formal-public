/-
  Gerado por reformulacoes/HarappaGerador/generate.py (MVEI). Não edite à mão.
  Definições usadas pelos arquivos gerados (nenhum axioma).
-/
import HarappaSemantica.Semantica

namespace HarappaGerador
open HarappaSemantica HarappaCatalog V3

/-- Implicação e equivalência de Kleene, exatamente como `binario` do kernel as dá aos sinais 3 e 73. -/
def imp (a b : V3) : V3 := disj (neg a) b
def equiv (a b : V3) : V3 := conj (imp a b) (imp b a)
/-- Refinamento: `i` refina para qualquer valor; um valor determinado só para ele mesmo. -/
def ref : V3 → V3 → Bool
  | .i, _ => true
  | x, y => x == y


end HarappaGerador
