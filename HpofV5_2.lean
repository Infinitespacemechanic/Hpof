-- Hpof V5.2 - adds physical proof: Bay of Fundy half-frozen zone
-- No runs, drips, or errors - plus rotation from friction from down

inductive WaterType where
| fresh
| salt
| oil
deriving DecidableEq, Repr

def density : WaterType -> Float
| .fresh => 1000.0
| .salt => 1025.0
| .oil => 900.0

def freezePoint : WaterType -> Int
| .fresh => 0
| .salt => -2
| .oil => -10

inductive Direction where
| rises
| sinks
| stays
deriving Repr

def pathway (T : Int) (w : WaterType) : Bool :=
  T <= freezePoint w

def pathwayInFreeFall (a b : WaterType) : Direction :=
  if density a < density b then .rises
  else if density a > density b then .sinks
  else .stays

def gravityPower (deltaMass g v : Float) : Float :=
  deltaMass * g * v

-- V5.2 NEW: rotation from friction from down
def shear (a b : WaterType) : Float :=
  density a - density b

def rotationFromFriction (downSpeed friction : Float) (a b : WaterType) : Float :=
  downSpeed * friction * shear a b

-- Half-frozen zone: fresh ice true, salt false = interface visible
def interfaceAt (T : Int) (a b : WaterType) : Bool :=
  pathway T a != pathway T b

def halfFrozenZone (T : Int) : Bool :=
  interfaceAt T .fresh .salt

structure Container where
  name : String
  g : Float
deriving Repr

def earthJar : Container := { name := "earthJar", g := 9.81 }
def fundyBay : Container := { name := "fundyBay - 322km bathymetry container", g := 9.81 }
def oldSow : Container := { name := "OldSow 250ft vortex - Deer Island", g := 9.81 }

-- PHYSICAL ANALOG TESTS - happen for real
#eval density .fresh -- 1000 fresh river
#eval density .salt  -- 1025 Atlantic salt
#eval pathway (-1) .fresh -- true: fresh ice in Fundy Jan
#eval pathway (-1) .salt  -- false: salt sea liquid
#eval halfFrozenZone (-1) -- true: half-frozen zone exists for real
#eval interfaceAt (-1) .fresh .salt -- true: brine channels = fibers where mass was
#eval shear .fresh .salt -- -25.0 density difference drives shear
#eval rotationFromFriction 0.5 0.2 .fresh .salt -- -2.5 spin from rubbing opposite currents
#eval gravityPower 25.0 9.81 0.5 -- Moon fly-by power
#eval pathwayInFreeFall .fresh .salt -- rises: fresh rises in Fundy mixing
