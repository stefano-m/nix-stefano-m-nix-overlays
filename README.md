# Custom Nixpkgs Overlays

This is a collection of packages to add to the [Nix Packages
Collection](https://nixos.org/nixpkgs/manual/) for use with
[Nix](https://nixos.org/nix/manual/) and/or
[NixOS](https://nixos.org/nixos/manual/).

## Local Installation

1. Download or clone this repository
2. Create the folder `~/.config/nixpkgs/overlays`
3. Add a symbolic link to the created folder

Alternatively, run `install.sh` that will do the above steps for you.

Once the overlays are installed, they can be used with `nix`.

To uninstall, do the above steps backwards, or simply run the `uninstall.sh`
script.

## NixOS Installation

For NixOS to be able to see these overlays, you can use the `nixpkgs.overlays`
attribute. For example, you can fetch the git repository directly from the
network [for more information, see the official documentation about
`builtins.fetchGit`](https://nixos.org/nix/manual/#ssec-builtins).

``` nix
nixpkgs.overlays = with builtins; [
  (
    import (fetchGit {
      url = <repo URL>;
      rev = <git revision>;
      ref = <git ref>;
    })
  )
];
```

### Using the overlays in NixOS with awesomewm

Most of the Lua overlays are actually useful in conjunction with the [Awesome
Window Manager](https://awesomewm.org/) which **must** be built with GTK
support.

In this case, your NixOS configuration should look something like:

``` nix
# /etc/nixos/configuration.nix
nixpkgs.overlays = with builtins; [

    (self: super: { awesome = super.awesome.override { gtk3Support = true; }; })

    (
      import (fetchGit {
        url = "https://github.com/stefano-m/nix-stefano-m-nix-overlays.git";
        rev = "0000000000000000000000000000000000000000";  # git revision heere
      })
    )

];

services.xserver.windowManager.windowManager = {
   awesome = {
     enable = true;
     luaModules = with pkgs.extraLuaPackages; [ # need overalys for this to work!
       connman_dbus
       connman_widget
       dbus_proxy
       enum
       media_player
       power_widget
       pulseaudio_dbus
       pulseaudio_widget
       upower_dbus
     ];
   };
```
