import Lake
open Lake DSL

package harappan where
  leanOptions := #[
    ⟨`pp.unicode.fun, true⟩,
    ⟨`autoImplicit, false⟩
  ]

@[default_target]
lean_lib Harappan where
  srcDir := "src/lean"
  roots := #[`Harappan.BasicTypes, `Harappan.SignSet, `Harappan.Phonology, 
             `Harappan.Phonotactics, `Harappan.Semantics, `Harappan.CollapseAxioms,
             `Harappan.ConsistencyTheorems, `Harappan.UniversalGrammar]
