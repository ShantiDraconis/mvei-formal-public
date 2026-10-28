/-
Copyright (c) 2025 BSD Formalization Project. All rights reserved.
Released under MIT license as described in the file LICENSE.
Authors: BSD Formalization Team
-/

/-!
# Reduction of Elliptic Curves

Reduction of elliptic curves modulo primes.

## Main Definitions

* `ReductionType` - Good, multiplicative, additive
* `hasGoodReduction` - Predicate for good reduction at p
* `Tamagawa` - Tamagawa numbers c_p

## References

* See: `docs/02-elliptic-curves/reduction-mod-p.md`
-/

namespace BSD.EllipticCurve

/-!
## Reduction Types

An elliptic curve E/ℚ can have different reduction types at each prime p.
-/

/-- The type of reduction at a prime -/
inductive ReductionType where
  | good : ReductionType
  | splitMultiplicative : ReductionType
  | nonsplitMultiplicative : ReductionType
  | additive : ReductionType

/-!
## Minimal Models

A minimal model at p has v_p(Δ) minimal among all integral models.
-/

-- TODO: Define minimal models

/-!
## a_p Coefficient

For good reduction at p:
  a_p = p + 1 - |E(𝔽_p)|

For bad reduction, a_p ∈ {-1, 0, 1}.
-/

-- TODO: Define a_p

/-!
## Tamagawa Numbers

c_p = [E(ℚ_p) : E_0(ℚ_p)]

These appear in the BSD formula.
-/

-- TODO: Define Tamagawa numbers

/-!
## TODO

- [ ] Define minimal models
- [ ] Define reduction types precisely
- [ ] Compute Tamagawa numbers
-/

end BSD.EllipticCurve
