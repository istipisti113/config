{
  description = "NixOS configuration with Flakes";

  inputs = {
    # Use the stable branch that matches your system's stateVersion.
    # Find this in your configuration.nix (e.g., "24.11").
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    synapse.url = "github:istipisti113/synapse";
  };

  outputs = { self, nixpkgs, synapse, ... }@inputs: {
    # Replace "your-hostname" with your actual system's hostname.
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          # Import your existing configuration file.
          ./laptop/configuration.nix
          ({config, pkgs, ...}:{
            environment.systemPackages = [
              synapse.packages.${pkgs.system}.default
            ];
          })
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
