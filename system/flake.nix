{
  description = "NixOS configuration with Flakes";

  inputs = {
    # Use the stable branch that matches your system's stateVersion.
    # Find this in your configuration.nix (e.g., "24.11").
    #net-merge.url = "github:rohit267/net-merge";
    spotatui = {
      #url = "github:LargeModGames/spotatui";
      url = "github:istipisti113/spotatui/TokyoNightColorScheme"; #testing before merge
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #coderabbit.url = "github:tienedev/coderabbit-nix";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    #synapse.url = "github:istipisti113/synapse";
    #raa.url = "github:istipisti113/rust_ai_assistant";
    #colibri.url = "github:JustVugg/colibri";

    #waycal.url = "github:istipisti113/waycal";
    # home-manager, used for managing user configuration
    #home-manager = {
    #  url = "github:nix-community/home-manager/release-26.05";
    #  # The `follows` keyword in inputs is used for inheritance.
    #  # Here, `inputs.nixpkgs` of home-manager is kept consistent with
    #  # the `inputs.nixpkgs` of the current flake,
    #  # to avoid problems caused by different versions of nixpkgs.
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let 
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      apiKeyFile = /home/istipisti113/config/variables/vars.json;
      secrets = if builtins.pathExists apiKeyFile then
        builtins.fromJSON (builtins.readFile apiKeyFile) else {};
      #pkgs2605 = import inputs.nixpkgs-2605 { inherit system; };
      #overlay = final: prev: {
      #  alacritty = (import inputs.nixpkgs-alacritty-pin { system = prev.system; }).alacritty;
      #};
      #unfree_pkgs = import nixpkgs{
      #  config = {
      #    allowUnfree = true;
      #    nvidia.acceptLicense = true;
      #  };
      #};
    in {
      # Replace "your-hostname" with your actual system's hostname.
      environment.variables = { EDITOR = "nvim"; VISUAL = "nvim";};
      nixosConfigurations = {

        laptop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            #{stdenv.hostPlatform.system = "x86_64-linux";}
            # Import your existing configuration file.
            ({config, pkgs, nixpkgs, system, ...}:{
              #nixpkgs.config = { allowBroken = lib.mkForce true; allowUnfree = lib.mkForce true;nvidia.acceptLicense = lib.mkForce true; };
              #imports = [ inputs.net-merge.nixosModules.default];
              environment.systemPackages = [
              #  (inputs.spotatui.packages.${pkgs.stdenv.hostPlatform.system}.default.overrideAttrs (oldAttrs: {
              # Key fix: unset or set to "0", overriding the problematic AWS_LC_SYS_USE_SYSTEM=1
              #AWS_LC_SYS_USE_SYSTEM = "0";
              #}))
                #pkgs2605.alacritty
                #synapse.packages.${pkgs.system}.default
                #raa.packages.${pkgs.system}.default
                inputs.spotatui.packages.${pkgs.stdenv.hostPlatform.system}.default
                #inputs.colibri.packages.${pkgs.stdenv.hostPlatform.system}.default
                #coderabbit.packages.${pkgs.system}.default
                #waycal.packages.${pkgs.system}.default
                #(raa.packages.${pkgs.system}.default.override secrets)
              ];
              #nixpkgs.pkgs = pkgs;
            })
            ./laptop/configuration.nix
            #home-manager.nixosModules.home-manager {
            #  home-manager.users.istipisti113 = import ../home/home.nix;
            #}
          ];
        };

        asztali = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            # Import your existing configuration file.
            ./asztali/configuration.nix
          ];
        };
      };
    };
}
