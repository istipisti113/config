{options, config, pkgs, lib, ... }:
with lib;
let 
  mod = "Mod4";
  nixvim = import (builtins.fetchGit {
    url = "https://github.com/nix-community/nixvim";
    # When using a different channel you can use `ref = "nixos-<version>"` to set it here
  });
  nur = import (builtins.fetchTarball {
    url = "https://github.com/nix-community/NUR/archive/main.tar.gz";
    #pin with sha256 for less frequent downloads
  }) { inherit pkgs; };
  firefox-addons = nur.repos.rycee.firefox-addons;
in {
  # .config/nixpkgs/config.nix!!!!!
  # nur github oldala!
  #nixpkgs.overlays = [ nur.overlay ];
  #sway config
  home.file."0256.jpg".source = /home/istipisti113/.config/home-manager/0256.jpg;
  imports = [nixvim.homeModules.nixvim];
  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      startup = [
        {command = "waybar";}
        {command = "swaybg --image /home/istipisti113/0256.jpg";}
      ];
      modifier = "Mod4";
      terminal = "alacritty";
      menu = "wofi --show drun";
      bars = [];
      input."*".xkb_layout = "hu";
      input."65251:0:Thomas_Haukland_cheapino2_Keyboard".xkb_layout = "us";
      keybindings = lib.attrsets.mergeAttrsList  [
        #(lib.attrsets.mergeAttrsList)
        {
          "${mod}+Return" = "exec --no-startup-id alacritty";
          "${mod}+f" = "fullscreen toggle";
          "${mod}+p" = "exec --no-startup-id wofi --show drun";
          "${mod}+space+m" = "exec swaymsg exit";
          "${mod}+q" = "kill";
          "${mod}+Shift+p" = "exec --no-startup-id bash -c '/home/istipisti113/.config/home-manager/scripts/screenshot.sh'";
          "${mod}+w" = "exec --no-startup-id bash -c '/home/istipisti113/.config/home-manager/scripts/waybar_restart.sh'";

          #movement
          "${mod}+l" = "exec --no-startup-id bash -c '/home/istipisti113/.config/home-manager/scripts/wrkspc.sh next'"; #workspace to workspace
          "${mod}+h" = "exec --no-startup-id bash -c '/home/istipisti113/.config/home-manager/scripts/wrkspc.sh prev'";
          "${mod}+u" = "exec --no-startup-id bash -c '/home/istipisti113/.config/home-manager/scripts/wrkspc.sh mprev'"; #monitor to monitor
          "${mod}+i" = "exec --no-startup-id bash -c '/home/istipisti113/.config/home-manager/scripts/wrkspc.sh mnext'";

          "${mod}+Shift+l" = "exec --no-startup-id bash -c '/home/istipisti113/.config/home-manager/scripts/wrkspc.sh movenext'";
          "${mod}+Shift+h" = "exec --no-startup-id bash -c '/home/istipisti113/.config/home-manager/scripts/wrkspc.sh moveprev'";
          "${mod}+Shift+u" = "exec --no-startup-id bash -c '/home/istipisti113/.config/home-manager/scripts/wrkspc.sh movemprev'";
          "${mod}+Shift+i" = "exec --no-startup-id bash -c '/home/istipisti113/.config/home-manager/scripts/wrkspc.sh movemnext'";

          "${mod}+k" = "focus right";
          "${mod}+j" = "focus left";

          "${mod}+space" = "exec --no-startup-id bash -c 'playerctl --player=synapce play-pause'";
          "${mod}+right" = "exec --no-startup-id bash -c 'playerctl --player=synapce next'";
          "${mod}+left" = "exec --no-startup-id bash -c 'playerctl --player=synapce previous'";
          "${mod}+up" = "exec --no-startup-id bash -c 'playerctl --player=synapce volume 0.1+'";
          "${mod}+down" = "exec --no-startup-id bash -c 'playerctl --player=synapce volume 0.1-'";
        }
      ];
      output = {
        eDP-1 = {
          scale = "1";
          position = "0 0";
        };
        HDMI-A-1 = {
          scale = "1";
          position = "1920 0";
        };
        DP-1 = {
          scale = "1";
          position = "-1280 0";
          transform = "90";
        };
      };
      workspaceOutputAssign = [
        { workspace = "6"; output = "HDMI-A-1"; }
        { workspace = "7"; output = "HDMI-A-1"; }
        { workspace = "8"; output = "HDMI-A-1"; }
        { workspace = "9"; output = "HDMI-A-1"; }
        { workspace = "10"; output = "HDMI-A-1"; }

        { workspace = "1"; output = "eDP-1"; }
        { workspace = "2"; output = "eDP-1"; }
        { workspace = "3"; output = "eDP-1"; }
        { workspace = "4"; output = "eDP-1"; }
        { workspace = "5"; output = "eDP-1"; }
      ];
    };
    extraConfig = "workspace 1 output eDP-1\nworkspace 2 output eDP-1\nworkspace 6 output HDMI-A-1\nworkspace 7 output HDMI-A-1\ndefault_border pixel 2";
  };


  home.username = "istipisti113";
  home.homeDirectory = "/home/istipisti113";
  home.stateVersion = "25.05";
  home.sessionPath = ["$HOME/.cargo/bin/"];
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    htop
    fortune
    cowsay
    git
    git-credential-manager
    alacritty
    waybar
    wofi
    pavucontrol
    exercism
    oversteer
    #solana-cli
    #anchor
    rustup
    tree-sitter
    nodejs
    #flutter
    nixd
    chromium
    qmk
    swaybg
    qutebrowser
    freecad
    elf2uf2-rs
    nautilus
    prismlauncher
    #helix
    #codecrafters-cli
    #rpi-imager
    #awesome
    gimp
    xorg.xinit
    xorg.xauth
    popsicle
    usbimager
    #dotnet-sdk
    dotnet-sdk_9
    devbox
    #omnisharp-roslyn
    #python314
    #python3Full
    python3Packages.pip
    #python3Packages.opencv4
    #python3.pkgs.tkinter
    #opencv4
    grim
    slurp
    swappy
    appimage-run
    unrar-free
    winetricks
    blender
    libreoffice
    lsd
    stdenv.cc.cc.lib
    obs-studio
    qpwgraph
    vesktop
    #newpackage
    cargo-cross #rust cross compile
    tor-browser
    busybox
    sdrpp
    speedtest-cli
    element-desktop
  ];

  programs.bash = {
    initExtra = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
    then
      shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
      exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
    fi
    '';
  };

  #program configs
  #programs.prismlauncher.enable = true;
  programs.helix = {
    enable = true;
    settings = {
      keys.normal = {
        "$" = "goto_line_end";
        esc = ["collapse_selection"];
      };
      theme = "night_owl";
      editor = {
        line-number = "relative";
        cursorline = true;
        cursorcolumn = true;
        cursor-shape = {
          insert = "bar";
        };
      };
    };
    extraConfig = ''
      [language-server.rust-analyzer]
      command = "rust-analyzer"
      args = ["--stdio"]

      [language-server.vscode-html-language-server]
      command = "vscode-html-language-server"
      args = ["--stdio"]

      [[language]]
      name = "rust"
      language-servers = ["rust-analyzer"]
      auto-format = true

      [[language]]
      name = "html"
      language-servers = ["vscode-html-language-server"]
    '';
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      ssha = "ssh istipisti113@192.168.8.121";
      sshat = "ssh istipisti113@100.75.107.102";
    };
  };

  programs.git = {
    enable = true;
    userName = "Szabo Istvan";
    userEmail = "pisti4395@gmail.com";
    extraConfig = {
      #credential.helper = "${pkgs.git.override { withLibsecret = true;}}/bin/git-credential-libsecret";
      credential = {
        #credentialStore = "secretservice";
        #helper = "${nur.repos.utybo.git-credential-manager}/bin/git-credential-manager-core";
        helper = "manager";
        "https://github.com".username = "istipisti113";
        credentialStore = "secretservice";
      };
    };
  };

  programs.firefox ={
    enable = true;
    profiles = {
      default = {
        id = 0;
        name = "Default";
        isDefault = true;
        #settings = {
        #  "browser.startup.homepage" = "https://duckduckgo.com";
        #};
        search = {
          force = true;
          default = "ddg";
        };
        extensions.packages = with firefox-addons; [
          ublock-origin vimium darkreader sponsorblock
        ];
      };
    };
  };


  programs.waybar = {
    enable = true;
    style = /home/istipisti113/.config/home-manager/waybar/style.css;
    settings = {
      mainBar = {
        position = "top";
        modules-left = [ "sway/workspaces" "sway/mode" "sway/window" ];
        modules-center = [ "clock" ];
        modules-right = [ "custom/spotify" "tray" "battery" "memory" "pulseaudio" "backlight" ];
        "sway/window" = {
          "max-length" = 50;
        };
        "sway/workspaces" = {
          persistent_workspaces = {
            "eDP-1" = [1 2 3 4 5];
            "HDMI-A-1" = [6 7 8 9 10];
          };
        };
        extraConfig = ''
        "sway/workspaces" :{
          "persistent-workspaces":{
            "eDP-1": [1,2,3,4,5],
            "HDMI-A-1": [6,7,8,9,10]
          }
        },
        '';
        backlight = {
          format = "󰃞 {percent}%";
          on-scroll-up = "brightnessctl s 1%+";
          on-scroll-down = "brightnessctl s 1%-";
        };
        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = "  Muted";
          format-icons = {
            default = ["" "" ""];
          };
          scroll-step = 5;
          on-click = "pavucontrol";
        };
        "custom/spotify" = {
          "format" = "♫ {}";
          "exec" = "playerctl -p spotify metadata --format '{{artist}} - {{title}}'";
          "exec-if" = "playerctl -p spotify status 2>/dev/null || echo 'false'";
          "interval" = 5;
          "on-click" = "playerctl -p spotify play-pause";
          "on-click-right" = "playerctl -p spotify next";
          "on-scroll-up" = "playerctl -p spotify previous";
          "escape" = true;
          "max-length" = 50;
          "tooltip" = false;
        };
        memory = {
          format = "  {percentage}%";
        };
        battery = {
          format = "{icon} {capacity}%";
          format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          format-charging = "{icon} 󱐋 {capacity}%";
          format-plugged = "{icon}  {capacity}%";
          states = {
            warning = 30;
            critical = 15;
          };
        };
      };
    };
  };

  programs.nixvim = {
    imports = [
      /home/istipisti113/.config/home-manager/nixvim/nixvim.nix
      #/home/istipisti113/.config/home-manager/beeper.nix
    ];
  };

  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [ telescope ripgrep fd ];
    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      nvim-cmp cmp-nvim-lsp cmp-buffer cmp-path cmp_luasnip nvim-lspconfig
      lazy-nvim
    ];
  };
}
