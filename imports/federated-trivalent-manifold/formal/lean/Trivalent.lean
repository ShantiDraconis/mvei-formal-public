inductive Triv where
  | false | unknown | true
deriving DecidableEq, Repr

namespace Triv

def neg : Triv -> Triv
  | false => true
  | unknown => unknown
  | true => false

def and : Triv -> Triv -> Triv
  | false, _ => false
  | _, false => false
  | true, true => true
  | _, _ => unknown

def or : Triv -> Triv -> Triv
  | true, _ => true
  | _, true => true
  | false, false => false
  | _, _ => unknown

theorem neg_involutive : forall a : Triv, neg (neg a) = a
  | false => rfl
  | unknown => rfl
  | true => rfl

theorem and_comm : forall a b : Triv, and a b = and b a
  | false, false => rfl | false, unknown => rfl | false, true => rfl
  | unknown, false => rfl | unknown, unknown => rfl | unknown, true => rfl
  | true, false => rfl | true, unknown => rfl | true, true => rfl

theorem or_comm : forall a b : Triv, or a b = or b a
  | false, false => rfl | false, unknown => rfl | false, true => rfl
  | unknown, false => rfl | unknown, unknown => rfl | unknown, true => rfl
  | true, false => rfl | true, unknown => rfl | true, true => rfl

end Triv
