#!/bin/sh

# Some events send additional information specific to the event in the $INFO
# variable. E.g. the front_app_switched event sends the name of the newly
# focused application in the $INFO variable:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

# if [ "$SENDER" = "front_app_switched" ]; then
#   sketchybar --set "$NAME" label="$INFO"
# fi

ICON_COLOR=0xffff7f17

case $INFO in
  "Arc")
    ICON_PADDING_RIGHT=5
    ICON=󰞍
    ;;
  "Code")
    ICON_PADDING_RIGHT=2
    ICON_COLOR=0xff22a1f0
    ICON=󰨞
    ;;
  "Calendar")
    ICON=
    ;;
  "Dictionary")
    ICON=
    ;;
  "Discord")
    ICON_COLOR=0xff5b5bf5
    ICON=󰙯
    ;;
  "FaceTime")
    ICON=
    ;;
  "Finder")
    ICON_COLOR=0xff40b9ff
    ICON=󰀶
    ;;
  "Firefox")
    ICON=󰈹
    ;;
  "Google Chrome")
    ICON=
    ;;
  "IINA")
    ICON=󰕼
    ;;
  "kitty")
    ICON=󰄛
    ;;
  "Maps")
    ICON_COLOR=0xff24D44E
    ICON=󰗵
    ;;
  "Messages")
    ICON=󰍦
    ;;
  "Obsidian")
    ICON_COLOR=0xff403a83
    ICON=
    ;;
  "Preview")
    ICON_COLOR=0xff137DF8
    ICON=
    ;;
  "Reminders")
    ICON_COLOR=0xff40b9ff
    ICON=
    ;;
  "Spotify")
    ICON_COLOR=0xff24D44E
    ICON=
    ;;
  "CotEditor")
    ICON=
    ;;
  *)
    ICON_COLOR=0xffff94c6
    ICON=﯂
    ;;
esac

sketchybar --set $NAME \
  icon=$ICON icon.color=$ICON_COLOR \
  label="$INFO"
