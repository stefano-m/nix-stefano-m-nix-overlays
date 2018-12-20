#!/usr/bin/env bash
set -e

OVERLAYS_DIR=~/.config/nixpkgs/overlays/
INSTALLED_DIR="${OVERLAYS_DIR}/$(basename "$PWD")"
test -h "$INSTALLED_DIR" && unlink "$INSTALLED_DIR" || true
rmdir "$OVERLAYS_DIR" 2>/dev/null || true
rmdir "$(dirname "$OVERLAYS_DIR")" 2>/dev/null || true
