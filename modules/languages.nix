{ config, pkgs, ... }:

{
  # programs.jdk = { enable = true; };
  home.packages = with pkgs; [ gcc python3 ];
}
