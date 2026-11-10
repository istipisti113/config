{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  pname = "elso-teszt";
  version = "0.1.0";

  # Point to the .deb file you just built
  src = ./elso-teszt_0.1.0_amd64.deb;

  # Tools needed to unpack the .deb
  nativeBuildInputs = with pkgs; [ dpkg patchelf makeWrapper binutils ];

  # The .deb is an 'ar' archive containing data.tar.xz
  unpackPhase = ''
    runHook preUnpack
    ar vx $src
    tar -xvf data.tar.gz
    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin $out/share
    cp -r usr/bin/* $out/bin/
    cp -r usr/share/* $out/share/

    # Patch the binary to use NixOS's dynamic linker
    patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
             $out/bin/elso_teszt
    runHook postInstall
  '';

  # Libraries your app needs at runtime (glib, gtk, webkitgtk, etc.)
  buildInputs = with pkgs; [
    glib
    gtk3
    webkitgtk_4_1
    # Add any other libraries your app links against
  ];

  postInstall = ''
    patchelf --set-rpath "${pkgs.lib.makeLibraryPath [
      pkgs.gtk3
      pkgs.glib
      pkgs.gdk-pixbuf
      pkgs.cairo
      pkgs.dbus
      pkgs.webkitgtk_4_1
      pkgs.libsoup_3
    ]}" $out/bin/elso_teszt
  '';
}
