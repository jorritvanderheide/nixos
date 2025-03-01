#!/bin/sh

# Define the paths to your wallpapers
LIGHT_WALLPAPER="$HOME/Pictures/Backgrounds/wallpaper-light.jpg"
DARK_WALLPAPER="$HOME/Pictures/Backgrounds/wallpaper-dark.jpg"

# Get the current hour
HOUR=$(date +"%H")

# Set the wallpaper based on the time of day
if [ "$HOUR" -ge 6 ] && [ "$HOUR" -lt 18 ]; then
  swww img -o "eDP-1" "$LIGHT_WALLPAPER"
  swww img -o "DP-1" "$LIGHT_WALLPAPER"
else
  swww img -o "eDP-1" "$DARK_WALLPAPER"
  swww img -o "DP-1" "$DARK_WALLPAPER"
fi