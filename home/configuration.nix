# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

let
  home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz;
  nurpkgs = import (builtins.fetchTarball {
    url = "https://github.com/nix-community/NUR/archive/main.tar.gz";
  }) { inherit pkgs; };
  unstable = import (fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-unstable") {
    config.allowUnfree = true;
  };

in{
  nix.settings.experimental-features = ["nix-command" "flakes"];

  #nixpkgs.overlays = [nurpkgs.overlay];
  nixpkgs.overlays = [
    (import ./overlays/beeper.nix)
  ];

  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/main.tar.gz") {
      inherit pkgs;
    };
  };


  imports = 
    [
      (import "${home-manager}/nixos")
      ./hardware-configuration.nix
    ];
  users.users.istipisti113 = {
    isNormalUser = true;
    extraGroups = [ "video" "wheel" "input" "networkmanager" "bluetooth" "adbusers" "plugdev" "dialout"];
    shell = pkgs.fish;
  };
  home-manager.backupFileExtension = "backup";

  #home-manager.users.istipisti113 = import /home/istipisti113/.config/home-manager/home.nix;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.resumeDevice = "/dev/disk/by-uuid/fcf14eaf-ee88-4a23-838a-5b23386b8187";
  boot.extraModulePackages = [
    (pkgs.linuxPackages.v4l2loopback.overrideAttrs (oldAttrs: {
      version = "0.13.2-manual";
      src = pkgs.fetchFromGitHub {
        owner = "umlaeute";
        repo = "v4l2loopback";
        rev = "v0.13.2";
        hash = "sha256-rcwgOXnhRPTmNKUppupfe/2qNUBDUqVb3TeDbrP5pnU=";
      };
    }))
  ];
  boot.kernelModules = ["v4l2loopback"];
  boot.kernelParams = ["modpbrobe.blacklist=dvb_usb_rtl28xxu"];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=10 exclusive_caps=1 card_label="xiaomi FullHD Webcam"
  '';

  security.wrappers = {
    bwrap = {
      owner = "root";
      group = "root";
      source = "${pkgs.bubblewrap}/bin/bwrap";
      setuid = true;
    };
  };
  security.polkit.enable = true;
  swapDevices = lib.mkForce [{device = "/dev/disk/by-uuid/fcf14eaf-ee88-4a23-838a-5b23386b8187";}];


  networking.hostName = "nixtop"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Budapest";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "hu_HU.UTF-8";
    LC_IDENTIFICATION = "hu_HU.UTF-8";
    LC_MEASUREMENT = "hu_HU.UTF-8";
    LC_MONETARY = "hu_HU.UTF-8";
    LC_NAME = "hu_HU.UTF-8";
    LC_NUMERIC = "hu_HU.UTF-8";
    LC_PAPER = "hu_HU.UTF-8";
    LC_TELEPHONE = "hu_HU.UTF-8";
    LC_TIME = "hu_HU.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "ventoy-1.1.05"
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim
    alacritty
    waybar
    wofi
    firefox
    hyprpaper
    hyprland
    sway
    tidal-hifi
    unstable.spotify
    playerctl
    transmission-qt
    vlc
    obsidian
    jq
    cargo
    steam
    prusa-slicer
    curl
    unzip
    zip
    android-studio
    wine
    lshw
    gcc
    clang
    rust-analyzer
    logmein-hamachi
    unstable.tailscale
    discord-screenaudio
    vscode-langservers-extracted
    #nvidia-prime
    mesa-demos
    #nvidia-x11
    #nvidia-settings
    #nvidia-persistenced
    gptfdisk
    gparted
    fluxbox
    fish
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
    ventoy
    pix
    direnv
  ];
  environment.sessionVariables = { DOTNET_ROOT = "${pkgs.dotnet-sdk}/share/dotnet"; };

  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
  ];
  services.teamviewer.enable = true;

  services.logmein-hamachi.enable = true;
  services.tailscale.enable = true;
  services.tailscale.package = unstable.tailscale;
  services.mullvad-vpn.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  services.xserver.desktopManager.plasma6.enable = true;
  services.xserver.displayManager.sddm.enable = false;
  services.xserver.enable = true;

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  programs.hyprland.enable = true;
  programs.zsh.enable = true;
  programs.fish.enable = true;
  programs.sway = {
    enable = true;
    xwayland.enable = true;
    #waylandbackend = "vulkan";
    #    extraSessionCommands = ''
    #      export __NV_PRIME_RENDER_OFFLOAD=1
    #export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    #export __GLX_VENDOR_LIBRARY_NAME=nvidia
    #export __VK_LAYER_NV_optimus=NVIDIA_only
    #export WLR_RENDERER=vulkan
    #    '';
  };

  hardware.rtl-sdr.enable = true;
  services.udev.packages = with pkgs; [via oversteer rtl-sdr];
  hardware.bluetooth.enable = true;
  hardware.keyboard.qmk.enable = true;
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  hardware.nvidia = {
    modesetting.enable = lib.mkDefault true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    prime = {
      sync.enable = false;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
        #   offload = {
        #     enable = true;
        #     enableOffloadCmd = true;
        #   };
    };
  };
  services.xserver.videoDrivers = [ "modesetting" "nouveau" ]; 
  #services.xserver.videoDrivers = [ "nvidia" ]; 
  #hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  services.blueman.enable = true;
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 8000 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  programs.nix-ld.enable = true;
  programs.adb.enable = true;

  specialisation = {
    on-the-go.configuration = {
      system.nixos.tags = [ "on-the-go" ];
      hardware.nvidia = {
        prime.offload.enable = lib.mkForce true;
        prime.offload.enableOffloadCmd = lib.mkForce true;
        prime.sync.enable = lib.mkForce false;
      };
    };
    nvidia-offload.configuration = {
      #boot.blacklistedKernelModules = [ "i915" ];
      hardware.nvidia = {
        modesetting.enable =  true;
        nvidiaSettings = true;
        open = false;
        prime = {
          sync.enable = false;
          intelBusId = "PCI:0:2:0";
          nvidiaBusId = "PCI:1:0:0";
          offload = {
            enable = lib.mkForce true; 
            enableOffloadCmd = lib.mkForce true;
          };
        };
      };
      services.xserver.videoDrivers = lib.mkForce [  "nvidia" ]; 
    };
  };
}
