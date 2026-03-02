{ config, pkgs, ... }:

{
  # programs.jdk = { enable = true; };
  home.packages = with pkgs; [
    cargo
    clang-tools
    docker-compose
    gcc
    go
    gradle
    jdk21
    python3
    valgrind
  ];
}
