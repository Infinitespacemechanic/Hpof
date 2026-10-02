import Lake
open Lake DSL

package hpof_snapshot where
  version := v!"9.0.0"

@[default_target]
lean_lib Hpof where
  globs := #[.submodules `Hpof]
