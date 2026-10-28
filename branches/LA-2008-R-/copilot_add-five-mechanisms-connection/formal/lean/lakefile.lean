-- Lean 4 project file
import Lake
open Lake DSL

package RHConnections where
  name := "RHConnections"

lean_lib RHConnections where
  roots := #[`RHConnections]
