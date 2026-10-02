-- V10 Spatial Layer - Channel as connected path
import Hpof.Snapshot
import Hpof.Spatial.Cell

structure Channel where
  cells : List Cell
  name : String := "channel"
deriving Repr

def Channel.length (c : Channel) : Nat := c.cells.length

def Channel.isEmpty (c : Channel) : Bool := c.cells.isEmpty

-- Open condition reuses V9 symbolic model: brineChannelOpen T
def Channel.isOpenAt (c : Channel) (T : Int) : Bool :=
  brineChannelOpen T && !c.isEmpty

-- Check path connectivity: every consecutive pair adjacent
def Channel.isConnected : Channel → Bool
  | { cells := [], .. } => true
  | { cells := [_], .. } => true
  | { cells := a :: b :: rest, .. } =>
    if a.adjacent b then
      Channel.isConnected { cells := b :: rest }
    else false

def Channel.exampleVertical : Channel :=
  { cells := [ { x := 0, y := 0, z := 0 }, { x := 0, y := 0, z := 1 }, { x := 0, y := 0, z := 2 } ]
    name := "vertical-3" }

def Channel.exampleBroken : Channel :=
  { cells := [ { x := 0, y := 0, z := 0 }, { x := 5, y := 5, z := 5 } ]
    name := "broken" }

#eval Channel.exampleVertical.isConnected -- true
#eval Channel.exampleBroken.isConnected -- false
#eval Channel.exampleVertical.isOpenAt (-1) -- true, frozen fresh vs liquid salt + non-empty
#eval Channel.exampleVertical.isOpenAt (-3) -- false, both frozen
