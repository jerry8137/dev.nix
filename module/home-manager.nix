{
  homeDirectory,
  username,
}: {pkgs, ...}: {
  imports = [
    ./git.nix
    ./zsh.nix
  ];
  # add home-manager user settings here
  home.homeDirectory = homeDirectory;
  home.username = username;
  home.packages = with pkgs; [
    git
    neovim
    btop
    curl
    wget
    fzf
    ripgrep
    gcc
    luarocks
    gem
    tree-sitter
  ];
  home.stateVersion = "23.11";
  home.file = {
    ".config/nvim" = {
      source = ../submodules/nvim;
      recursive = true;
    };
  };
}
