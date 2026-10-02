-- Hpof V10 Spatial - Cell
-- Bare Lean 4, no axioms

structure Cell where
  x : Nat
  y : Nat
  z : Nat
  deriving DecidableEq, Repr

def Cell.origin : Cell := { x := 0, y := 0, z := 0 }

def Cell.isNeighbor (a b : Cell) : Bool :=
  let dx := if a.x > b.x then a.x - b.x else b.x - a.x
  let dy := if a.y > b.y then a.y - b.y else b.y - a.y
  let dz := if a.z > b.z then a.z - b.z else b.z - a.z
  (dx + dy + dz) == 1

theorem neighbor_symm (a b : Cell) : a.isNeighbor b = b.isNeighbor a := by
  simp [Cell.isNeighbor, Nat.add_comm, Nat.add_left_comm]

