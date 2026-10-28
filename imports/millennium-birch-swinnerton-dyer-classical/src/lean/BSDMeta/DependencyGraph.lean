/-
Copyright (c) 2025 BSD Formalization Project. All rights reserved.
Released under MIT license as described in the file LICENSE.
Authors: BSD Formalization Team
-/

/-!
# Dependency Graph

Tracking dependencies between modules.

## References

* See: `docs/08-proof-architecture/dependency-graph.md`
-/

namespace BSD.Meta

/-!
## Module Dependencies

This file tracks the dependency structure of the BSD formalization.
-/

/-!
## Status Tracking

Track which modules are:
- Complete
- In progress
- Not started
-/

/-- Status of a module -/
inductive ModuleStatus where
  | complete : ModuleStatus
  | inProgress : ModuleStatus
  | notStarted : ModuleStatus
  | axiom : ModuleStatus  -- Taken as established result

end BSD.Meta
