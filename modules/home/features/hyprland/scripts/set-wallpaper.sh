#!/bin/sh

# Define the paths to your wallpapers
LIGHT_WALLPAPER="$HOME/Pictures/Backgrounds/wallpaper-light.jpg"
DARK_WALLPAPER="$HOME/Pictures/Backgrounds/wallpaper-dark.jpg"
MODE_FILE="$HOME/.current_wallpaper_mode"

# Get the current hour
HOUR=$(date +"%H")

# Script to change the wallpaper
set_wallpaper() {
  if [ "$MODE" = "light" ]; then
    printf "Setting light wallpaper\n"
    swww img "$LIGHT_WALLPAPER"
    # swww img -o "DP-1" "$LIGHT_WALLPAPER"
  else
    printf "Setting dark wallpaper\n"
    swww img "$DARK_WALLPAPER"
    # swww img -o "DP-1" "$DARK_WALLPAPER"
  fi
}

# Handle toggle mode
if [ "$1" = "toggle" ]; then
  if [ -f "$MODE_FILE" ]; then
    CURRENT_MODE=$(cat "$MODE_FILE")
  else
    CURRENT_MODE="light"
  fi

  # Toggle the mode
  if [ "$CURRENT_MODE" = "light" ]; then
    MODE="dark"
  else
    MODE="light"
  fi

  echo "$MODE" > "$MODE_FILE"

else
  # Set mode based on time if no argument is provided
  if [ "$HOUR" -ge 6 ] && [ "$HOUR" -lt 18 ]; then
    MODE="light"
  else
    MODE="dark"
  fi
fi

# Apply wallpaper
echo "$MODE" > "$MODE_FILE"
printf "$MODE"
set_wallpaper
