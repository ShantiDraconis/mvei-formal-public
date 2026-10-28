/-
Copyright (c) 2025 BSD Formalization Project. All rights reserved.
Released under MIT license as described in the file LICENSE.
Authors: BSD Formalization Team
-/

/-!
# Newforms

Newforms and the Atkin-Lehner theory.

## Main Definitions

* `Newform` - A normalized eigenform in the new subspace
* `isNewform` - Predicate for newforms

## References

* See: `docs/03-modular-forms-and-modularity/hecke-operators-and-eigenforms.md`
-/

namespace BSD.ModularForms

/-!
## Old and New Subspaces

Old forms come from lower levels.
New forms are orthogonal to old forms.
-/

-- TODO: Define old/new subspaces

/-!
## Newforms

A newform is a normalized eigenform in the new subspace.
-/

/-- Placeholder for newform structure -/
structure Newform (N : ℕ) where
  -- Level
  level : ℕ := N
  -- TODO: Add actual definition
  mk ::

/-!
## TODO

- [ ] Define old forms
- [ ] Define new subspace
- [ ] Prove multiplicity one
-/

end BSD.ModularForms
