with import <nixpkgs> {};
with pkgs;
{ ghcWithPackages 
}:

[ 
  ranger
  stack
  icu
  snappy
  cmake
  git
  cacert
  iana_etc
  ncurses.dev
  postgresql
  qt4
  gcc
  glibc
  (ghcWithPackages (haskellPackages: with haskellPackages; [
    zlib
    text-icu
    terminfo
  ]))
  gitAndTools.hub
  emacs 
  neovim
  zsh
  nodejs-6_x
  silver-searcher
  kde4.okular
  graphviz
  python
  gnumake
  phantomjs
  zlib.dev
  zlib.out
  gmp
  rxvt_unicode
  perl
  shellcheck
  libelf
]
