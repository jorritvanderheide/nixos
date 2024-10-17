#                         _
#  ___  ___  ___ _ __ ___| |_ ___
# / __|/ _ \/ __| '__/ _ \ __/ __|
# \__ \  __/ (__| | |  __/ |_\__ \
# |___/\___|\___|_|  \___|\__|___/
#
#
# Public keys for decrypting Agenix secrets.
let
  username = "public-key";
  users = [username];

  hostname = "public-key";
  hosts = [hostname];
in {
  # "somefile.age".publicKeys = [username / users / hostname / hosts];
}
