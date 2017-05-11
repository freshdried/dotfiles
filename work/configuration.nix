{ config, pkgs, ... }:

{
  imports =
  [
    ./hardware-configuration.nix
  ];

  hardware.bluetooth.enable = true;


  boot.kernelPackages = pkgs.linuxPackages;
  boot.kernelModules = [ "snd-aloop" ];
  boot.kernelParams = [
    "acpi_backlight=vendor"
  ];
  boot.kernel.sysctl = {
    "vm.overcommit_memory" = 2;
    "vm.overcommit_ratio" = 99;
  } ;



  boot.extraModprobeConfig = ''
  options hid_apple iso_layout=0
  options hid_apple fnmode=2
  '';

  boot.loader.systemd-boot.enable = true;
  boot.loader.timeout = 0;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.wireless.enable = true;

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  time.timeZone = "America/New_York";

  environment.variables."SSL_CERT_FILE" = "/etc/ssl/certs/ca-bundle.crt";
  environment.systemPackages = with pkgs; [
    # system
    jack2Full
    alsaPlugins
    alsaLib

    # utilities
    wget
    curl
    which
    binutils
    pciutils

    # cli programs
    powertop
    htop
    bashmount

    # x programs
    google-chrome
    rxvt_unicode
    wpa_supplicant_gui

    # ricing
    haskellPackages.xmobar


    # development
    gitFull
    neovim
  ];

  # zsh
  programs.zsh.enable = true;
  users.defaultUserShell = "/run/current-system/sw/bin/zsh";


  # # services
  # programs.light.enable = true;
  # programs.kbdlight.enable = true;
  # powerManagement = {
  #   resumeCommands = ''
  #     xrandr --output eDP1 --auto
  #   '';
  # };


  # services.acpid.enable = true;
  # services.acpid.lidEventCommands = ''
  #   LID_STATE=/proc/acpi/button/lid/LID0/state
  #   if [ $(/run/current-system/sw/bin/awk '{print $2}' $LID_STATE) = 'closed' ]; then
  #     systemctl suspend
  #   fi
  # '';
  # services.upower.enable = true;
  # services.nixosManual.showManual = true;
  # 
  # services.redshift = {
  #   enable = false;
  #   latitude = "40.7127";
  #   longitude = "-74.0059";
  # };

  # services.udev.extraRules = ''
  #   ACTION=="add", KERNEL=="hci0", RUN+="${pkgs.bluez}/bin/hciconfig %k up"
  # '';

  services.openssh = {
    enable = true;
  };


  services.udev.extraRules = ''
  ACTION=="add", KERNEL=="hci[0-9]*", RUN+="/run/current-system/sw/bin/hciconfig %k up"
  '';

  # services.locate.enable = true;
  services.xserver = {
    enable = true;
    layout = "us";
    videoDrivers = [
      "nvidiaBeta"
      ];

      displayManager = {
        slim.enable = true;
        slim.defaultUser = "slee2";
        slim.autoLogin = true;
      };

      desktopManager.default = "none";
      desktopManager.xterm.enable = false;

      windowManager.default = "xmonad";
      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
        extraPackages = haskellPackages: [
          haskellPackages.xmonad-extras
          haskellPackages.xmonad-contrib
        ];
      };

      synaptics = {
        enable = true;
        tapButtons = false;
        buttonsMap = [ 1 3 2 ];
        twoFingerScroll = true;
        horizontalScroll = true;
        minSpeed = "0.6";
        maxSpeed = "120";
        accelFactor = "0.02";
        palmDetect = true;
      };
  };
  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      corefonts
      terminus_font
      unifont
    ];
  };


  security.pam.loginLimits = 
  [
    { domain = "@audio"; item = "memlock"; type = "-"; value = "unlimited"; }
    { domain = "@audio"; item = "rtprio"; type = "-"; value = "99"; }
    { domain = "@audio"; item = "nofile"; type = "soft"; value = "99999"; }
    { domain = "@audio"; item = "nofile"; type = "hard"; value = "99999"; }
  ];

  users.extraUsers = {
    slee2 = {
      isNormalUser = true;
      uid = 501; # to match OSX default UID
      extraGroups = ["wheel" "audio" "dialout" "pairing"];
      createHome = true;
      home = "/home/slee2";
    };
    shahn = {
      isNormalUser = true;
      uid = 502;
      extraGroups = ["pairing"];
      createHome = true;
      home = "/home/shahn";
    };
  };

  system.stateVersion = "16.09";

  # system.activationScripts.setup-alsa-plugins = 
  # ''
  #   ln -sfn ${pkgs.alsaPlugins.override
  #     { inherit (pkgs) jack2Full; }
  #   }/lib/alsa-lib /run/alsa-plugins
  # '';

  # nix.requireSignedBinaryCaches = true;
  # nix.binaryCaches = [ "http://hydra.nixos.org" ];
  # nix.binaryCachePublicKeys = [ "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs=" ];
  virtualisation.docker.enable = true;

  nixpkgs.config.allowUnfree = true;
}
