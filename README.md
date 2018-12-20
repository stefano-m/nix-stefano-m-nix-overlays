# Custom Nixpkgs Overlays

This is a collection of packages to add to the [Nix Packages
Collextion](https://nixos.org/nixpkgs/manual/) for use with
[Nix](https://nixos.org/nix/manual/) and/or
[NixOS](https://nixos.org/nixos/manual/).

## Installation

1. Download or clone this repository
2. Create the folder `~/.config/nixpkgs/overlays`
3. Add a symbolic link to the created folder

Alternatively, run `install.sh` that will do the above steps for you.

Once the overlays are installed, they can be used with `nix`.

To uninstall, do the above steps backwards, or simply run the `uninstall.sh`
script.
