import Trivalent

structure State5 where
  x : Rat
  y : Rat
  z : Rat
  t : Rat
  e : Rat

def seff (alpha beta : Rat) (s : State5) : Rat :=
  alpha * s.t * s.t - beta * s.e * s.e

def seffSquared (alpha beta : Rat) (s : State5) : Rat :=
  let q := seff alpha beta s
  q * q

def surgery (s : State5) : State5 := { s with e := s.e / 2 }

theorem surgery_preserves_x (s : State5) : (surgery s).x = s.x := rfl

-- Over rationals, the non-increase claim needs the explicit domain e >= 0.
theorem surgery_delta_e_nonpositive (s : State5) (h : 0 <= s.e) :
    (surgery s).e - s.e <= 0 := by
  simp [surgery]
  omega

def wStep (epsilon deltaT seff2 w : Rat) : Rat :=
  w + (seff2 + epsilon) * deltaT

theorem wStep_non_decreasing
    (epsilon deltaT seff2 w : Rat)
    (he : 0 <= epsilon) (ht : 0 <= deltaT) (hs : 0 <= seff2) :
    w <= wStep epsilon deltaT seff2 w := by
  simp [wStep]
  positivity
