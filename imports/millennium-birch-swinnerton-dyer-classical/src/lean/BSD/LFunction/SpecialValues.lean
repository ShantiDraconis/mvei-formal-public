/-
Copyright (c) 2025 BSD Formalization Project. All rights reserved.
Released under MIT license as described in the file LICENSE.
Authors: BSD Formalization Team
-/

/-!
# Special Values of L-functions

Values and derivatives at s = 1.

## Main Definitions

* `L_at_one` - L(E, 1)
* `analyticRank` - ord_{s=1} L(E, s)
* `leadingCoefficient` - L^*(E, 1)

## References

* See: `docs/04-l-functions/special-values-and-derivatives.md`
-/

import BSD.LFunction.FunctionalEquationAxioms

namespace BSD.LFunction

/-!
## Value at s = 1

L(E, 1) is the central value.
When r_{an} = 0, this is nonzero.
-/

-- TODO: Define L(E, 1)

/-!
## Order of Vanishing (Analytic Rank)

r_{an}(E) = ord_{s=1} L(E, s)
         = min{k : L^{(k)}(E, 1) ≠ 0}
-/

/-- The analytic rank of E -/
def analyticRank (E : LFunc) : ℕ :=
  0  -- TODO: Actual definition

/-!
## Leading Coefficient

L^*(E, 1) = lim_{s→1} L(E, s) / (s-1)^{r_{an}}

This is what appears in the BSD formula.
-/

-- TODO: Define leading coefficient

/-!
## BSD Connection

BSD says:
1. r_{an}(E) = rank(E(ℚ))
2. L^*(E, 1) = (Ω · Reg · ∏c_p · |Sha|) / |Tors|²
-/

/-!
## TODO

- [ ] Define L(E, 1) and derivatives
- [ ] Define analytic rank properly
- [ ] State connection to BSD
-/

end BSD.LFunction
