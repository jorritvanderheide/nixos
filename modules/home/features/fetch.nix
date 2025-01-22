# Home manager module that configures Fastfetch
{...}: {
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = builtins.path {path = ../../../assets/images/wallpaper-square.six;};
        height = 14;
        padding = {
          top = 2;
          right = 3;
        };
      };
      modules = [
        "break"
        "break"
        {
          "type" = "os";
          "key" = "OS   ";
          "keyColor" = "31";
        }
        {
          "type" = "kernel";
          "key" = " ├  ";
          "keyColor" = "31";
        }
        {
          "type" = "packages";
          "format" = "{} (Nix)";
          "key" = " ├ 󰏖 ";
          "keyColor" = "31";
        }
        {
          "type" = "shell";
          "key" = " └  ";
          "keyColor" = "31";
        }
        "break"
        {
          "type" = "de";
          "key" = "DE   ";
          "keyColor" = "32";
        }
        {
          "type" = "theme";
          "key" = " ├ 󰉼 ";
          "keyColor" = "32";
        }
        {
          "type" = "icons";
          "key" = " ├ 󰀻 ";
          "keyColor" = "32";
        }
        {
          "type" = "cursor";
          "key" = " ├  ";
          "keyColor" = "32";
        }
        "break"
        {
          "type" = "host";
          "format" = "{5} {1} Type {2}";
          "key" = "PC   ";
          "keyColor" = "33";
        }
        {
          "type" = "cpu";
          "format" = "{1} ({2}) @ {7}";
          "key" = " ├  ";
          "keyColor" = "33";
        }
        {
          "type" = "gpu";
          "format" = "{1} {2} @ {12}";
          "key" = " ├ 󰢮 ";
          "keyColor" = "33";
        }
        {
          "type" = "memory";
          "key" = " ├  ";
          "keyColor" = "33";
        }
        "break"
      ];
    };
  };
}
