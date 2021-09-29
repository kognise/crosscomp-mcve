let
  unstable = import (fetchTarball https://nixos.org/channels/nixos-unstable/nixexprs.tar.xz);

  pkgs = unstable {
    crossSystem = { config = "x86_64-w64-mingw32"; };
    overlays = [
      (import (builtins.fetchTarball "https://github.com/oxalica/rust-overlay/archive/master.tar.gz"))
    ];
  };

  rust = pkgs.buildPackages.rust-bin.nightly.latest.default.override {
    extensions = [ "rust-src" ];
    targets = [ "x86_64-pc-windows-gnu" "x86_64-unknown-linux-gnu" ];
  };
in pkgs.mkShell { 
  nativeBuildInputs = with pkgs; [
    rust
    buildPackages.cacert
    buildPackages.busybox
  ];

  buildInputs = with pkgs; [
    windows.pthreads
  ];
}