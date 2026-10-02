# Hpof V5.2 — Snapshot Model + Physical Proof
**No runs, drips, or errors. This happens for real.**

Hpof V5 moves from generic gas to physical water: fresh vs salt with different freezing points, brine channels as fibers, and gravity power in free fall. V5.2 adds the physical analog that proves the Lean — Bay of Fundy half-frozen zone.

## Core Idea
> Lattice doesn't appear until frozen. Salt and fresh freeze at different points. Freeze the picture and two like but different masses will have different pathways.

Standard tracers track where mass *is*. Hpof tracks where mass *was*.

### Triad
1. **Container (Shape)** — Holds snapshot. `earthJar` at 9.81 g, `freeFallJar` for free fall. In nature, container = bathymetry of bay.
2. **Mass** — Fresh `1000.0` vs Salt `1025.0`. Density difference creates stratification.
3. **Mass Reaction** — Fresh freezes at `0°C`, Salt at `-2°C`. When fresh freezes, salt rejected into brine channels. Channel = fiber = breadcrumb where mass was.

Power: `P = Δm * g * v` or `rotation = down * friction * Δm`

## Physical Analog That Proves Lean: Bay of Fundy Half-Frozen Zone

### Location: Old Sow Whirlpool
The Old Sow whirlpool is located off the southwestern shore of Deer Island, New Brunswick between the island and Eastport, Maine. Largest tidal whirlpool in Western Hemisphere, 250 ft diameter.

### Cause: Container + Mass + Rotation from Earth/Moon Fly-by
The whirlpool is caused by local bathymetry and a 20-foot tidal range where waters exchange between Passamaquoddy Bay and the Bay of Fundy.
The combination of bathymetry, tidal phase shifts, and Coriolis effects caused by Earth's rotation give birth to the Old Sow.
Coriolis force causes rotary tides.
Enormous masses of water clash against each other and against the island's irregular topography.

### Lean Maps to Real World
- Container = Bay shape 322km long, narrow, sea floor mounts = container walls
- density fresh 1000 = River fresh water
- density salt 1025 = Atlantic salt
- pathway (-1) fresh true = Fresh ice lattice in Jan
- pathway (-1) salt false = Salt sea liquid
- interfaceAt (-1) true = Half-frozen zone: fresh ice raft on top, salty sea below, brine channels = fibers
- gravityPower = Moon fly-by twice daily, 40ft tides
- rotationFromFriction = Friction of opposite currents over sea mounts = Old Sow spin

### Summer vs Deep Winter

**Summer (T > 0):** Both liquid. Fresh rides over salt. Shear = rotation. Power from Moon tides.

**Deep Winter (T = -1) — Half Frozen Zone:** Fresh ice lattice on top, salty sea liquid below. Brine rejected from ice sinks down ice walls — friction creates vortex filament inside ice. Tide cracks it, upwelling brings salt up through channels.

Lean test: interfaceAt (-1) .fresh .salt = true in lab AND true in Fundy in January

### Why This Proves Hpof
1. No internal Energy needed — Power is Moon + Earth rotation (fly-by), not m*r^2
2. Rotation from friction from down — Down = sinking brine or tidal exchange, friction = ice lattice or sea floor, Δm = 25 kg/m3 = spin
3. Pathway where mass was — Brine channel = fiber that stays after salt leaves
4. Container holds it — Without Bay bathymetry, no Old Sow. Without jar, no interface.

### Files
- HpofV5.lean — V5 base
- HpofV5_2.lean — V5.2 adds shear + rotationFromFriction + halfFrozenZone proof
