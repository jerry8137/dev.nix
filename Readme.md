# nix/flake/home-manager

## Dotfiles

Clone the dotfiles to here and nix will link them:
`git clone DOTFILES /home/jerry/dotfiles`

## Build/Switch

```bash
nix run nixpkgs#home-manager -- build --flake ~/kickstart.nix#x86_64-linux  --impure
nix run nixpkgs#home-manager -- switch --flake ~/kickstart.nix#x86_64-linux  --impure
```

## Set default shell to zsh

1. Add `which zsh` to `/etc/shell`
2. `chsh -s $(which zsh)`

## Daily usage

update nix conifg: `update`
