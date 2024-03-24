{ nixpkgs ? import <nixpkgs> {} }:

with nixpkgs;

let
  # Define the Haskell environment using Stack
  haskellEnv = haskell.packages.ghc865.ghcWithPackages (pkgs: with pkgs; [
    # Add any additional Haskell packages you need here
    stack
    base
    sha
  ]);
in

haskellEnv.shellFor {
  # Add your Haskell project directory here
  packages = p: [ p.enewald ];
}
