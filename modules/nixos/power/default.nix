#  _ __   _____      _____ _ __
# | '_ \ / _ \ \ /\ / / _ \ '__|
# | |_) | (_) \ V  V /  __/ |
# | .__/ \___/ \_/\_/ \___|_|
# |_|
#
# System power settings.
{config, ...}: {
  services = {
    # Disable the power profiles daemon
    power-profiles-daemon.enable = false;

    # Enable the TLP power management tool
    tlp = {
      enable = true;
      settings = {
        CPU_ENERGY_PERF_POLICY_ON_AC = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "powersave";
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MAX_PERF_ON_BAT = 50;
        CPU_MIN_PERF_ON_AC = 0;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_SCALING_GOVERNOR_ON_AC = "powersave";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        PCIE_ASPM_ON_BAT = "powersupersave";
      };
    };
  };

  # Enable powertop
  powerManagement = {
    enable = true;
    powertop.enable = true;
  };
}
