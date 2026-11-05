import Lake
open Lake DSL

package «mishkan-iii-core» where
  version := "0.1.0"

@[default_target]
lean_lib «MishkanIII» where
  roots := #[`MishkanIII]
