/-
Copyright (c) 2025 BSD Formalization Project. All rights reserved.
Released under MIT license as described in the file LICENSE.
Authors: BSD Formalization Team
-/

/-!
# Height Pairings in Cohomology

Connection between heights and cohomological structures.

## References

* See: `docs/05-cohomology-selmer-sha/regulators-and-height-pairings.md`
-/

namespace BSD.Cohomology

/-!
## Height Pairing

The Néron-Tate height pairing:
⟨P, Q⟩ = ½(ĥ(P+Q) - ĥ(P) - ĥ(Q))

This is used to define the regulator.
-/

-- TODO: Connect to EllipticCurve/Heights.lean

/-!
## Regulator

Reg_E = det(⟨P_i, P_j⟩)

for a basis {P_1, ..., P_r} of E(K)/E(K)_tors.
-/

-- TODO: Define regulator

/-!
## TODO

- [ ] Import height definitions
- [ ] Define regulator
- [ ] Prove well-definedness
-/

end BSD.Cohomology
