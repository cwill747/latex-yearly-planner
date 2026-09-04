#!/usr/bin/env bash

set -euo pipefail

if (( $# > 1 )); then
  echo "Usage: ./cameron.sh [year]" >&2
  exit 2
fi

year="${1:-$(($(date +%Y) + 1))}"
if [[ ! "$year" =~ ^[0-9]{4}$ ]]; then
  echo "Year must contain four digits." >&2
  exit 2
fi

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
cd "$script_dir"

config="cfg/base.yaml,cfg/template_breadcrumb.yaml,cfg/rmpp.base.yaml,cfg/rmpp.breadcrumb.default.dailycal.yaml,cfg/rmpp.lefttoolbarroom.yaml,cfg/cameron.yaml,cfg/cameron.rmpp.daily-more.yaml"
build_args=(
  ./build.sh
  -o "planner.cameron.rmpp.${year}"
  "$config"
  "$year"
)

if [[ -n "${IN_NIX_SHELL:-}" ]]; then
  "${build_args[@]}"
else
  nix develop -c "${build_args[@]}"
fi
