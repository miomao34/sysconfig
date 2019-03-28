#!/usr/bin/env bash

URL="github.com/p-e-w/argos"
DIR=$(dirname "$0")

echo "Argos :b: | dropdown=false"

echo "---"
echo "$URL | iconName=help-faq-symbolic href='https://$URL'"
echo "$DIR | iconName=folder-symbolic href='file://$DIR'"
echo "---"
echo "Looking Glass | eval='imports.ui.main.createLookingGlass(); imports.ui.main.lookingGlass.toggle();'"


