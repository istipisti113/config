{config, pkgs,lib, ...}:
{
	environment.systemPackages = with pkgs; [
		tmux
		vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
		neovim
		git
		wget
    fish
    jdk
    logmein-hamachi
	];
}
