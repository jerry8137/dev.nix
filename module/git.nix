{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings.user.name = "Jerry Hou";
    settings.user.email = "jerry8137@gmail.com";
  };
}
