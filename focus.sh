#!/bin/bash

# Set focus text from command line argument or prompt user
if [ -z "$1" ]; then
  echo "What's your current focus?"
  read FOCUS
else
  FOCUS="$1"
fi

if [ -z "$FOCUS" ]; then
  dconf write /org/gnome/shell/extensions/panel-date-format/format "'%b %d  ( %H:%M )'"
else
  dconf write /org/gnome/shell/extensions/panel-date-format/format "'%b %d  %H:%M   [ Focus: $FOCUS ]'"
fi

echo "Focus set to: $FOCUS"
