# System module that configures Home Manager
# TODO: cleanup
{
  config,
  inputs,
  myLib,
  outputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  environment.systemPackages = with pkgs; [
    home-manager
  ];

  home-manager = {
    backupFileExtension = "bkp";

    extraSpecialArgs = {
      inherit inputs;
      inherit myLib;
      outputs = inputs.self.outputs;
    };

    users =
      builtins.mapAttrs (name: user: {...}: {
        imports = [
          (import user.userConfig)
          outputs.homeManagerModules.default
        ];
      })
      (config.mySystem.home-users);
  };
}
