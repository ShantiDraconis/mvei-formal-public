namespace ROZC

universe u

/-- Abstract local-response interface corresponding to the first nonvanishing
    local information around a zero.  In a concrete analytic adapter this role
    may be played by a derivative such as zeta'(rho). -/
structure LocalZeroResponse where
  Point : Type u
  Value : Type u
  isZero : Point → Prop
  response : Point → Value

/-- A zero may retain local-response data even though its function value vanishes.
    This theorem is intentionally structural: it does not assert nonvanishing of
    the derivative for concrete zeta zeros. -/
structure ZeroWithResponse (L : LocalZeroResponse) where
  point : L.Point
  zero : L.isZero point
  localResponse : L.Value
  response_eq : localResponse = L.response point

theorem response_is_preserved
    {L : LocalZeroResponse}
    (z : ZeroWithResponse L) :
    z.localResponse = L.response z.point :=
  z.response_eq

#print axioms response_is_preserved

end ROZC
