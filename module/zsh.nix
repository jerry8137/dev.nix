{ pkgs, config,  ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      update = "nix run nixpkgs#home-manager -- switch --flake ~/kickstart.nix#x86_64-linux  --impure";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "fzf" ];
      theme = "robbyrussell";
    };
    initExtra = ''
      bindkey -s '^F' 'tms\n'
      bindkey -s '^B' 'tmux a\n'
      alias config='/run/current-system/sw/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
    '';

  };
  programs.fzf.enable = true;
}
