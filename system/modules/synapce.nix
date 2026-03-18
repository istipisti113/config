{
  inputs.synapse.url = "github:istipisti113/synapse";
  
  outputs = { self, nixpkgs, synapse, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      modules = [
        { environment.systemPackages = [ synapse.packages.x86_64-linux.default ]; }
      ];
    };
  };
}
