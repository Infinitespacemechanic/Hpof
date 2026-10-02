-- V10.lean - V10 entry, imports V9 + Spatial
-- This does NOT modify Hpof.lean (V9). It layers on top.
import Hpof
import Hpof.Spatial

-- V9 still works
#eval Hpof.Spatial.Channel.brineChannelOpen (-1) -- true
#eval Hpof.Spatial.Channel.brineChannelOpen 0 -- false

-- V10 new
#eval Hpof.Spatial.Channel.Channel.isOpenAt (-1) .fresh .salt
#eval Hpof.Spatial.Flow.powerAt (-1) -- 1226250
#eval Hpof.Spatial.Flow.powerAt 0 -- 0
#eval (Hpof.Spatial.Flow.powerCode.toFloat / Hpof.Spatial.Flow.powerScaleCorrect.toFloat) -- 122.625 W

-- V10 theorems remain rfl/decide
example : Hpof.Spatial.Channel.brineChannelOpen (-1) = true := by rfl
example : Hpof.Spatial.Channel.brineChannelOpen 0 = false := by rfl
example : Hpof.Spatial.Flow.powerAt (-1) = 1226250 := by rfl
