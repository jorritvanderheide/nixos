#!/bin/sh

# Define the paths to your wallpapers
LIGHT_WALLPAPER="$HOME/Pictures/Backgrounds/wallpaper-light.jpg"
DARK_WALLPAPER="$HOME/Pictures/Backgrounds/wallpaper-dark.jpg"

# Get the current hour
HOUR=$(date +"%H")

# Check for command-line argument
if [ "$1" = "toggle" ]; then
  # Read the current wallpaper mode from a file
  if [ -f "$HOME/.current_wallpaper_mode" ]; then
    CURRENT_MODE=$(cat "$HOME/.current_wallpaper_mode")
  else
    CURRENT_MODE="light"
  fi

  # Toggle the wallpaper mode
  if [ "$CURRENT_MODE" = "light" ]; then
    MODE="dark"
  else
    MODE="light"
  fi

  # Save the new mode to the file
  echo "$MODE" > "$HOME/.current_wallpaper_mode"
else
  # Set the wallpaper based on the time of day if no argument is provided
  if [ "$HOUR" -ge 6 ] && [ "$HOUR" -lt 18 ]; then
    MODE="light"
  else
    MODE="dark"
  fi
fi

# Set the wallpaper based on the time of day
if [ "$HOUR" -ge 6 ] && [ "$HOUR" -lt 18 ]; then
  swww img -o "eDP-1" "$LIGHT_WALLPAPER"
  swww img -o "DP-1" "$LIGHT_WALLPAPER"
else
  swww img -o "eDP-1" "$DARK_WALLPAPER"
  swww img -o "DP-1" "$DARK_WALLPAPER"
fi