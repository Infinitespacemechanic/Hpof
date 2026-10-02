-- V10 Spatial Layer - Cell grid
-- Pure discrete 3D lattice, no Float

structure Cell where
  x : Nat
  y : Nat
  z : Nat
deriving DecidableEq, Repr, BEq

def Cell.adjacent (a b : Cell) : Bool :=
  let dx := if a.x >= b.x then a.x - b.x else b.x - a.x
  let dy := if a.y >= b.y then a.y - b.y else b.y - a.y
  let dz := if a.z >= b.z then a.z - b.z else b.z - a.z
  (dx + dy + dz == 1)

def Cell.distanceManhattan (a b : Cell) : Nat :=
  let dx := if a.x >= b.x then a.x - b.x else b.x - a.x
  let dy := if a.y >= b.y then a.y - b.y else b.y - a.y
  let dz := if a.z >= b.z then a.z - b.z else b.z - a.z
  dx + dy + dz

def Cell.origin : Cell := { x := 0, y := 0, z := 0 }

#eval Cell.adjacent { x := 0, y := 0, z := 0 } { x := 1, y := 0, z := 0 } -- true
#eval Cell.adjacent { x := 0, y := 0, z := 0 } { x := 1, y := 1, z := 0 } -- false
