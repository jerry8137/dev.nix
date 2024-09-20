{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Jerry Hou";
    userEmail = "chunyu.hou@itri.org.tw";
  };
}
