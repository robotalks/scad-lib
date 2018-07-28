#!/bin/sh

COMPONENT="$1"
TARGET="$2"

SCAD_FILE=lib/$COMPONENT-render.scad
test -f "$SCAD_FILE" || SCAD_FILE=designs/$COMPONENT/$COMPONENT-render.scad
test -f "$SCAD_FILE" || SCAD_FILE=designs/$COMPONENT/render.scad
test -f "$SCAD_FILE" || {
    echo "Component $COMPONENT not found"
    exit 1
}

mkdir -p out
exec openscad \
    -o "$(pwd)/out/$COMPONENT-$TARGET.stl" \
    -D target='"'$TARGET'"' \
    --render -- "$(pwd)/$SCAD_FILE"
