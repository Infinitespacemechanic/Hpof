-- V10 Spatial Layer - Flow = mass moving through channel at temperature
import Hpof.Snapshot
import Hpof.Spatial.Channel

structure Flow where
  channel : Channel
  mass : ScaledQuantity -- primary exact, e.g. { code := 25, scale := 1 }
  velocityCode : Nat -- scaled by SCALE, e.g. 50 = 0.5
  temperature : Int
  water : WaterType := .fresh
deriving Repr

def Flow.massFloat (f : Flow) : Float := f.mass.toFloat
def Flow.velocityFloat : Flow → Float | f => Float.ofNat f.velocityCode / Float.ofNat SCALE

def Flow.isActive (f : Flow) : Bool :=
  f.channel.isOpenAt f.temperature && f.channel.isConnected

def Flow.powerExact (f : Flow) (c : Container) : Nat :=
  if f.isActive then
    containerGravityPowerExact c f.mass.code f.velocityCode
  else 0

def Flow.powerExternalExact (f : Flow) (c : Container) : Nat :=
  if f.isActive then
    externalGravityPowerExact c f.mass.code f.velocityCode
  else 0

def Flow.powerFloat (f : Flow) (c : Container) : Float :=
  if f.isActive then
    containerGravityPower c f.massFloat f.velocityFloat
  else 0.0

-- Examples using V9 numbers
def flowExample : Flow :=
  { channel := Channel.exampleVertical
    mass := { code := 25, scale := 1 }
    velocityCode := 50 -- 0.5
    temperature := -1 -- brine open
    water := .fresh }

#eval flowExample.isActive -- true
#eval flowExample.powerExact earthJar -- 1226250
#eval flowExample.powerExact freeFallJar -- 0, effective G = 0
#eval flowExample.powerExternalExact freeFallJar -- 1226250, external G = 9.81
#eval flowExample.powerFloat earthJar -- 122.625

def flowExampleClosed : Flow :=
  { flowExample with temperature := -3 } -- both frozen

#eval flowExampleClosed.isActive -- false
#eval flowExampleClosed.powerExact earthJar -- 0

-- Future theorems (sorry for now, prove after V9 locked)
-- theorem flow_zero_when_closed : ∀ f c, f.channel.isOpenAt f.temperature = false → f.powerExact c = 0
-- theorem flow_zero_when_disconnected : ∀ f c, f.channel.isConnected = false → f.powerExact c = 0
-- theorem mass_conservation : sum of inflows = sum of outflows (needs graph)
