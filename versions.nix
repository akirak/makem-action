{ minVersion ? "26.1" }:
with builtins;
let
  flake = getFlake "github:akirak/makem.nix";
  allVersions = flake.outputs.emacs-ci-versions.${builtins.currentSystem};
in
filter (name:
  let
    version = replaceStrings ["emacs-" "-"] ["" "."] name;
  in
    compareVersions version minVersion >= 0
) allVersions
