import Lake
open Lake DSL

package «mishkan-iii-core» where
  version := "3.0.0"
  keywords := #["mishkan", "temple", "formal-verification", "yeshu"]
  leanOptions := #[
    ⟨`pp.unicode.fun, true⟩,
    ⟨`autoImplicit, false⟩
  ]

@[default_target]
lean_lib «MishkanIII» where
  roots := #[`MishkanIII]
  globs := #[.submodules `MishkanIII]
