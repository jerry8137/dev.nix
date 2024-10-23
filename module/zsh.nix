{ pkgs, config,  ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      update = "nix run nixpkgs#home-manager -- switch --flake ~/kickstart.nix#x86_64-linux  --impure";
      ls = "eza --icons=auto";
      ff = "fastfetch";
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
      export PATH="$HOME/.local/bin:$PATH"
      bindkey -s '^F' 'tms\n'
      bindkey -s '^B' 'tmux a\n'
      alias config='/run/current-system/sw/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
      export DISPLAY=:0
      export SDC_DOCKER_CONTAINER_WORKING_DIRECTORY="/home/jerry/codespace/sdc/ros"
      export SDC_DOCKER_USER_OPTIONS=" \
          --env ROS_HOME=/home/jerry/.ros \
          --env ROS_MASTER_URI=http://53-0B20827-03:11311 \
          --env SDC_CONFIG_DIR=/home/jerry/codespace/sdc/vehicle-configuration/pacifica-4 \
          --env SDC_BLACK_WIDOW_ENV_LOADER="" \
          --env MAP_DATA_PATH="/semantic_map" \
          --env SDC_ROUTE="itri" \
          --env SDC_CUDA_ARCH="8.6" \
      "
      export SDC_DOCKER_USER_VOLUMES=" \
          /home/jerry/.ros:/home/jerry/.ros:rw \
          /home/jerry/.sdc:/home/jerry/.sdc:rw \
          /home/jerry/codespace/sdc:/home/jerry/codespace/sdc:rw \
          /home/jerry/codespace/sdc-workspace:/workspace:rw \
          /mnt/ssd/bags:/bagfiles:ro \
          /mnt/ssd/bag_record:/data/bag_record:rw \
          /data/semantic-maps:/semantic_map:rw \
          /data/pcd-maps:/data/pcd-maps:ro \
      "
      export SDC_DOCKER_SSL_VERIFICATION_ENABLED=false

      # >>> conda initialize >>>
      # !! Contents within this block are managed by 'conda init' !!
      __conda_setup="$('/home/jerry/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
      if [ $? -eq 0 ]; then
          eval "$__conda_setup"
      else
          if [ -f "/home/jerry/miniconda3/etc/profile.d/conda.sh" ]; then
              . "/home/jerry/miniconda3/etc/profile.d/conda.sh"
          else
              export PATH="/home/jerry/miniconda3/bin:$PATH"
          fi
      fi
      unset __conda_setup
      # <<< conda initialize <<<

      # >>> mamba initialize >>>
      # !! Contents within this block are managed by 'micromamba shell init' !!
      export MAMBA_EXE='/home/jerry/bin/micromamba';
      export MAMBA_ROOT_PREFIX='/home/jerry/micromamba';
      __mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
      if [ $? -eq 0 ]; then
          eval "$__mamba_setup"
      else
          alias micromamba="$MAMBA_EXE"  # Fallback on help from micromamba activate
      fi
      unset __mamba_setup
      # <<< mamba initialize <<<
    '';

  };
  programs.fzf.enable = true;
}
