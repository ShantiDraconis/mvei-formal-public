/-
Copyright (c) 2025 BSD Formalization Project. All rights reserved.
Released under MIT license as described in the file LICENSE.
Authors: BSD Formalization Team
-/

/-!
# Hecke Operators

Hecke operators on modular forms.

## Main Definitions

* `HeckeOperator` - The Hecke operator T_n
* `eigenform` - A form that is an eigenvector for all T_n

## References

* See: `docs/03-modular-forms-and-modularity/hecke-operators-and-eigenforms.md`
-/

namespace BSD.ModularForms

/-!
## Hecke Operators

T_n acts on modular forms.
-/

-- TODO: Define Hecke operators

/-!
## Eigenforms

An eigenform f satisfies T_n f = λ_n f for all n.
For normalized eigenforms, λ_n = a_n (Fourier coefficient).
-/

-- TODO: Define eigenforms

/-!
## TODO

- [ ] Define Hecke operators T_n
- [ ] Prove T_m T_n = T_{mn} for (m,n) = 1
- [ ] Define eigenforms and normalized eigenforms
-/

end BSD.ModularForms
