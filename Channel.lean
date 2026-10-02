-- Hpof V10 Spatial - Channel
-- Bare Lean 4, no axioms, all rfl/decide
import Hpof.Spatial.Cell

inductive WaterKind where
| fresh
| salt
| air
| nitrogen
deriving DecidableEq, Repr

def freezePoint : WaterKind -> Int
| .fresh => 0
| .salt => -2
| .air => -100
| .nitrogen => -100

def isFrozen (T : Int) (w : WaterKind) : Bool :=
  T <= freezePoint w

def phaseBoundaryAt (T : Int) (a b : WaterKind) : Bool :=
  (isFrozen T a) != (isFrozen T b)

def brineChannelOpen (T : Int) : Bool :=
  phaseBoundaryAt T .fresh .salt

-- V10 new: spatial open condition at cell pair
def Channel.isOpenAt (T : Int) (a b : WaterKind) : Bool :=
  phaseBoundaryAt T a b

def Channel.isConnected (c1 c2 : Cell) (T : Int) : Bool :=
  c1.isNeighbor c2 && brineChannelOpen T

theorem brine_closed_at_0 : brineChannelOpen 0 = false := by rfl
theorem brine_open_at_minus1 : brineChannelOpen (-1) = true := by rfl
theorem brine_open_at_minus3 : brineChannelOpen (-3) = true := by rfl

theorem channel_open_iff_frozen_diff (T : Int) (a b : WaterKind) :
  Channel.isOpenAt T a b = phaseBoundaryAt T a b := by rfl

