```shell
sudo nix --experimental-features "nix-command flakes" run 'github:nix-community/disko/latest#disko-install' -- --flake .#framework
```
