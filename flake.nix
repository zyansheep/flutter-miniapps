{
	description = "Flutter Flake";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.05";
		utils.url = "github:numtide/flake-utils";
	};

	outputs = { self, nixpkgs, utils }:
	utils.lib.eachDefaultSystem (system: let
		pkgs = import nixpkgs {
			inherit system;
			config = { allowUnfree = true; };
		};
	in rec {
		# `nix develop`
		devShell = pkgs.mkShell {
			buildInputs = with pkgs; [
				flutter
				dart
				android-studio
				jdk
				git
				chromium
			];
			shellHook=''
				export USE_CCACHE=1
				export ANDROID_JAVA_HOME=${pkgs.jdk.home}
				export ANDROID_HOME=~/.androidsdk
				export FLUTTER_SDK=${pkgs.flutter}
				export CHROME_EXECUTABLE="chromium"
			'';
		};
	});
}