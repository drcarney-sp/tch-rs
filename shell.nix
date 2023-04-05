{ 
  pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/1ef879bc4f9c1e1352b7cb3e56b2d62f1ee07a05.tar.gz") {},
}:
pkgs.mkShell {
  buildInputs = [
    # rust
    pkgs.stdenv.cc.cc.lib
    pkgs.rustup
    # python
    pkgs.cudatoolkit
    pkgs.python39Packages.torchWithCuda
  ];
  LIBTORCH = "${pkgs.python39Packages.torchWithCuda}/lib/python3.9/site-packages/torch";
  LD_LIBRARY_PATH="${pkgs.stdenv.cc.cc.lib}/lib:${pkgs.zlib}/lib:${pkgs.python39Packages.torchWithCuda}/lib/python3.9/site-packages/torch/lib";
  RUSTC_VERSION = pkgs.lib.readFile ./rust-toolchain;
  RUST_BACKTRACE=1;
  CUDA_PATH="${pkgs.cudatoolkit}";
  CARGO_HOME="";
}
