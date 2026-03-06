{config, lib, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    unstable.spotify
    playerctl
    obsidian
    jq
    steam
    prusa-slicer
    #android-studio
    wine
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
    unityhub
    unrar
    obs-studio-plugins.obs-vkcapture
    beeper
    tmux
    vial
    unstable.codecrafters-cli
    teamviewer

    libusb1
    rtl-sdr
    gqrx
    #ventoy
    pix
    direnv
  ];
}
