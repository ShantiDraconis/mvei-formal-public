import AxiomaticMillenium.Pattern

namespace AxiomaticMillenium

structure RealizationOperator (Abstract Actual : Type) where
  realize : Abstract → Actual
  project : Actual → Abstract
  rightInverse : ∀ a, project (realize a) = a

structure UniformizationOperator (X Y : Type) (Q : X → Y → Prop) where
  choose : X → Y
  sound : ∀ x, Q x (choose x)

structure GlobalizationOperator (Local : Nat → Prop) (Global : Prop) where
  localCerts : ∀ n, Local n
  closeGlobal : (∀ n, Local n) → Global

structure PreservationOperator (X : Type) (P : X → Prop) (f : X → X) where
  preserves : ∀ x, P x → P (f x)

structure InvarianceOperator (X Y : Type) (obs : X → Y) (f : X → X) where
  invariant : ∀ x, obs (f x) = obs x

theorem realization_closes
    {Abstract Actual : Type}
    (op : RealizationOperator Abstract Actual)
    (Good : Abstract → Prop)
    (a : Abstract) (ha : Good a) :
    ∃ x : Actual, op.project x = a ∧ Good (op.project x) := by
  refine ⟨op.realize a, ?_, ?_⟩
  · exact op.rightInverse a
  · rw [op.rightInverse a]
    exact ha

theorem uniformization_closes
    {X Y : Type} {Q : X → Y → Prop}
    (op : UniformizationOperator X Y Q) :
    ∃ F : X → Y, ∀ x, Q x (F x) :=
  ⟨op.choose, op.sound⟩

theorem globalization_closes
    {Local : Nat → Prop} {Global : Prop}
    (op : GlobalizationOperator Local Global) : Global :=
  op.closeGlobal op.localCerts

structure EndpointBridge (A : Type) (PropA : A → Prop) (T : Prop) where
  bridge : ∀ a, PropA a → T

theorem bridge_closes
    {A : Type} {PropA : A → Prop} {T : Prop}
    (b : EndpointBridge A PropA T) (a : A) (ha : PropA a) : T :=
  b.bridge a ha

end AxiomaticMillenium
