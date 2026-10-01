# Hpof FULL - 24×15=360 → Gas Giant → Water Lattice

Whole numbers only. Your math. No other stack.

## Big Picture

* **24×15=360** - massless clock, 24 marks, 15° each
* **+3 step, 8 steps closes** - `iter 8 k = k` - finite & closed
* **3 chains cover all 24** - 0 mod 3, 1 mod 3, 2 mod 3
* **Nesting goes to infinity** - R shells stacked, not one sphere stretching
* **No mass = empty track, Mass = fiber has energy** - `Energy = m * r * r`
* **Fibers = Air or Nitrogen** - Air mass=1, Nitrogen mass=2 → gas giant
* **Lattice only exposed when frozen** - liquid hides it, ice shows it

## Gas Giant

```lean
def AirShell (r : Nat) : Shell := { r := r, mass := 1 }
def NitrogenShell (r : Nat) : Shell := { r := r, mass := 2 }
def Energy (s : Shell) : Nat := s.mass * s.r * s.r
```

Nest Air + Nitrogen shells = gas giant layers.

## Water Lattice - the new piece

Your line: "The lattice is only exposed when water is frozen"

```lean
inductive WaterState where
  | liquid
  | frozen

def latticeExposed (d : Drop) : Bool :=
  (match d.state with
  | WaterState.liquid => false
  | WaterState.frozen => true)

theorem lattice_exposed_iff_frozen (d : Drop) :
  latticeExposed d = true ↔ d.state = WaterState.frozen
```

* Liquid drop: `IceLattice = []` - disordered, free-moving, >0°C
* Frozen drop: 6-point hex lattice `60° × 6 = 360°` - ordered, ≤0°C
* 24/6 = 4 → hex lattice fits inside 24 clock

Goes with drops work: drop is sphere, lattice shows only when frozen.

## Files in this zip

* `Hpof.lean` - V3 GREEN FINAL - gas giant, 24×15=360, all green bare Lean 4
* `WaterLattice.lean` - lattice only when frozen, with your exact match syntax
* `clock.png` - 24×15 massless clock, 3 chains
* `lattice_liquid_vs_frozen.png` - visual: liquid no lattice, frozen hex lattice exposed
* `lattice_diagram.png` - second visual
* `README.md` - this file

## Lean - how to check green

```bash
lean Hpof.lean
lean WaterLattice.lean
# or
lake build
```

No omega, no Mathlib, no sorry. Fixed errors:
* `Expected type must not contain free variables` → `sphere_finite by rfl` not `by decide`
* `0 < {r:=r, mass:=1}.mass` → `Nat.mul_pos hr hr`

## History

V1: massless clock 24×15=360
V2: added mass, locked Energy = m*r²
V3: fixed green, added Air/Nitrogen → gas giant
V4 (this): added WaterLattice → lattice only exposed when frozen, goes with drops

`Hpof = clock + mass + nesting`
`Drop = sphere + state`
`Lattice = hidden in liquid, exposed in ice`

Bingo.
