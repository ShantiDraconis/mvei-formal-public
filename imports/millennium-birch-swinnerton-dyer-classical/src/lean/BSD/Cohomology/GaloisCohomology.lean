/-
Copyright (c) 2025 BSD Formalization Project. All rights reserved.
Released under MIT license as described in the file LICENSE.
Authors: BSD Formalization Team
-/

/-!
# Galois Cohomology

Galois cohomology for the BSD formalization.

## Main Definitions

* `H1` - First Galois cohomology H¹(G, M)
* `longExactSequence` - The long exact sequence

## References

* See: `docs/05-cohomology-selmer-sha/galois-cohomology-basics.md`
-/

namespace BSD.Cohomology

/-!
## Group Cohomology

H^n(G, M) for a group G acting on module M.
-/

-- TODO: Define group cohomology

/-!
## Galois Cohomology

For K a field with absolute Galois group G_K:
H^n(K, M) := H^n(G_K, M)
-/

-- TODO: Define Galois cohomology

/-!
## Long Exact Sequence

For 0 → A → B → C → 0:
... → H^n(G, A) → H^n(G, B) → H^n(G, C) → H^{n+1}(G, A) → ...
-/

-- TODO: Define and prove long exact sequence

/-!
## TODO

- [ ] Define group cohomology
- [ ] Specialize to Galois cohomology
- [ ] Prove key exact sequences
-/

end BSD.Cohomology
