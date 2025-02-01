# System module that configures DNS over Https (DoH)
{ config, lib, ... }:
with lib;
let
  cfg = config.mySystem.networking;
in
{
  options.mySystem.networking = {
    dns.enable = mkEnableOption "Enable custom DNS";
    dns.servers = mkOption {
      type = types.listOf types.str;
      default = [ "mullvad-all-doh" ];
    };
  };

  config = lib.mkIf cfg.enable {
    networking.networkmanager.enable = true;

    # Custom DNS
    networking.nameservers = mkIf cfg.dns.enable [ "127.0.0.1" "::1" ];
    networking.networkmanager.dns = mkIf cfg.dns.enable "none";

    services.dnscrypt-proxy2 = mkIf cfg.dns.enable {
      enable = true;
      settings = {
        listen_addresses = [ "127.0.0.1:53" "[::1]:53" ];

        ipv6_servers = true;
        require_dnssec = true;

        sources.public-resolvers = {
          urls = [
            "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
            "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
          ];
          cache_file = "/var/lib/dnscrypt-proxy2/public-resolvers.md";
          minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
        };

        # See list at: https://github.com/DNSCrypt/dnscrypt-resolvers/blob/master/v3/public-resolvers.md
        server_names = cfg.dns.servers;
      };
    };

    systemd.services.dnscrypt-proxy2.serviceConfig = mkIf cfg.dns.enable {
      StateDirectory = "dnscrypt-proxy";
    };
  };

  # Conditionally persist directories
  mySystem = lib.mkIf config.mySystem.impermanence.enable {
    impermanence = {
      files = [
        "/var/lib/dnscrypt-proxy2/public-resolvers.md"
      ];
    };
  };
}
