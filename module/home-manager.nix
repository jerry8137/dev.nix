{
  homeDirectory,
  username,
}: {pkgs, config, ...}: {
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
    eza
    cargo
    tmux
    tmux-sessionizer
    filezilla
    nvtop
    fastfetch
    alacritty
  ];
  home.stateVersion = "23.11";
  home.file = {
    ".config/nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/jerry/dotfiles/.config/nvim";
    };
    ".config/tmux/tmux.conf" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/jerry/dotfiles/.config/tmux/.tmux.conf";
    };
    ".config/tmux/tmux.conf.local" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/jerry/dotfiles/.config/tmux/.tmux.conf.local";
    };
    ".config/alacritty" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/jerry/dotfiles/.config/alacritty";
    };
  };
  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
