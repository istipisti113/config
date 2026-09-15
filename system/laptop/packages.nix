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
    #go_1_26
    #(pkgs.discordo.override {
    #  buildGoModule = pkgs.buildGoModule.override {
    #    go = pkgs.go_1_26;
    #  };
    #})

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
    python3
    #wireguard-ui
    #wireguard-tools
    tree

    libusb1
    rtl-sdr
    gqrx
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

    #gtk4
    #gtk4-layer-shell
    #pkg-config
    #glib
    #glib.dev
    #gobject-introspection
    #cairo
    #pango
    
    openscad
    openscad-lsp

    doctoc
    vscode
    inkscape

    inetutils #telnet for connecting to the mks tinybee
    websocat
    esptool

    pv #progress bar
    openssl.dev
    openssl

    woeusb
    ntfs3g
    ventoy
  ];
}
