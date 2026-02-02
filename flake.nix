{
  outputs =
    { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      packages.${system}.alias-finder-nu = pkgs.callPackage ./alias-finder-nu { };
      packages.${system}.pano-scrobbler = pkgs.callPackage ./pano-scrobbler { };
    };
}
