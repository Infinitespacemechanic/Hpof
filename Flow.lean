-- Hpof V10 Spatial - Flow
-- Exact scaled Nat arithmetic, Float only via #eval
import Hpof.Spatial.Channel

structure ScaledQuantity where
  code : Nat
  scale : Nat
deriving DecidableEq, Repr

def SCALE : Nat := 100

def toFloat (q : ScaledQuantity) : Float :=
  q.code.toFloat / q.scale.toFloat

def mass25 : ScaledQuantity := { code := 25 * SCALE, scale := SCALE }
def g981 : ScaledQuantity := { code := 981, scale := SCALE } -- 9.81
def v05 : ScaledQuantity := { code := 50, scale := SCALE } -- 0.5

-- exact: code product / (scale product)
-- 25 * 9.81 * 0.5 = 122.625 => code 1226250 scale 10000
def powerCode : Nat := 25 * 981 * 50 -- = 1226250
def powerScale : Nat := SCALE * SCALE * SCALE / SCALE -- keep 10000 for demo = 10000
-- Actually: (2500/100)*(981/100)*(50/100) = 1226250 / 1000000 *100? simplify: keep 1226250 / 10000 = 122.625
def powerScaleCorrect : Nat := 10000
def powerExact : Nat := powerCode -- 1226250 represents 122.625

theorem power_exact_eq : powerCode = 1226250 := by rfl

-- V10: temperature-dependent power split
-- At -1C: channel open, flow 0.5 => full power
-- At -3C: channel frozen shut? In V9 brine stays open, but flow 0 due to connectivity? For demo we model 0
def flowRateAt (T : Int) : Nat :=
  if brineChannelOpen T then 50 else 0 -- 50 = 0.5 * SCALE

def powerAt (T : Int) : Nat :=
  25 * 981 * (flowRateAt T) -- code

theorem power_at_minus1 : powerAt (-1) = 1226250 := by rfl
theorem power_at_0 : powerAt 0 = 0 := by rfl

-- externalG vs effectiveG split preserved from V9
structure Container where
  externalG : ScaledQuantity
  effectiveG : ScaledQuantity

def earth : Container := { externalG := g981, effectiveG := g981 }
def freeFall : Container := { externalG := g981, effectiveG := { code := 0, scale := SCALE } }

#eval (powerCode.toFloat / powerScaleCorrect.toFloat) -- 122.625

