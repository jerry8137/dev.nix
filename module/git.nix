{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Jerry Hou";
    userEmail = "jerry8137@gmail.com";
  };
}
