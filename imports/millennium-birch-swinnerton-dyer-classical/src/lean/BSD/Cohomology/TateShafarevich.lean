/-
Copyright (c) 2025 BSD Formalization Project. All rights reserved.
Released under MIT license as described in the file LICENSE.
Authors: BSD Formalization Team
-/

/-!
# Tate-Shafarevich Group

The Tate-Shafarevich group Sha(E/K).

## Main Definitions

* `Sha` - The Tate-Shafarevich group
* `shaFinite` - Conjectured finiteness

## References

* See: `docs/05-cohomology-selmer-sha/tate-shafarevich-group.md`
-/

import BSD.Cohomology.SelmerGroups

namespace BSD.Cohomology

/-!
## Definition

Sha(E/K) = ker(H¹(K, E) → ∏_v H¹(K_v, E))

Elements are genus-1 curves with points everywhere locally.
-/

/-- Placeholder for Tate-Shafarevich group -/
structure Sha where
  -- TODO: Actual definition
  mk ::

/-!
## Conjectured Finiteness

BSD implies Sha is finite.
Known when r_{an} ≤ 1 (Kolyvagin).
-/

/-- Sha is conjectured to be finite -/
axiom sha_finite_conjecture : ∀ (E : Sha), True  -- TODO: Sha is finite

/-!
## Cassels-Tate Pairing

There is a pairing Sha × Sha → ℚ/ℤ which is:
- Alternating
- Non-degenerate (modulo divisibles)

This implies |Sha| is a perfect square.
-/

-- TODO: Define Cassels-Tate pairing

/-!
## TODO

- [ ] Define Sha properly
- [ ] State finiteness conjecture
- [ ] Define Cassels-Tate pairing
-/

end BSD.Cohomology
