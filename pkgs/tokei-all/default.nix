{ pkgs, ... }:

pkgs.writeShellApplication {
  name = "tokei-all";
  text = ''
    find . -name '*.?*' -type f | rev | cut -d. -f1 | rev  | tr '[:upper:]' '[:lower:]' | sort | uniq --count | sort -n
  '';
}
