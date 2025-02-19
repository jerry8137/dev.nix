{ pkgs, config, ... }:

{
  programs.fish = {
    enable = true;
    shellAliases = {
      update = "nix run nixpkgs#home-manager -- switch --flake ~/kickstart.nix#x86_64-linux  --impure";
      ls = "eza --icons=auto";
      config = "/run/current-system/sw/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME";
      glol = "git log --graph --pretty=\"%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset\"";
      glola = "git log --graph --pretty=\"%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset\" --all";
    };
    shellAbbrs = {
      ff = "fastfetch";
      gst = "git status";
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
      set -x SDC_SHELL_ENV /home/jerry/.sdc-shell-env
      bind \cf 'tms'
      bind \cb 'tmux a'
      . "/home/jerry/miniconda3/etc/fish/conf.d/conda.fish"
      if status is-login; or set -q SSH_TTY
        fish_add_path --path /home/jerry/.nix-profile/bin
        fish_add_path --path /home/jerry/.local/bin
        fish_add_path --path /nix/var/nix/profiles/default/bin
      end
    '';
    functions = {
      extract = '' 
      function extract
        switch $argv[1]
            case "*.tar.bz2"
                tar xjf $argv[1]

            case "*.tar.gz"
                tar xzf $argv[1]

            case "*.bz2"
                bunzip2 $argv[1]

            case "*.rar"
                unrar e $argv[1]

            case "*.gz"
                gunzip $argv[1]

            case "*.tar"
                tar xf $argv[1]

            case "*.tbz2"
                tar xjf $argv[1]

            case "*.tgz"
                tar xzf $argv[1]

            case "*.zip"
                unzip $argv[1]

            case "*.Z"
                uncompress $argv[1]

            case "*.7z"
                7z x $argv[1]

            case "*"
                echo "unknown extension: $argv[1]"
        end
      end
      '';

      extracttodir = '' 
        function extracttodir
          switch $argv[1]
              case "*.tar.bz2"
                  tar -xjf $argv[1] -C "$argv[2]"

              case "*.tar.gz"
                  tar -xzf $argv[1] -C "$argv[2]"

              case "*.rar"
                  unrar x $argv[1] "$argv[2]/"


                  tar -xf $argv[1] -C "$argv[2]"

              case "*.tbz2"
                  tar -xjf $argv[1] -C "$argv[2]"

              case "*.tgz"
                  tar -xzf $argv[1] -C "$argv[2]"

              case "*.zip"
                  unzip $argv[1] -d $argv[2]

              case "*.7z"
                  7za e -y $argv[1] -o"$argv[2]"

              case "*"
                  echo "unknown extension: $argv[1]"
          end
        end
      '';

      ytarchive = '' 
        function ytarchive
         yt-dlp -f bestvideo[height<=1080][ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best -o '%(upload_date)s - %(channel)s - %(id)s - %(title)s.%(ext)s' \
         --sponsorblock-mark "all" \
         --geo-bypass \
         --sub-langs 'all' \
         --embed-subs \
         --embed-metadata \
         --convert-subs 'srt' \
         --download-archive $argv[1].txt https://www.youtube.com/$argv[1]/videos; 
        end
      '';

      ytarchivevideo = '' 
        function ytarchivevideo
          yt-dlp -f bestvideo[height<=1080][ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best -o '%(upload_date)s - %(channel)s - %(id)s - %(title)s.%(ext)s' \
         --sponsorblock-mark "all" \
         --geo-bypass \
         --sub-langs 'all' \
         --embed-metadata \
         --convert-subs 'srt' \
         --download-archive $argv[1] $argv[2]; 
        end
      '';

      ytd = '' 
        function ytd
         yt-dlp -f bestvideo[height<=1080][ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best -o '%(upload_date)s - %(channel)s - %(id)s - %(title)s.%(ext)s' \
         --sponsorblock-mark "all" \
         --geo-bypass \
         --sub-langs 'all' \
         --embed-subs \
         --embed-metadata \
         --convert-subs 'srt' \
         $argv
        end
      '';
    };
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
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };
}
