import Lake
open Lake DSL

package hpof_spatial where
  version := v!"10.0.0-draft"

@[default_target]
lean_lib Hpof where
  globs := #[.submodules `Hpof]
