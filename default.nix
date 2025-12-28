{ withCcache ? false, # Enable ccache. Requires correct permissions, see overlay.nix.
  smp ? false, # Enable multcore support (SMP)
  nixpkgs
}:

let
  actualPkgs = nixpkgs;
  inherit (actualPkgs) pkgsIncludeOS;
in
  assert (pkgsIncludeOS.stdenv.hostPlatform.isLinux == false) ->
    throw "Currently only Linux builds are supported";
  assert (pkgsIncludeOS.stdenv.hostPlatform.isMusl == false) ->
    throw "Stdenv should be based on Musl";

  pkgsIncludeOS.includeos
