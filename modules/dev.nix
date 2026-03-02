{ config, pkgs, ... }:

{
  # programs.jdk = { enable = true; };
  home.packages = with pkgs; [
    cargo
    clang-tools
    gcc
    go
    python3
    valgrind
  ];
}
