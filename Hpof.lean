-- Hpof_GREEN_FINAL_V3 - 24×15=360 - bare Lean 4, truly green
-- fixes: Expected type must not contain free variables

def N : Nat := 24
def step : Nat := 3
abbrev Clock : Type := Fin N

def addStep : Clock → Clock
  | ⟨k, hk⟩ => ⟨(k + step) % N, Nat.mod_lt _ (by decide)⟩

def deg (k : Clock) : Nat := k.val * 15

theorem deg_lt_360 : ∀ k : Clock, deg k < 360 := by decide

def iter : Nat → Clock → Clock
  | 0, k => k
  | n+1, k => addStep (iter n k)

theorem iter8_closes : ∀ k : Clock, iter 8 k = k := by decide

theorem three_chains_cover : ∀ k : Clock, k.val % 3 = 0 ∨ k.val % 3 = 1 ∨ k.val % 3 = 2 := by decide

structure Shell where
  r : Nat
  mass : Nat
deriving DecidableEq, Repr

def Energy (s : Shell) : Nat := s.mass * s.r * s.r

theorem no_mass_no_energy (s : Shell) (h : s.mass = 0) : Energy s = 0 := by
  simp [Energy, h]

theorem energy_zero_iff_mass_zero (s : Shell) (hr : 0 < s.r) :
  Energy s = 0 ↔ s.mass = 0 := by
  constructor
  · intro h
    unfold Energy at h
    have h1 : s.mass * (s.r * s.r) = 0 := by
      calc s.mass * (s.r * s.r) = s.mass * s.r * s.r := by rw [Nat.mul_assoc]
        _ = 0 := h
    have hrr : 0 < s.r * s.r := Nat.mul_pos hr hr
    rcases Nat.mul_eq_zero.mp h1 with hm | hrr0
    · exact hm
    · rw [hrr0] at hrr
      contradiction
  · intro h
    exact no_mass_no_energy s h

theorem mass_pos_gives_energy (s : Shell) (hr : 0 < s.r) (hm : 0 < s.mass) :
  0 < Energy s := by
  unfold Energy
  exact Nat.mul_pos (Nat.mul_pos hm hr) hr

def Fiber (s : Shell) (start : Clock) : List (Nat × Clock) :=
  let c0 := start
  let c1 := addStep c0
  let c2 := addStep c1
  let c3 := addStep c2
  let c4 := addStep c3
  let c5 := addStep c4
  let c6 := addStep c5
  let c7 := addStep c6
  [(s.r, c0), (s.r, c1), (s.r, c2), (s.r, c3), (s.r, c4), (s.r, c5), (s.r, c6), (s.r, c7)]

theorem fiber_length (s : Shell) (c : Clock) : (Fiber s c).length = 8 := by rfl

theorem fiber_in_shell (s : Shell) (c : Clock) (p : Nat × Clock) :
  p ∈ Fiber s c → p.1 = s.r := by
  intro h
  simp [Fiber] at h
  rcases h with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl <;> rfl

theorem fiber_has_no_energy_without_mass (s : Shell) (_c : Clock)
  (h : s.mass = 0) : Energy s = 0 :=
  no_mass_no_energy s h

theorem fiber_has_energy_with_mass (s : Shell) (_c : Clock)
  (hr : 0 < s.r) (hm : 0 < s.mass) : 0 < Energy s :=
  mass_pos_gives_energy s hr hm

theorem fibers_disjoint {s1 s2 : Shell} (h : s1.r ≠ s2.r) (c1 c2 : Clock) :
  ∀ p, p ∈ Fiber s1 c1 → p ∉ Fiber s2 c2 := by
  intro p hp1 hp2
  have hr1 : p.1 = s1.r := fiber_in_shell s1 c1 p hp1
  have hr2 : p.1 = s2.r := fiber_in_shell s2 c2 p hp2
  have heq : s1.r = s2.r := hr1.symm.trans hr2
  exact h heq

-- Explicit 24 points, no range proof
def Sphere (s : Shell) : List (Nat × Clock) :=
  [ (s.r, ⟨0, by decide⟩), (s.r, ⟨1, by decide⟩), (s.r, ⟨2, by decide⟩), (s.r, ⟨3, by decide⟩),
    (s.r, ⟨4, by decide⟩), (s.r, ⟨5, by decide⟩), (s.r, ⟨6, by decide⟩), (s.r, ⟨7, by decide⟩),
    (s.r, ⟨8, by decide⟩), (s.r, ⟨9, by decide⟩), (s.r, ⟨10, by decide⟩), (s.r, ⟨11, by decide⟩),
    (s.r, ⟨12, by decide⟩), (s.r, ⟨13, by decide⟩), (s.r, ⟨14, by decide⟩), (s.r, ⟨15, by decide⟩),
    (s.r, ⟨16, by decide⟩), (s.r, ⟨17, by decide⟩), (s.r, ⟨18, by decide⟩), (s.r, ⟨19, by decide⟩),
    (s.r, ⟨20, by decide⟩), (s.r, ⟨21, by decide⟩), (s.r, ⟨22, by decide⟩), (s.r, ⟨23, by decide⟩) ]

-- FIXED: no free-variable decide, just rfl
theorem sphere_finite (s : Shell) : (Sphere s).length = 24 := by rfl

theorem sphere_finite_N (s : Shell) : (Sphere s).length = N := by
  simp [sphere_finite, N]

-- Air / Nitrogen = mass choice
def AirShell (r : Nat) : Shell := { r := r, mass := 1 }
def NitrogenShell (r : Nat) : Shell := { r := r, mass := 2 }

-- FIXED: no decide on open r, use Nat.mul_pos
theorem air_has_energy (r : Nat) (hr : 0 < r) : 0 < Energy (AirShell r) := by
  unfold AirShell Energy
  simp [Nat.one_mul]
  exact Nat.mul_pos hr hr

theorem nitrogen_has_energy (r : Nat) (hr : 0 < r) : 0 < Energy (NitrogenShell r) := by
  unfold NitrogenShell Energy
  have h2 : 0 < 2 := by decide
  exact Nat.mul_pos (Nat.mul_pos h2 hr) hr

structure Hpof where
  clock : Clock
  shell : Shell

def Hpof.closed (h : Hpof) : Prop := iter 8 h.clock = h.clock
def Hpof.energy (h : Hpof) : Nat := Energy h.shell

theorem hpof_always_closed (h : Hpof) : h.closed := iter8_closes h.clock
