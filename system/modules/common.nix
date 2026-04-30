{config, pkgs, unstable, ...}:
{
  environment.systemPackages = with pkgs; [
    home-manager
    neovim
    htop
    fortune
    git
    git-credential-manager
    appimage-run
    lsd
    stdenv.cc.cc.lib
    zsh
    curl
    unzip
    zip
    mesa-demos
    fish
    fluxbox
    unrar
    tmux

    logmein-hamachi
    unstable.tailscale

    alacritty
    waybar
    wofi
    xorg.xinit
    xorg.xauth
    firefox
    sway
    transmission_4-qt
    vlc

    grim
    slurp
    swappy
    chromium
    swaybg
    speedtest-cli

    elf2uf2-rs
    cargo-cross
    rustup
    tree-sitter
    nodejs
    nixd
    busybox
    cargo
    gcc
    clang
    rust-analyzer
    vscode-langservers-extracted

    transmission_4
  ];
}
