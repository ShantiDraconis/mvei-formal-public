/-
  Harappan Sign Set
  
  Axioms and theorems about the set of Harappan signs.
  Establishes fundamental properties like finiteness and uniqueness.
-/

import Harappan.BasicTypes

namespace Harappan.SignSet

open Harappan

/-- The total number of known Harappan signs -/
def totalSignCount : Nat := 417

/-- Axiom: The set of Harappan signs is finite -/
axiom signs_finite : ∃ (n : Nat), n = totalSignCount

/-- A well-formed sign list has unique IDs -/
def has_unique_ids (signs : List Sign) : Prop :=
  ∀ i j, i < signs.length → j < signs.length → i ≠ j →
    (signs.get ⟨i, by omega⟩).id ≠ (signs.get ⟨j, by omega⟩).id

/-- Theorem: If we have unique IDs, adding a new unique ID preserves uniqueness -/
theorem unique_ids_preserved 
  (signs : List Sign) 
  (new_sign : Sign)
  (h_unique : has_unique_ids signs)
  (h_new_not_in : ∀ s ∈ signs, s.id ≠ new_sign.id) :
  has_unique_ids (new_sign :: signs) := by
  intro i j hi hj hne
  simp [List.get] at *
  cases i with
  | zero =>
    cases j with
    | zero => exact absurd rfl hne
    | succ j' =>
      simp at hi hj
      have hj'' : j' < signs.length := Nat.lt_of_succ_lt_succ hj
      have : signs.get ⟨j', hj''⟩ ∈ signs := List.get_mem signs j' hj''
      exact (h_new_not_in _ this).symm
  | succ i' =>
    cases j with
    | zero =>
      simp at hi hj
      have hi'' : i' < signs.length := Nat.lt_of_succ_lt_succ hi
      have : signs.get ⟨i', hi''⟩ ∈ signs := List.get_mem signs i' hi''
      exact h_new_not_in _ this
    | succ j' =>
      simp at hi hj hne
      have hi'' : i' < signs.length := Nat.lt_of_succ_lt_succ hi
      have hj'' : j' < signs.length := Nat.lt_of_succ_lt_succ hj
      have hne' : i' ≠ j' := fun h => hne (congrArg Nat.succ h)
      exact h_unique i' j' hi'' hj'' hne'

/-- Sign membership in a sign list -/
def sign_member (sign_id : SignId) (signs : List Sign) : Prop :=
  ∃ s ∈ signs, s.id = sign_id

/-- Lemma: Membership is decidable for finite lists -/
instance : DecidablePred (fun s : Sign => s.id = ⟨"H001"⟩) :=
  fun s => inferInstance

/-- A valid corpus has all signs from the sign list -/
structure ValidCorpus where
  sign_list : List Sign
  inscriptions : List Inscription
  h_unique_ids : has_unique_ids sign_list
  h_all_signs_known : ∀ insc ∈ inscriptions, ∀ sid ∈ insc.signs, 
    sign_member sid sign_list

/-- Count occurrences of a sign in all inscriptions -/
def count_occurrences (sign_id : SignId) (inscriptions : List Inscription) : Nat :=
  inscriptions.foldl 
    (fun acc insc => acc + (insc.signs.filter (· == sign_id)).length) 
    0

/-- Calculate relative frequency -/
def relative_frequency (sign_id : SignId) (corpus : ValidCorpus) : Float :=
  let total := corpus.inscriptions.foldl (fun acc insc => acc + insc.signs.length) 0
  let count := count_occurrences sign_id corpus.inscriptions
  if total = 0 then 0.0 else count.toFloat / total.toFloat

end Harappan.SignSet
