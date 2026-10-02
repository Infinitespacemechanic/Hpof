-- Hpof V5 - snapshot model: container + mass + mass reaction
-- No runs, drips, or errors - fresh/salt with different freeze points
-- Pathway = brine channel where mass was, power = gravity in free fall

inductive WaterType where
| fresh
| salt
| oil
deriving DecidableEq, Repr

-- Mass difference: gives reason pathway stays open
def density : WaterType -> Float
| .fresh => 1000.0
| .salt => 1025.0
| .oil => 900.0

-- Mass reaction: different freezing points = different pathways
def freezePoint : WaterType -> Int
| .fresh => 0
| .salt => -2
| .oil => -10

inductive Direction where
| rises
| sinks
| stays
deriving Repr

-- Snapshot: is it frozen at temperature T?
def pathway (T : Int) (w : WaterType) : Bool :=
  T <= freezePoint w

-- Free fall: heavier sinks, lighter rises - flow without internal energy
def pathwayInFreeFall (a b : WaterType) : Direction :=
  if density a < density b then .rises
  else if density a > density b then .sinks
  else .stays

-- Power from gravity, not from m * r^2
-- deltaMass * g * v : container + mass + reaction gives flow
def gravityPower (deltaMass g v : Float) : Float :=
  deltaMass * g * v

-- Container: shape that holds snapshot
structure Container where
  name : String
  g : Float -- gravity for free fall power
deriving Repr

def earthJar : Container := { name := "earthJar", g := 9.81 }
def freeFallJar : Container := { name := "freeFall", g := 9.81 }

-- Interface = where fresh and salt don't mix = pathway / fiber / breadcrumb
def interfaceAt (T : Int) (a b : WaterType) : Bool :=
  pathway T a != pathway T b
  -- at -1C: fresh frozen true, salt false -> interface visible = brine channel

-- Tests - should show no Unknown identifier
#eval density .fresh -- 1000.0
#eval density .salt  -- 1025.0
#eval freezePoint .fresh -- 0
#eval freezePoint .salt  -- -2
#eval pathway (-1) .fresh -- true, lattice appears
#eval pathway (-1) .salt  -- false, still liquid channel
#eval pathway (-3) .salt  -- true, both frozen
#eval interfaceAt (-1) .fresh .salt -- true, pathway visible where mass was
#eval pathwayInFreeFall .fresh .salt -- rises
#eval gravityPower 25.0 9.81 0.5 -- 122.6 power from gravity, no internal Energy needed
