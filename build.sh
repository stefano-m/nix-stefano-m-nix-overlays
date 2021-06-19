#!/usr/bin/env bash

nix-build -E "with import <nixpkgs> {overlays=[(import ./default.nix)];}; $1"
