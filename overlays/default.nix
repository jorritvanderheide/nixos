#                      _
#   _____   _____ _ __| | __ _ _   _ ___
#  / _ \ \ / / _ \ '__| |/ _` | | | / __|
# | (_) \ V /  __/ |  | | (_| | |_| \__ \
#  \___/ \_/ \___|_|  |_|\__,_|\__, |___/
#                              |___/
#
# Overlays configuration.
{inputs, ...}: let
  agenixOverlay = inputs.agenix.overlays.default;
in [
  agenixOverlay
  # Add overlays here
]
