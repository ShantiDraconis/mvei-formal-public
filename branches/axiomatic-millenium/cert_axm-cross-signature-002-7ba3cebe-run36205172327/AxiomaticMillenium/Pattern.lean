import Std

namespace AxiomaticMillenium

/-- Mathematical obstruction taxonomy v2.
System/CI errors are deliberately not members of this type. -/
inductive Pattern where
  | U  -- missing producer / witness
  | B  -- missing endpoint bridge
  | R  -- realizability: abstract -> admissible concrete
  | N  -- uniformization: pointwise -> uniform
  | C  -- local/finite -> global/infinite
  | F  -- falsified intermediate formulation
  | Z  -- canonical identification / normalization
  | P  -- preservation of required structure
  | I  -- invariance under the relevant transformation
  deriving Repr, DecidableEq, BEq

/-- Discrete depth scale: 0, .25, .50, .75, 1.00 encoded exactly as 0..4. -/
abbrev Depth := Fin 5

def depth0 : Depth := ⟨0, by decide⟩
def depth25 : Depth := ⟨1, by decide⟩
def depth50 : Depth := ⟨2, by decide⟩
def depth75 : Depth := ⟨3, by decide⟩
def depth100 : Depth := ⟨4, by decide⟩

structure Signature where
  U : Depth := depth0
  B : Depth := depth0
  R : Depth := depth0
  N : Depth := depth0
  C : Depth := depth0
  F : Depth := depth0
  Z : Depth := depth0
  P : Depth := depth0
  I : Depth := depth0
  deriving Repr, DecidableEq

def Signature.at (s : Signature) : Pattern → Depth
  | .U => s.U | .B => s.B | .R => s.R | .N => s.N | .C => s.C
  | .F => s.F | .Z => s.Z | .P => s.P | .I => s.I

def Pattern.all : List Pattern := [.U,.B,.R,.N,.C,.F,.Z,.P,.I]

/-- Transfer weights scaled by 10:
R,N,C=10; B=3; U=1; unassigned F,Z,P,I default to 5. -/
def Pattern.weight10 : Pattern → Nat
  | .R | .N | .C => 10
  | .B => 3
  | .U => 1
  | .F | .Z | .P | .I => 5

def natAbsDiff (a b : Nat) : Nat :=
  if a ≤ b then b-a else a-b

/-- Weighted squared distance, scaled discretely.
Ranking by this quantity is equivalent to ranking by sqrt of it. -/
def distanceSq10 (a b : Signature) : Nat :=
  Pattern.all.foldl (fun acc p =>
    let d := natAbsDiff (a.at p).val (b.at p).val
    acc + p.weight10 * d * d) 0

theorem distanceSq10_self (s : Signature) : distanceSq10 s s = 0 := by
  simp [distanceSq10, Pattern.all, natAbsDiff, Signature.at, Pattern.weight10]

theorem distanceSq10_nonneg (a b : Signature) : 0 ≤ distanceSq10 a b :=
  Nat.zero_le _

end AxiomaticMillenium
