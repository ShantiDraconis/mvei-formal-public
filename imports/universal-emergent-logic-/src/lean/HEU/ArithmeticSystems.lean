import Mathlib
import HEU.BasicDefs

namespace HEU

/-- Toy prime system with `count = log integral` surrogate. -/
def primeSystem : ArithmeticSystem :=
  { count := fun x => Real.log (x + 1)
    model := fun x => Real.log (x + 1)
    kappa := 1 }

/-- Declared placeholders for other systems. -/
def twinPrimeSystem : ArithmeticSystem :=
  { count := fun x => Real.log (x + 1)
    model := fun x => Real.log (x + 1)
    kappa := 1 }

def goldbachSystem : ArithmeticSystem :=
  { count := fun x => Real.sqrt (Real.max x 1)
    model := fun x => Real.sqrt (Real.max x 1)
    kappa := 1 }

end HEU
