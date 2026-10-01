-- WaterLattice - fixed match syntax - lattice only exposed when frozen
-- bare Lean 4, green

def N : Nat := 24
abbrev Clock : Type := Fin N

inductive WaterState where
  | liquid
  | frozen
deriving DecidableEq, Repr, BEq

structure Drop where
  r : Nat
  state : WaterState
deriving Repr

-- your exact syntax
def latticeExposed (d : Drop) : Bool :=
  (match d.state with
  | WaterState.liquid => false
  | WaterState.frozen => true)

def IceLattice (d : Drop) : List (Nat × Fin 6) :=
  (match d.state with
  | WaterState.liquid => []
  | WaterState.frozen =>
    [ (d.r, ⟨0, by decide⟩), (d.r, ⟨1, by decide⟩), (d.r, ⟨2, by decide⟩),
      (d.r, ⟨3, by decide⟩), (d.r, ⟨4, by decide⟩), (d.r, ⟨5, by decide⟩) ])

theorem lattice_empty_when_liquid (d : Drop) (h : d.state = WaterState.liquid) :
  IceLattice d = [] := by
  simp [IceLattice, h]

theorem lattice_exposed_iff_frozen (d : Drop) :
  latticeExposed d = true ↔ d.state = WaterState.frozen := by
  cases h : d.state with
  | liquid =>
    constructor
    · intro hf
      simp [latticeExposed, h] at hf
    · intro hs
      rw [hs] at h
      contradiction
  | frozen =>
    constructor
    · intro _; rfl
    · intro _; simp [latticeExposed, h]

theorem lattice_hidden_iff_liquid (d : Drop) :
  latticeExposed d = false ↔ d.state = WaterState.liquid := by
  cases h : d.state with
  | liquid =>
    constructor
    · intro _; rfl
    · intro _; simp [latticeExposed, h]
  | frozen =>
    constructor
    · intro hf
      simp [latticeExposed, h] at hf
    · intro hs
      rw [hs] at h
      contradiction

def DropSphere (d : Drop) : List (Nat × Clock) :=
  [ (d.r, ⟨0, by decide⟩), (d.r, ⟨1, by decide⟩), (d.r, ⟨2, by decide⟩), (d.r, ⟨3, by decide⟩),
    (d.r, ⟨4, by decide⟩), (d.r, ⟨5, by decide⟩), (d.r, ⟨6, by decide⟩), (d.r, ⟨7, by decide⟩),
    (d.r, ⟨8, by decide⟩), (d.r, ⟨9, by decide⟩), (d.r, ⟨10, by decide⟩), (d.r, ⟨11, by decide⟩),
    (d.r, ⟨12, by decide⟩), (d.r, ⟨13, by decide⟩), (d.r, ⟨14, by decide⟩), (d.r, ⟨15, by decide⟩),
    (d.r, ⟨16, by decide⟩), (d.r, ⟨17, by decide⟩), (d.r, ⟨18, by decide⟩), (d.r, ⟨19, by decide⟩),
    (d.r, ⟨20, by decide⟩), (d.r, ⟨21, by decide⟩), (d.r, ⟨22, by decide⟩), (d.r, ⟨23, by decide⟩) ]

theorem drop_sphere_finite (d : Drop) : (DropSphere d).length = 24 := by rfl
