import Mathlib.Data.Real.Basic
import Mathlib.Tactic

-- 1. Location is a place name
abbrev Location := String

-- 2. accumulation and gravity_effect as FUNCTIONS
-- Use if/then/else, not pattern matching on String
def accumulation (loc : Location) : ℝ :=
  if loc = "ground_zero" then 1 + 0.0472 else 1

def pressure (loc : Location) : ℝ :=
  accumulation loc * 10

def gravity_effect (loc : Location) : ℝ :=
  pressure loc -- ΔP = mass / area : gravity IS pressure effect

-- 3. The place
def ground_zero : Location := "ground_zero"
def center_point : Location := "ground_zero"

-- 4. Your theorem - ground zero is a location where effect > 0
theorem gravity_at_ground_zero_pos :
  accumulation ground_zero > 0 ∧ gravity_effect ground_zero > 0 := by
  constructor
  · unfold accumulation ground_zero
    simp
    linarith
  · unfold gravity_effect pressure accumulation ground_zero
    simp
    linarith

-- Always Something Never Nothing >0
theorem always_something (loc : Location) : accumulation loc > 0 := by
  unfold accumulation
  split_ifs
  · linarith
  · linarith