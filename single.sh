#!/usr/bin/env bash

set -eo pipefail

if [ -z "$PLANNERGEN_BINARY" ]; then
  export GO_CMD="go run cmd/plannergen/plannergen.go"
else
  export GO_CMD="$PLANNERGEN_BINARY"
  echo "Building using plannergen binary at \"${PLANNERGEN_BINARY}\""
fi

if [ -z "$PREVIEW" ]; then
  eval $GO_CMD --config "${CFG}"
else
  eval $GO_CMD --preview --config "${CFG}"
fi

export XDG_CACHE_HOME="$(mktemp -d)" # to avoid cache conflicts

nakedname=$(echo "${CFG}" | rev | cut -d, -f1 | cut -d'/' -f 1 | cut -d'.' -f 2-99 | rev)

if [ -n "${TRANSLATION}" ]; then
  python3 translate.py ${TRANSLATION}
fi

_passes=(1)

if [[ -n "${PASSES}" ]]; then
  # shellcheck disable=SC2207
  _passes=($(seq 1 "${PASSES}"))
fi

for _ in "${_passes[@]}"; do
  xelatex \
    -file-line-error \
    -interaction=nonstopmode \
    -synctex=1 \
    -output-directory=./out \
    "out/${nakedname}.tex"
done

if [ -n "${NAME}" ]; then
  cp "out/${nakedname}.pdf" "${NAME}.pdf"
  echo "created ${NAME}.pdf"
else
  cp "out/${nakedname}.pdf" "${nakedname}.pdf"
  echo "created ${nakedname}.pdf"
fi
