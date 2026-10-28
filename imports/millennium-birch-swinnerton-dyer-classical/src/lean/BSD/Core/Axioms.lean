/-
Copyright (c) 2025 BSD Formalization Project. All rights reserved.
Released under MIT license as described in the file LICENSE.
Authors: BSD Formalization Team
-/

/-!
# Axioms for BSD Formalization

This file establishes the foundational axioms used in the BSD conjecture proof.
We use classical logic with the Axiom of Choice.

## Main Axioms

* Classical logic (LEM, double negation)
* Axiom of Choice
* No exotic axioms (no CH, no large cardinals)

## References

* See: `docs/00-axioms-and-foundations/axioms-zfc-and-choice.md`
-/

namespace BSD.Core

/-!
## Classical Logic

We use classical logic throughout the formalization.
In Lean 4 with Mathlib, this is provided by the `Classical` namespace.
-/

-- Classical.em provides Law of Excluded Middle
-- Classical.choice provides Axiom of Choice

/-!
## Axiom Notes

This formalization assumes:
1. ZFC set theory (standard mathematical foundations)
2. Axiom of Choice (used in Mordell-Weil, algebraic closures, etc.)
3. Classical logic (LEM, proof by contradiction)

We do NOT assume:
- Continuum Hypothesis
- Large cardinal axioms
- Grothendieck universes beyond what Lean requires
-/

/-- Marker for axioms used in critical proofs.
    This is for documentation purposes only. -/
structure UsesAC : Prop where
  uses_choice : True

/-- Marker for classical logic usage.
    This is for documentation purposes only. -/
structure UsesLEM : Prop where
  uses_lem : True

/-!
## TODO

- [ ] Document all uses of AC in the proof
- [ ] Track which lemmas require classical logic
- [ ] Consider constructive alternatives where possible
-/

end BSD.Core
