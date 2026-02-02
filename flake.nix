{
  outputs =
    { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      packages.${system} = {
        alias-finder-nu = pkgs.callPackage ./pkgs/alias-finder-nu { };
        pano-scrobbler = pkgs.callPackage ./pkgs/pano-scrobbler { };
        2048 = pkgs.callPackage ./pkgs/2048 { };
        pix2text = pkgs.callPackage ./pkgs/pix2text { };
        program-chooser = pkgs.callPackage ./pkgs/program-chooser { };
        taskopen = pkgs.callPackage ./pkgs/taskopen { };
        tokei-all = pkgs.callPackage ./pkgs/tokei-all { };
      };
    };
}
