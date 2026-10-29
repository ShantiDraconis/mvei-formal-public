import Lake
open Lake DSL

package MetaMillennium where
  leanOptions := #[
    ⟨`pp.unicode.fun, true⟩,
    ⟨`autoImplicit, false⟩
  ]

@[default_target]
lean_lib MetaMillennium where
  srcDir := "."
