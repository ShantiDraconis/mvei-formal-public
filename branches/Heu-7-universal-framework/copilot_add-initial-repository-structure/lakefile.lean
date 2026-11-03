import Lake
open Lake DSL

package HEU7 where
  -- Package configuration
  leanOptions := #[
    ⟨`pp.unicode.fun, true⟩
  ]

@[default_target]
lean_lib HEU where
  srcDir := "src/lean"
  roots := #[`HEU]
