import Lake
open Lake DSL

package hpof where
  version := v!"10.0.0-draft"

@[default_target]
lean_lib Hpof where
lean_lib Snapshot where
lean_lib V10 where
lean_lib Hpof.Spatial where
lean_lib Hpof.Spatial.Cell where
lean_lib Hpof.Spatial.Channel where
lean_lib Hpof.Spatial.Flow where
