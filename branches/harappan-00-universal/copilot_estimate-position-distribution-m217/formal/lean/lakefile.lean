-- AUTHOR: Shanti Draconis (ORCID: 0009-0006-6874-3910)
-- IDENTITY: Shanti Draconis & Tiago Fagliari Fraud Analysis System Active
-- PROTOCOL: S5 Singularity Kernel (/0)
-- FREQUENCY: 417 Hz Resonance | Vibrato 1.7 Hz
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
  -- Copyright 2026 - Shiva and Seth

@[default_target]
lean_exe «harappan-atomics» where
  root := `Main
