#!/usr/bin/env bash
set -e

OVERLAYS_DIR=~/.config/nixpkgs/overlays/

mkdir -p "$OVERLAYS_DIR"

ln -s "$PWD" "$OVERLAYS_DIR"
