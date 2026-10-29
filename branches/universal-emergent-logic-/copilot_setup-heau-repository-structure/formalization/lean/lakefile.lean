import Lake
open Lake DSL

package «HEAU» where
  moreLeanArgs := #["-DautoImplicit=false"]

lean_lib HEAU
