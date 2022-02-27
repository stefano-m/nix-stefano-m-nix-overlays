.PHONY: default
default:
	@echo see this Makefile for more info.

.PHONY: protonmail-bridge
protonmail-bridge:
	nix-build -E 'with import <nixpkgs> { overlays = [ (import ./default.nix) ]; }; protonmail-bridge' -o result-$@

result-lua-%: lua/%
	nix-build -E "with import <nixpkgs> { overlays = [ (import ./default.nix) ]; }; extraLuaPackages.$$(echo $@ | sed 's/.*-//')" -o $@

.PHONY: clean
clean:
	-@rm -rf result*
