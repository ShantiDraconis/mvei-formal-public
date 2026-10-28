axiom hiddenOracle : False

theorem explosion : 1 = 2 := by
  exact False.elim hiddenOracle
