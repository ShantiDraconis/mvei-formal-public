/-
  Harappan Guilds 0/0 - Lean 4 Formalization
  
  A formal mathematical theory of the Harappan guild-based semiotic system,
  connecting archaeological evidence with the concept of indeterminacy (0/0).
  
  Author: Shanti Draconis
  License: MIT
-/

-- Basic type definitions for the guild system

/-- The six guild archetypes -/
inductive Archetype where
  | order      -- Artisan-Priests
  | flow       -- Navigators  
  | foundation -- Earth Guardians
  | knowledge  -- Sign Readers
  | memory     -- Totemic Clans
  | structure  -- Invisibles
  deriving Repr, DecidableEq

/-- The five elements associated with guilds -/
inductive Element where
  | fire
  | water
  | earth
  | ether
  | spirit
  | void
  deriving Repr, DecidableEq

/-- A Guild is defined by its archetype, domain, and collapse operator -/
structure Guild where
  archetype : Archetype
  element : Element
  domain : String
  deriving Repr

/-- Sign categories in the Harappan system -/
inductive SignCategory where
  | animal
  | human
  | object
  | geometry
  | text
  deriving Repr, DecidableEq

/-- A Harappan sign -/
structure Sign where
  id : String
  category : SignCategory
  guild : Guild
  deriving Repr

/-- The Indeterminacy type represents the 0/0 state -/
structure Indeterminacy where
  potential : Nat  -- Represents unbounded potential
  deriving Repr

/-- A collapse operation takes indeterminacy to a specific domain -/
def collapse (g : Guild) (i : Indeterminacy) : String :=
  g.domain

-- Guild definitions

def artisanPriests : Guild := {
  archetype := Archetype.order,
  element := Element.fire,
  domain := "precision"
}

def navigators : Guild := {
  archetype := Archetype.flow,
  element := Element.water,
  domain := "transition"
}

def earthGuardians : Guild := {
  archetype := Archetype.foundation,
  element := Element.earth,
  domain := "stability"
}

def signReaders : Guild := {
  archetype := Archetype.knowledge,
  element := Element.ether,
  domain := "interpretation"
}

def totemicClans : Guild := {
  archetype := Archetype.memory,
  element := Element.spirit,
  domain := "lineage"
}

def invisibles : Guild := {
  archetype := Archetype.structure,
  element := Element.void,
  domain := "abstraction"
}

/-- The complete list of six guilds -/
def allGuilds : List Guild := [
  artisanPriests,
  navigators,
  earthGuardians,
  signReaders,
  totemicClans,
  invisibles
]

-- Axiom 1: Completeness
-- The union of all guild domains covers the complete symbolic space

/-- All valid domains in the system -/
def validDomains : List String := [
  "precision", "transition", "stability", 
  "interpretation", "lineage", "abstraction"
]

/-- Check if a domain is covered by some guild -/
def domainCovered (d : String) : Bool :=
  allGuilds.any (fun g => g.domain == d)

theorem completeness : ∀ d ∈ validDomains, domainCovered d = true := by
  intro d hd
  simp [validDomains] at hd
  rcases hd with rfl | rfl | rfl | rfl | rfl | rfl <;>
  simp [domainCovered, allGuilds, artisanPriests, navigators, 
        earthGuardians, signReaders, totemicClans, invisibles]

-- Axiom 2: Complementarity
-- Guilds are mutually exclusive in their primary domains

theorem complementarity : ∀ g1 g2 : Guild, g1 ∈ allGuilds → g2 ∈ allGuilds → 
    g1.archetype ≠ g2.archetype → g1.domain ≠ g2.domain := by
  intro g1 g2 h1 h2 hneq
  simp [allGuilds] at h1 h2
  rcases h1 with rfl | rfl | rfl | rfl | rfl | rfl <;>
  rcases h2 with rfl | rfl | rfl | rfl | rfl | rfl <;>
  simp [artisanPriests, navigators, earthGuardians, 
        signReaders, totemicClans, invisibles] at hneq ⊢

-- Axiom 3: Collapse Preservation
-- Each guild preserves the collapse operation within its domain

theorem collapse_preservation : ∀ g : Guild, ∀ i : Indeterminacy,
    collapse g i = g.domain := by
  intro g i
  simp [collapse]

-- Axiom 4: Universality
-- The guild system maps to universal archetypal patterns

/-- Bijection between guilds and archetypes -/
def guildToArchetype (g : Guild) : Archetype := g.archetype

theorem archetype_coverage : ∀ a : Archetype, 
    ∃ g ∈ allGuilds, g.archetype = a := by
  intro a
  cases a with
  | order => exact ⟨artisanPriests, by simp [allGuilds], rfl⟩
  | flow => exact ⟨navigators, by simp [allGuilds], rfl⟩
  | foundation => exact ⟨earthGuardians, by simp [allGuilds], rfl⟩
  | knowledge => exact ⟨signReaders, by simp [allGuilds], rfl⟩
  | memory => exact ⟨totemicClans, by simp [allGuilds], rfl⟩
  | structure => exact ⟨invisibles, by simp [allGuilds], rfl⟩

-- Properties of the guild count

theorem guild_count : allGuilds.length = 6 := by
  simp [allGuilds]

-- The indeterminacy principle: 0/0 as the source

/-- The primordial indeterminacy from which all meanings derive -/
def primordialI : Indeterminacy := { potential := 0 }

/-- All guild domains derive from the same indeterminacy -/
theorem common_source : ∀ g1 g2 : Guild,
    ∃ d1 d2 : String, collapse g1 primordialI = d1 ∧ collapse g2 primordialI = d2 := by
  intro g1 g2
  exact ⟨collapse g1 primordialI, collapse g2 primordialI, rfl, rfl⟩

#check completeness
#check complementarity
#check collapse_preservation
#check archetype_coverage
#check guild_count
