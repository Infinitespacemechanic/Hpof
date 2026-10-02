-- Hpof V9 - Symbolic Snapshot Model - Final Upload
-- Bare Lean 4, all rfl/decide green, no axioms

def SCALE : Nat := 100
def SCALE2 : Nat := 10000

inductive WaterType where
  | fresh
  | salt
deriving DecidableEq, Repr

inductive Direction where
  | rises
  | sinks
  | stays
deriving DecidableEq, Repr

def freezePoint : WaterType → Int
  | .fresh => 0
  | .salt => -2

def densityCode : WaterType → Nat
  | .fresh => 100
  | .salt => 103

-- Runtime display density; densityCode is formal comparison representation
def densityDisplay : WaterType → Float
  | .fresh => 1.0
  | .salt => 1.03

/-- Snapshot of whether this material is frozen at temperature T -/
def isFrozen (T : Int) (w : WaterType) : Bool :=
  T <= freezePoint w

def pathway := isFrozen

def phaseBoundaryAt (T : Int) (a b : WaterType) : Bool :=
  isFrozen T a != isFrozen T b

def interfaceAt := phaseBoundaryAt

def brineChannelOpen (T : Int) : Bool :=
  phaseBoundaryAt T .fresh .salt

/-- Relative motion of a compared with b under gravity -/
def relativeMotion (a b : WaterType) : Direction :=
  if densityCode a < densityCode b then .rises
  else if densityCode a > densityCode b then .sinks
  else .stays

def pathwayInFreeFall := relativeMotion

structure ScaledQuantity where
  code : Nat
  scale : Nat := SCALE
  -- Invariant: physical value = code / scale
deriving Repr

def ScaledQuantity.toFloat (q : ScaledQuantity) : Float :=
  Float.ofNat q.code / Float.ofNat q.scale

def gravityPower (mass g velocity : Float) : Float :=
  mass * g * velocity

def gravityPowerScaled10000 (mass gCode velocityCode : Nat) : Nat :=
  mass * gCode * velocityCode

structure Container where
  name : String
  externalG : ScaledQuantity
  effectiveG : ScaledQuantity
deriving Repr

def Container.externalGFloat (c : Container) : Float := c.externalG.toFloat
def Container.effectiveGFloat (c : Container) : Float := c.effectiveG.toFloat

def earthJar : Container :=
  { name := "earthJar"
    externalG := { code := 981, scale := SCALE }
    effectiveG := { code := 981, scale := SCALE } }

def freeFallJar : Container :=
  { name := "freeFall"
    externalG := { code := 981, scale := SCALE }
    effectiveG := { code := 0, scale := SCALE } }

def containerGravityPowerExact (c : Container) (mass vCode : Nat) : Nat :=
  gravityPowerScaled10000 mass c.effectiveG.code vCode

def externalGravityPowerExact (c : Container) (mass vCode : Nat) : Nat :=
  gravityPowerScaled10000 mass c.externalG.code vCode

def containerGravityPower (c : Container) (mass velocity : Float) : Float :=
  gravityPower mass c.effectiveGFloat velocity

def externalGravityPower (c : Container) (mass velocity : Float) : Float :=
  gravityPower mass c.externalGFloat velocity

structure Snapshot where
  water : WaterType
  temperature : Int
  mass : ScaledQuantity
deriving Repr

def Snapshot.massFloat (s : Snapshot) : Float := s.mass.toFloat
def isFrozenSnapshot (s : Snapshot) : Bool := isFrozen s.temperature s.water

def snapshotPowerInContainer (c : Container) (s : Snapshot) (v : Float) : Float :=
  containerGravityPower c s.massFloat v

def snapshotPower := snapshotPowerInContainer

-- Clock from V3-V4 preserved for 24x15=360 lineage
def N : Nat := 24
def step : Nat := 3
abbrev Clock : Type := Fin N

def addStep : Clock → Clock
  | ⟨k, _⟩ => ⟨(k + step) % N, Nat.mod_lt _ (by decide)⟩

def eightOrbit (start : Clock) : List Clock :=
  let c0 := start
  let c1 := addStep c0
  let c2 := addStep c1
  let c3 := addStep c2
  let c4 := addStep c3
  let c5 := addStep c4
  let c6 := addStep c5
  let c7 := addStep c6
  [c0, c1, c2, c3, c4, c5, c6, c7]

def deg (k : Clock) : Nat := k.val * 15
theorem deg_lt_360 : ∀ k : Clock, deg k < 360 := by decide

-- Runtime demos only
#eval isFrozen 0 .fresh
#eval isFrozen (-1) .salt
#eval phaseBoundaryAt (-1) .fresh .salt
#eval brineChannelOpen (-1)
#eval relativeMotion .fresh .salt
#eval gravityPower 25.0 9.81 0.5
#eval containerGravityPower earthJar 25.0 0.5
#eval containerGravityPower freeFallJar 25.0 0.5
#eval gravityPowerScaled10000 25 981 50

-- All kernel-reducible theorems
theorem fresh_rises_over_salt : relativeMotion .fresh .salt = .rises := by rfl
theorem salt_sinks_under_fresh : relativeMotion .salt .fresh = .sinks := by rfl
theorem fresh_stays_over_fresh : relativeMotion .fresh .fresh = .stays := by rfl

theorem brine_open_at_minus1 : brineChannelOpen (-1) = true := by rfl
theorem brine_closed_at_minus3 : brineChannelOpen (-3) = false := by rfl
theorem phase_boundary_at_minus1 : phaseBoundaryAt (-1) .fresh .salt = true := by rfl
theorem no_phase_boundary_at_minus3 : phaseBoundaryAt (-3) .fresh .salt = false := by rfl

theorem exact_power_122_625 : gravityPowerScaled10000 25 981 50 = 1226250 := by rfl
theorem exact_earth_power : containerGravityPowerExact earthJar 25 50 = 1226250 := by rfl
theorem exact_freefall_effective_zero : containerGravityPowerExact freeFallJar 25 50 = 0 := by rfl
theorem exact_freefall_external : externalGravityPowerExact freeFallJar 25 50 = 1226250 := by rfl

theorem eightOrbit_cover : ∀ k : Clock,
  k ∈ eightOrbit ⟨0, by decide⟩ ∨
  k ∈ eightOrbit ⟨1, by decide⟩ ∨
  k ∈ eightOrbit ⟨2, by decide⟩ := by decide

theorem iter8_closes_test : ∀ k : Clock, (addStep^[8] k) = k := by decide
