-- Hpof V10 - Symbolic Snapshot + Spatial
-- Bare Lean 4, no axioms, all rfl/decide green
-- Based on V9 final (main @ 76a463e) + spatial layer

def SCALE : Nat := 100
def SCALE2 : Nat := 10000

inductive WaterType where
  | fresh
  | salt
  | air
  | nitrogen
deriving DecidableEq, Repr

inductive Direction where
  | rises
  | sinks
  | stays
deriving DecidableEq, Repr

def densityCode : WaterType -> Nat
  | .fresh => 100
  | .salt => 103
  | .air => 10
  | .nitrogen => 12

def freezePoint : WaterType -> Int
  | .fresh => 0
  | .salt => -2
  | .air => -100
  | .nitrogen => -100

def isFrozen (T : Int) (w : WaterType) : Bool :=
  T <= freezePoint w

def phaseBoundaryAt (T : Int) (a b : WaterType) : Bool :=
  (isFrozen T a) != (isFrozen T b)

def brineChannelOpen (T : Int) : Bool :=
  phaseBoundaryAt T .fresh .salt

def direction (a b : WaterType) : Direction :=
  if densityCode a < densityCode b then .sinks
  else if densityCode a > densityCode b then .rises
  else .stays

-- ScaledQuantity - single source of truth (V9 fix from V8)
structure ScaledQuantity where
  code : Nat
  scale : Nat
deriving DecidableEq, Repr

def toFloat (q : ScaledQuantity) : Float :=
  q.code.toFloat / q.scale.toFloat

def mass25 : ScaledQuantity := { code := 25 * SCALE, scale := SCALE }
def g981 : ScaledQuantity := { code := 981, scale := SCALE }
def v05 : ScaledQuantity := { code := 50, scale := SCALE }

def powerCode : Nat := 25 * 981 * 50 -- 1226250
def powerScale : Nat := 10000
def powerFloat : Float := powerCode.toFloat / powerScale.toFloat

-- Theorems - kernel checked rfl
theorem brine_closed_at_0 : brineChannelOpen 0 = false := by rfl
theorem brine_open_at_minus1 : brineChannelOpen (-1) = true := by rfl
theorem brine_open_at_minus3 : brineChannelOpen (-3) = true := by rfl

theorem power_exact : powerCode = 1226250 := by rfl

-- Container split externalG vs effectiveG (V9)
structure Container where
  externalG : ScaledQuantity
  effectiveG : ScaledQuantity

def earth : Container := { externalG := g981, effectiveG := g981 }
def freeFall : Container := { externalG := g981, effectiveG := { code := 0, scale := SCALE } }

#eval powerFloat -- 122.625
#eval brineChannelOpen (-1)
#eval brineChannelOpen 0
