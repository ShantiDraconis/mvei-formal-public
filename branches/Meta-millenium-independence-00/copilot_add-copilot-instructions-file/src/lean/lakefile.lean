import Lake
open Lake DSL

package MetaMillennium where
  -- Settings for the package

@[default_target]
lean_lib MetaMillennium where
  -- Library configuration
  roots := #[`MetaMillennium]
