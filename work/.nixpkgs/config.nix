{ pkgs }:
{
  allowUnfree = true;

  packageOverrides = pkgs_: rec {
    flow = pkgs.callPackage ./myPkgs/flow-0.61.0.nix {
      inherit (pkgs.ocamlPackages_4_03) ocaml findlib camlp4 sedlex ocamlbuild ocaml_lwt;
    };
    spectrojack = pkgs.callPackage ./myPkgs/spectrojack.nix {};
    bitwig-studio = pkgs.callPackage ./myPkgs/bitwig-studio.nix {
      zenity = pkgs.gnome2.zenity;
    };
    ghcEnv = with pkgs; buildEnv {
      name = "ghcEnv";
      paths = [
        cabal2nix
        cabal-install
        stack
        (haskell.packages.ghc802.ghcWithPackages (haskellPackages: with haskellPackages; [
          alsa-seq
          digest 
          zlib 
        ]))
      ];
    };
    pythonEnv = with pkgs; buildEnv {
      name = "pythonEnv";
      paths = [
        python
      ] ++ (with python27Packages; [
        docker_compose
        pip
        setuptools
        virtualenv
      ]);
    };
    all = with pkgs; buildEnv {
      name = "all";
      paths = [
        a2jmidid
        # airwave
        alacritty
        ansible
        arandr
        audacity
        avahi
        awscli
        baudline
        bind
        bitwig-studio
        colordiff
        compton-git
        docker
        emacs
        entr
        espeak
        etherape
        evince
        exfat
        fantasque-sans-mono
        file
        firefox
        flow
        fluidsynth
        fontmatrix
        gcc
        ghcEnv
        ghostscript
        gimp
        gist
        gitAndTools.hub
        gitAndTools.qgit
        git-cola
        gnome3.cheese
        gnome3.gnome-video-effects
        gnumake
        gnupg
        gnuplot
        go
        google-chrome
        guvcview
        hack-font
        inotify-tools
        inkscape
        ipafont
        jdk
        jq
        leiningen
        libv4l
        m4
        maim
        meld
        meterbridge
        mpg123
        mplayer
        mysql
        ncdu
        ncurses
        neovim
        netcat-gnu
        nitrogen
        nix-prefetch-scripts
        nix-repl
        nixUnstable
        nmap_graphical
        nodejs-8_x
        nox
        openvpn
        ocaml
        ocamlPackages.findlib
        ocamlPackages.ocpIndent
        opam
        p7zip
        parted
        patchage
        patchelf
        pkgconfig
        poppler_utils
        postgresql
        pv
        pythonEnv
        qjackctl
        ranger
        renameutils
        rlwrap
        rofi
        ruby
        sbt
        scala
        screen
        scrot
        shellcheck
        silver-searcher
        simplescreenrecorder
        slack
        slop
        smlnj
        socat
        sox
        spectrojack
        stunnel
        subversion
        supercollider
        sxiv
        tcptrack
        tcpdump
        termite
        terraform
        testdisk
        tigervnc
        timemachine
        tmux
        torbrowser
        transmission_gtk
        tsocks
        uim
        unzip
        unity3d
        vagrant
        vlc
        vscode
        wireshark-gtk
        wmctrl
        w3m
        x2vnc
        xclip
        xdg_utils
        xdotool
        xorg.xbacklight
        xorg.xev
        xorg.xeyes
        xxd
        xvfb_run
        zeal
        zoom-us
      ];
    };
  };
}
