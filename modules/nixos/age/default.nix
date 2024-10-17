#
#   __ _  __ _  ___
#  / _` |/ _` |/ _ \
# | (_| | (_| |  __/
#  \__,_|\__, |\___|
#        |___/
#
# System configuration for Age.
{...}: {
  age = {
    secrets = {
      jorrit.file = builtins.path {path = ../../secrets/jorrit.age;};
    };
    identityPaths = ["/persist/home/jorrit/.ssh/nixos" "/persist/system/etc/ssh/ssh_host_rsa_key"];
  };
}
