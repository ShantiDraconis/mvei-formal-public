/-
  ContraC.lean — reformulacoes/SemanticaMishkan (MVEI; NÃO é do autor). Gerado por tools/semantica_mishkan.py a partir do
  mesmo texto da camada de nomes de mishkan-iii-core (core/MveiEstrutura/Mishkan.lean).

  Contramodelo C: `yeshu_lineage : Lineage` só afirma que o tipo opaco Lineage tem um elemento; com Lineage vazio é falso.
-/
set_option autoImplicit false

namespace MveiContraC.Mishkan.Timeline

def Lineage : Type := Empty

theorem falha_yeshu_lineage : ¬ Nonempty Lineage := fun ⟨l⟩ => Empty.elim l

end MveiContraC.Mishkan.Timeline
