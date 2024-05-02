with (import <nixpkgs> {}) ;
mkShell {
  buildInputs = [
    bison
    flex
    fontforge
    makeWrapper
    pkg-config
    gnumake
    gcc
    libiconv
    autoconf
    automake
    libtool # freetype calls glibtoolize
    bc
    elfutils 
    cdk
    ncurses5
    qemu_full
  ];
}
