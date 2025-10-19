{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
	buildInputs = with pkgs; [
		plantuml
		texlive.combined.scheme-full
		evince
    ];

	shellHook = ''
		fish
	'';
}
