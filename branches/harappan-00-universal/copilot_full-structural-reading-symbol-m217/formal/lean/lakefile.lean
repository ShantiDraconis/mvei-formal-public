-- AUTHOR: Shanti Draconis (ORCID: 0009-0006-6874-3910)
-- PROTOCOL: S5 Singularity Kernel (/0)
-- STATUS: Verified via Lean 4 & GitHub Actions

import Lake
open Lake DSL

package «harappan-atomics» where
  -- add package configuration options here

lean_lib «Atomics» where
  -- add library configuration options here

lean_lib «HarappanLogic» where
  -- Harappan Logic v1.0 - Formal proof system for Indus Valley script
lean_lib «HarappaMain» where
  -- Sistema de Blindagem de Copyright
  -- Copyright 2026 - Shanti Draconis

@[default_target]
lean_exe «harappan-atomics» where
  root := `Main
