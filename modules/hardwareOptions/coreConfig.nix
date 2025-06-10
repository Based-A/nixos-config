{
  pkgs,
  host,
  ...
}:
{
  # Enable Flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs = {
    git = {
      enable = true;
      config = {
        user = {
          name = "adam@${host}-nixos";
          email = "adamlundrigan1@gmail.com";
        };
        safe = {
          directory = "/home/flake";
        };
        init = {
          defaultBranch = "main";
        };
      };
    };
    neovim.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [
      sops
      nixfmt-rfc-style
      nixd
    ];
    etc = {
      "links/nvim".source = "${pkgs.neovim}/share/applications/nvim.desktop";
    };
  };

  # Local System Info
  ## Set your time zone.
  time.timeZone = "America/Edmonton";

  ## Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  hardware = {
    enableAllFirmware = true;
  };

  security.rtkit.enable = true;
  security.polkit.enable = true;
}
