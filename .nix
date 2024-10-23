{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    (pkgs.yarn.overrideAttrs (old: {
      postInstall = "rm -f $out/LICENSE";
    }))
    (pkgs.composer.overrideAttrs (old: {
      postInstall = "rm -f $out/LICENSE";
    }))
  ];
}
