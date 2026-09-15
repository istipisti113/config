{
  description = "NixOS configuration with Flakes";

  inputs = {
    # Use the stable branch that matches your system's stateVersion.
    # Find this in your configuration.nix (e.g., "24.11").
    spotatui = {
      url = "github:LargeModGames/spotatui";
      #url = "github:istipisti113/spotatui/TokyoNightColorScheme"; #testing before merge
      inputs.nixpkgs.follows = "nixpkgs";
    };
    coderabbit.url = "github:tienedev/coderabbit-nix";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    synapse.url = "github:istipisti113/synapse";
    raa.url = "github:istipisti113/rust_ai_assistant";
    #colibri.url = "github:JustVugg/colibri";
  };

  outputs = { self, nixpkgs, synapse, raa, coderabbit, ... }@inputs:
    let 
      lib = nixpkgs.lib;
      apiKeyFile = /home/istipisti113/config/variables/vars.json;
      secrets = if builtins.pathExists apiKeyFile then
        builtins.fromJSON (builtins.readFile apiKeyFile) else {};
      #pkgs = import nixpkgs{
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
            ({config, pkgs, nixpkgs, ...}:{
              #nixpkgs.config = { allowBroken = lib.mkForce true; allowUnfree = lib.mkForce true;nvidia.acceptLicense = lib.mkForce true; };
              environment.systemPackages = [
                synapse.packages.${pkgs.system}.default
                raa.packages.${pkgs.system}.default
                inputs.spotatui.packages.${pkgs.stdenv.hostPlatform.system}.default
                #inputs.colibri.packages.${pkgs.stdenv.hostPlatform.system}.default
                coderabbit.packages.${pkgs.system}.default
                #(raa.packages.${pkgs.system}.default.override secrets)
              ];
              #nixpkgs.pkgs = pkgs;
            })
            ./laptop/configuration.nix
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
