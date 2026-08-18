#!/usr/bin/env bash
#
# Build a planner PDF.
#
# Usage:
#   ./build.sh [options] [device|cfg-list] [year]
#
# The first argument selects a device preset or gives a comma-separated
# list of cfg files. The second argument selects the planner year.
# With no arguments, the script builds the rmpp preset for the next year.
#
# Options:
#   -p         Preview mode: emit one page for each unique layout.
#   -c FILES   Append extra cfg files (comma-separated) to the list.
#   -t LANG    Translate the planner with translations/<LANG>.json.
#   -o NAME    Name the output PDF <NAME>.pdf.
#   -h         Show this help text.
#
# Environment:
#   PLANNERGEN_BINARY   Use a pre-built plannergen instead of "go run".

set -euo pipefail

declare -A DEVICE_CFGS=(
  [rmpp]="cfg/base.yaml,cfg/template_breadcrumb.yaml,cfg/rmpp.base.yaml,cfg/rmpp.breadcrumb.default.dailycal.yaml"
  [rm2]="cfg/base.yaml,cfg/template_breadcrumb.yaml,cfg/rm2.base.yaml,cfg/rm2.breadcrumb.default.dailycal.yaml"
  [sn_a5x]="cfg/base.yaml,cfg/template_months_on_side.yaml,cfg/sn_a5x.mos.default.yaml,cfg/sn_a5x.mos.default.dailycal.yaml"
  [sn_a6x]="cfg/base.yaml,cfg/template_months_on_side.yaml,cfg/sn_a6x.mos.default.yaml"
  [kscribe]="cfg/base.yaml,cfg/template_breadcrumb.yaml,cfg/kscribe.breadcrumb.default.yaml,cfg/kscribe.breadcrumb.default.dailycal.yaml"
)

usage() {
  sed -n '2,20p' "$0" | sed 's/^# \{0,1\}//'
}

preview=""
extra_cfg=""
translation=""
outname=""

while getopts "pc:t:o:h" opt; do
  case "$opt" in
    p) preview="--preview" ;;
    c) extra_cfg="$OPTARG" ;;
    t) translation="$OPTARG" ;;
    o) outname="$OPTARG" ;;
    h) usage; exit 0 ;;
    *) usage >&2; exit 2 ;;
  esac
done
shift $((OPTIND - 1))

device="${1:-rmpp}"
year="${2:-$(($(date +%Y) + 1))}"

if [[ -n "${DEVICE_CFGS[$device]:-}" ]]; then
  cfg="${DEVICE_CFGS[$device]}"
else
  case "$device" in
    *.yaml|*.yml) cfg="$device" ;;
    *)
      echo "unknown device '$device'; known: ${!DEVICE_CFGS[*]}" >&2
      exit 2
      ;;
  esac
fi

if [[ -n "$extra_cfg" ]]; then
  cfg="$cfg,$extra_cfg"
fi

# plannergen names the root .tex file after the last cfg file.
root="$(basename "${cfg##*,}")"
root="${root%.yaml}"
root="${root%.yml}"

outname="${outname:-planner.${device##*/}.${year}}"

echo "building ${outname}.pdf (cfg: ${cfg})"

PLANNER_YEAR="$year" ${PLANNERGEN_BINARY:-go run cmd/plannergen/plannergen.go} \
  $preview --config "$cfg"

if [[ -n "$translation" ]]; then
  python3 translate.py "$translation"
fi

# Give each run its own cache so parallel builds do not clash,
# and so the nix sandbox has a writable fontconfig cache.
XDG_CACHE_HOME="$(mktemp -d)"
export XDG_CACHE_HOME
trap 'rm -rf "$XDG_CACHE_HOME"' EXIT

# latexmk reruns xelatex until cross-references are stable.
latexmk -xelatex \
  -interaction=nonstopmode \
  -file-line-error \
  -output-directory=out \
  "out/${root}.tex"

cp "out/${root}.pdf" "${outname}.pdf"
echo "created ${outname}.pdf"
