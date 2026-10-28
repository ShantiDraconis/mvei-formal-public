/-
Copyright (c) 2025 BSD Formalization Project. All rights reserved.
Released under MIT license as described in the file LICENSE.
Authors: BSD Formalization Team
-/

/-!
# Selmer Groups

Selmer groups for elliptic curves.

## Main Definitions

* `SelmerGroup` - The n-Selmer group Sel_n(E/K)
* `selmerFinite` - Sel_n is finite

## References

* See: `docs/05-cohomology-selmer-sha/selmer-groups-definition.md`
-/

import BSD.Cohomology.GaloisCohomology

namespace BSD.Cohomology

/-!
## Selmer Group Definition

Sel_n(E/K) = {ξ ∈ H¹(K, E[n]) : res_v(ξ) ∈ im(κ_v) for all v}

Elements satisfy local conditions at all places.
-/

/-- Placeholder for Selmer group -/
structure SelmerGroup (n : ℕ) where
  -- TODO: Actual definition with local conditions
  mk ::

/-!
## Properties

1. Sel_n is finite (uses finiteness of class group, etc.)
2. There is an exact sequence:
   0 → E(K)/nE(K) → Sel_n → Sha[n] → 0
-/

theorem selmer_finite (n : ℕ) : True := by  -- TODO: Sel_n is finite
  trivial

/-!
## TODO

- [ ] Define Selmer group with local conditions
- [ ] Prove finiteness
- [ ] Construct exact sequence with Sha
-/

end BSD.Cohomology
