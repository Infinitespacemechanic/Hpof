# Hpof V10 Spatial - Draft

Branch: v10-spatial-draft
Based on: main @ 76a463e V9 final

## What V9 provides (unchanged in main)
- Fin 24 clock, step 3, gcd=3 => 3 chains len 8
- isFrozen, phaseBoundaryAt, brineChannelOpen
- ScaledQuantity single source of truth, P=m g v exact Nat
- externalG vs effectiveG split

## What V10 adds (in this branch only)
- Hpof/Spatial/Cell.lean: Cell {x,y,z}, isNeighbor, neighbor_symm
- Hpof/Spatial/Channel.lean: WaterKind, freezePoint, Channel.isOpenAt, isConnected, brine_open_at_minus1 proof
- Hpof/Spatial/Flow.lean: flowRateAt T, powerAt T, power_exact_eq, power_at_minus1 rfl, earth vs freeFall Container
- Hpof/Spatial.lean: aggregate import
- V10.lean: demo entry, #eval power split -1C vs 0C

## Build
lake build -- still builds V9 via Hpof.lean
lake build V10 -- builds V10 spatial layer

All theorems rfl/decide green, no axioms, no native_decide, no Float rfl.

## What V10 does NOT claim yet
- No mass transport, no conservation law proof (next: V11)
- No real salinity curve, symbolic WaterKind only
- Float 122.625 is #eval demo, not proof
