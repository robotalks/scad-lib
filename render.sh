#!/bin/sh

COMPONENT="$1"
TARGET="$2"

mkdir -p out
exec openscad \
    -o "out/$COMPONENT-$TARGET.stl" \
    -D target='"'$TARGET'"' \
    --render lib/$COMPONENT-render.scad
