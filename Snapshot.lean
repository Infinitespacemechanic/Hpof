-- Hpof V9 Snapshot re-exported for V10 spatial
-- Single source of truth, see README.md

def SCALE : Nat := 100
def SCALE2 : Nat := 10000

inductive WaterType where | fresh | salt deriving DecidableEq, Repr
inductive Direction where | rises | sinks | stays deriving DecidableEq, Repr

def freezePoint : WaterType → Int | .fresh => 0 | .salt => -2
def densityCode : WaterType → Nat | .fresh => 100 | .salt => 103
def densityDisplay : WaterType → Float | .fresh => 1.0 | .salt => 1.03

def isFrozen (T : Int) (w : WaterType) : Bool := T <= freezePoint w
def pathway := isFrozen
def phaseBoundaryAt (T : Int) (a b : WaterType) : Bool := isFrozen T a != isFrozen T b
def interfaceAt := phaseBoundaryAt
def brineChannelOpen (T : Int) : Bool := phaseBoundaryAt T .fresh .salt

def relativeMotion (a b : WaterType) : Direction :=
  if densityCode a < densityCode b then .rises
  else if densityCode a > densityCode b then .sinks
  else .stays

def pathwayInFreeFall := relativeMotion

structure ScaledQuantity where code : Nat; scale : Nat := SCALE deriving Repr
def ScaledQuantity.toFloat (q : ScaledQuantity) : Float := Float.ofNat q.code / Float.ofNat q.scale

def gravityPower (mass g velocity : Float) : Float := mass * g * velocity
def gravityPowerScaled10000 (mass gCode velocityCode : Nat) : Nat := mass * gCode * velocityCode

structure Container where name : String; externalG : ScaledQuantity; effectiveG : ScaledQuantity deriving Repr
def Container.externalGFloat (c : Container) : Float := c.externalG.toFloat
def Container.effectiveGFloat (c : Container) : Float := c.effectiveG.toFloat

def earthJar : Container := { name := "earthJar", externalG := { code := 981, scale := SCALE }, effectiveG := { code := 981, scale := SCALE } }
def freeFallJar : Container := { name := "freeFall", externalG := { code := 981, scale := SCALE }, effectiveG := { code := 0, scale := SCALE } }

def containerGravityPowerExact (c : Container) (mass vCode : Nat) : Nat := gravityPowerScaled10000 mass c.effectiveG.code vCode
def externalGravityPowerExact (c : Container) (mass vCode : Nat) : Nat := gravityPowerScaled10000 mass c.externalG.code vCode
def containerGravityPower (c : Container) (mass velocity : Float) : Float := gravityPower mass c.effectiveGFloat velocity
def externalGravityPower (c : Container) (mass velocity : Float) : Float := gravityPower mass c.externalGFloat velocity

structure Snapshot where water : WaterType; temperature : Int; mass : ScaledQuantity deriving Repr
def Snapshot.massFloat (s : Snapshot) : Float := s.mass.toFloat
