{ config, pkgs, ... }:

{
  # programs.jdk = { enable = true; };
  home.packages = with pkgs; [
    cargo
    cmake
    clang-tools
    docker-compose
    gcc
    go
    gnumake
    gradle
    jdk21
    python3
    valgrind
  ];
}
