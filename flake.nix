{
	description = "Flutter Flake";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		utils.url = "github:numtide/flake-utils";
	};

	outputs = { self, nixpkgs, utils }:
	utils.lib.eachDefaultSystem (system: let
		pkgs = import nixpkgs {
			inherit system;
			config = {
				android_sdk.accept_license = true;
				allowUnfree = true;
			};
		};
	in rec {
		# `nix develop`
		devShell = pkgs.mkShell {
			buildInputs = with pkgs; [
				flutter
				dart
				android-studio
				jdk11
				git
				chromium
			];
			shellHook=''
				export USE_CCACHE=1
				export ANDROID_JAVA_HOME=${pkgs.jdk11.home}
				export ANDROID_HOME=~/.androidsdk
				export FLUTTER_SDK=${pkgs.flutter}
				export CHROME_EXECUTABLE="chromium"
				export PATH="$PATH":"$HOME/.pub-cache/bin"
			'';
		};
	});
}