{
  description = "NixOS configuration with Flakes";

  inputs = {
    # Use the stable branch that matches your system's stateVersion.
    # Find this in your configuration.nix (e.g., "24.11").
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    # Replace "your-hostname" with your actual system's hostname.
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        # Replace with your system's architecture (e.g., "x86_64-linux", "aarch64-linux").
        system = "x86_64-linux";
        modules = [
          # Import your existing configuration file.
          ./laptop/configuration.nix
        ];
      };
      asztali = nixpkgs.lib.nixosSystem {
        # Replace with your system's architecture (e.g., "x86_64-linux", "aarch64-linux").
        system = "x86_64-linux";
        modules = [
          # Import your existing configuration file.
          ./asztali/configuration.nix
        ];
      };
    };
  };
}
