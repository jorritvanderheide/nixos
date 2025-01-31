# System module that configures WireGuard
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    wireguard-tools
  ];

  networking.firewall = {
    allowedUDPPorts = [51820];
  };
    networking.wg-quick.interfaces = {
    NordVPN = {
      address = [ "10.0.0.2/24"];
      dns = [ "10.0.0.1" ];
      privateKey = "hidden"; # TODO
      
      peers = [
        {
          publicKey = "hidden"; # TODO
          allowedIPs = [ "0.0.0.0/0" "::/0" ];
          endpoint = "hidden"; # TODO
          persistentKeepalive = 25;
        }
      ];
    };
  };
}