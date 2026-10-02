# Hpof V9 - Symbolic Snapshot Model - Final

**Version:** 9.0.0-snapshot-final
**Status:** Bare Lean 4, no axioms, all `rfl`/`decide` green, `#eval` demo only

## What it proves (kernel-checked)

- 24-state clock `Fin 24`, step `3`, `gcd(3,24)=3` => 3 chains of length 8
- `iter8_closes`, `eightOrbit_cover`, `fibers_cover_sphere`, `sphere_finite_N`
- `fibers_disjoint` by radius
- Frozen-state snapshot `isFrozen T w := T <= freezePoint w`
- Phase boundary `phaseBoundaryAt T a b := isFrozen T a != isFrozen T b`
- `brineChannelOpen T := phaseBoundaryAt T .fresh .salt`
- Relative motion from discrete density ordering `densityCode fresh=100 salt=103`
- Power `P = m g v` with exact scaled Nat arithmetic
- Container `externalG` vs `effectiveG` split: earth 9.81/9.81, freeFall 9.81/0.0

## What it demos (runtime, not proof)

- Float `122.625 W` via `#eval`

## Design fix from V8

Single source of truth: stores only `ScaledQuantity { code, scale }`, Float derived via `code/scale`. No `{ mass: Float, massCode: Nat }` pair that can diverge.

```
-- V8 bad: could diverge
{ mass := 25.0, massCode := 17 }

-- V9 good: one field
mass : ScaledQuantity
massFloat = toFloat = code / scale
```

## Scale

`SCALE = 100`, so `9.81 -> 981`, `0.5 -> 50`, result scale `10000`
`25 * 981 * 50 = 1226250` represents `122.625 * 10000`

## What it does NOT claim

- No spatial channel geometry, no flow, no mass transport
- No physical energy law, no real air/nitrogen mass, no real salinity curve
- `AirShell`, `NitrogenShell`, `salt`, `fresh` are symbolic categories

## Build

```bash
lake build
```

All theorems `rfl` green, no `native_decide` needed, no Float `rfl`.

## Next: V10 Spatial

V10 will be separate folder `hpof_spatial` importing V9, adding `Cell`, `Channel`, `Flow`, connectivity, conservation. Not part of this upload.
