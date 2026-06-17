{
  outputs =
    { self, nixpkgs, ... }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      forEachSystem =
        f: nixpkgs.lib.genAttrs systems (system: f system (import nixpkgs { inherit system; }));
    in
    {
      packages = forEachSystem (
        system: pkgs:
        {
          program-chooser = pkgs.callPackage ./pkgs/program-chooser { };
        }
        # the following is for only x86
        // pkgs.lib.optionalAttrs pkgs.stdenv.hostPlatform.isx86_64 {
          alias-finder-nu = pkgs.callPackage ./pkgs/alias-finder-nu { };
          say = pkgs.callPackage ./pkgs/say { };
          taskopen = pkgs.callPackage ./pkgs/taskopen { };
          pix2text = pkgs.callPackage ./pkgs/pix2text { };
          ryubing = pkgs.callPackage ./pkgs/ryubing { };
          sticker-convert = pkgs.callPackage ./pkgs/sticker-convert { };
          tokei-all = pkgs.callPackage ./pkgs/tokei-all { };
          gtasks-bin = pkgs.callPackage ./pkgs/gtasks-bin { };
          proton-gdk = pkgs.callPackage ./pkgs/proton-gdk { };
          minecraft-console-client = pkgs.callPackage ./pkgs/minecraft-console-client { };
          # Not completed
          # gtasks = pkgs.callPackage ./pkgs/gtasks { };
        }
        # the following is for only aarch64
        // pkgs.lib.optionalAttrs pkgs.stdenv.hostPlatform.isAarch64 {
          # som-package = pkgs.callPackage ./pkgs/some-package { };
        }
      );
    };
}
