# Hpof V10 - Spatial Draft

**Based on:** `v9.0.0-snapshot-final` (locked)
**Status:** Draft, `sorry` theorems expected, bare Lean 4

This branch imports V9 snapshot as foundation and adds real geometry.

## New types

- `Cell { x y z : Nat }` - discrete lattice, `adjacent`, `distanceManhattan`
- `Channel { cells : List Cell }` - path, `isConnected`, `isOpenAt T` reuses `brineChannelOpen T` from V9
- `Flow { channel, mass : ScaledQuantity, velocityCode, temperature }` - active only if channel connected AND open

## What V9 proved vs V10 proves

V9: Bool snapshot `isFrozen T`, phase boundary, density ordering, scaled power
V10: `Channel.isConnected`, `Flow.isActive -> powerExact`, zero when closed/disconnected

## Build

```bash
lake build
```

## Future theorems for V10

- `flow_zero_when_closed`
- `flow_zero_when_disconnected`
- `mass_conservation` (needs graph theory, will need Mathlib)
- `path_exists_if_open` (BFS)

V9 stays green without Mathlib. V10 can add Mathlib when ready for graph search.
