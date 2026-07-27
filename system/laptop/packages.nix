{config, lib, pkgs, nixpkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    unstable.spotify
    playerctl
    #obsidian
    jq
    steam
    #prusa-slicer
    #android-studio
    #wine
    winetricks
    wineWowPackages.stable
    lshw
    #discord-screenaudio
    #nvidia-prime
    #nvidia-x11
    #nvidia-settings
    #nvidia-persistenced
    gptfdisk
    gparted
    lutris
    godot
    #unityhub
    unrar
    obs-studio-plugins.obs-vkcapture
    pixelorama
    beeper
    tmux
    vial
    #teamviewer
    cargo-generate
    steel # rust embeddable sceme language
    #python3
    #wireguard-ui
    #wireguard-tools

    libusb1
    rtl-sdr
    gqrx
    #ventoy
    pix
    direnv

    orca-slicer
    (heroic.override {
      extraPkgs = pkgs': with pkgs'; [
        gamescope
        gamemode
      ];
    })

    #fuse-overlayfs
    exercism
    unstable.codecrafters-cli

    SDL2
    sigdigger
    nfs-utils

    wireshark
    nmap
    metasploit

    xorg.libX11
    lix
    #dotnet-runtime_8
    #dotnet-runtime_9
    dotnet-runtime_10
    #dotnet-runtime_10

    vulkan-loader
    vulkan-tools
    vulkan-validation-layers
    dxvk
    vkd3d-proton

    picotool
    feh
    ffmpeg
    ripgrep
    github-cli
    keet
    nload

    gtk4
    gtk4-layer-shell
    pkg-config
    glib
    pango
    
    openscad
    openscad-lsp
  ];
}
