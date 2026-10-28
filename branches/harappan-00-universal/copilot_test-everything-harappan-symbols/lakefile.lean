import Lake
open Lake DSL

package harappan where
  leanOptions := #[
    ⟨`autoImplicit, false⟩,
    ⟨`relaxedAutoImplicit, false⟩
  ]

@[default_target]
lean_lib Harappan where
  srcDir := "src/lean"
  roots := #[`Harappan.BasicTypes, `Harappan.SignSet, `Harappan.Phonology, 
             `Harappan.Phonotactics, `Harappan.Semantics, `Harappan.CollapseAxioms,
             `Harappan.ConsistencyTheorems, `Harappan.UniversalGrammar]
