{ pkgs, config, ... }:

{
  programs.fish = {
    enable = true;
    shellAliases = {
      update = "nix run nixpkgs#home-manager -- switch --flake ~/kickstart.nix#x86_64-linux  --impure";
      ls = "eza --icons=auto";
      ff = "fastfetch";
      config="/run/current-system/sw/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME";
      gst="git status";
      glol="git log --graph --pretty=\"%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset\"";
      glola="git log --graph --pretty=\"%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset\" --all";
    };
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      set -x DISPLAY :0
      set -x SDC_DOCKER_CONTAINER_WORKING_DIRECTORY "/home/jerry/codespace/sdc/ros"
      set -x SDC_DOCKER_USER_OPTIONS " \
          --env ROS_HOME=/home/jerry/.ros \
          --env ROS_MASTER_URI=http://53-0B20827-03:11311 \
          --env SDC_CONFIG_DIR=/home/jerry/codespace/sdc/vehicle-configuration/pacifica-4 \
          --env SDC_BLACK_WIDOW_ENV_LOADER="" \
          --env MAP_DATA_PATH="/semantic_map" \
          --env SDC_ROUTE="itri" \
          --env SDC_CUDA_ARCH="8.6" \
      "
      set -x SDC_DOCKER_USER_VOLUMES " \
          /home/jerry/.ros:/home/jerry/.ros:rw \
          /home/jerry/.sdc:/home/jerry/.sdc:rw \
          /home/jerry/codespace/sdc:/home/jerry/codespace/sdc:rw \
          /home/jerry/codespace/sdc-workspace:/workspace:rw \
          /home/jerry/codespace/sdc-for-paper:/home/jerry/codespace/sdc-for-paper:rw \
          /mnt/ssd/bags:/bagfiles:ro \
          /mnt/ssd/bag_record:/data/bag_record:rw \
          /data/semantic-maps:/semantic_map:rw \
          /data/pcd-maps:/data/pcd-maps:ro \
      "
      set -x SDC_DOCKER_SSL_VERIFICATION_ENABLED false
      bind \cf 'tms'
      bind \cb 'tmux a'
      . "/home/jerry/miniconda3/etc/fish/conf.d/conda.fish"
    '';
    plugins = [
      # Enable a plugin (here grc for colorized command output) from nixpkgs
      { name = "grc"; src = pkgs.fishPlugins.grc.src; }
      # Manually packaging and enable a plugin
      {
        name = "z";
        src = pkgs.fetchFromGitHub {
          owner = "jethrokuan";
          repo = "z";
          rev = "e0e1b9dfdba362f8ab1ae8c1afc7ccf62b89f7eb";
          sha256 = "0dbnir6jbwjpjalz14snzd3cgdysgcs3raznsijd6savad3qhijc";
        };
      }
    ];
  };
}
