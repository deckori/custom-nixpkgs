{ pkgs, ... }:

pkgs.writeShellApplication {
  name = "program-chooser";
  text = builtins.readFile ./program-chooser.sh;
}
