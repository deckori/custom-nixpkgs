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
        # The desktop version is bugged. Web scrobbler is a better alternative
        # pano-scrobbler = pkgs.callPackage ./pkgs/pano-scrobbler { };
        pix2text = pkgs.callPackage ./pkgs/pix2text { };
        ryubing = pkgs.callPackage ./pkgs/ryubing { };
        program-chooser = pkgs.callPackage ./pkgs/program-chooser { };
        taskopen = pkgs.callPackage ./pkgs/taskopen { };
        say = pkgs.callPackage ./pkgs/say { };
        tokei-all = pkgs.callPackage ./pkgs/tokei-all { };
      };
    };
}
