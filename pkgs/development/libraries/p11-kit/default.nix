{ stdenv, fetchFromGitHub, fetchpatch, autoreconfHook, pkgconfig, which
, gettext, libffi, libiconv, libtasn1
}:

stdenv.mkDerivation rec {
  pname = "p11-kit";
  version = "0.23.18.1";

  src = fetchFromGitHub {
    owner = "p11-glue";
    repo = pname;
    rev = version;
    sha256 = "0l4ndipcbikblfjz729zkscvni5lzdzvbvsar2538pylw556rx73";
  };

  outputs = [ "out" "dev"];
  outputBin = "dev";

  nativeBuildInputs = [ autoreconfHook pkgconfig which ];
  buildInputs = [ gettext libffi libiconv libtasn1 ];

  autoreconfPhase = ''
    NOCONFIGURE=1 ./autogen.sh
  '';

  configureFlags = [
    "--sysconfdir=/etc"
    "--localstatedir=/var"
    "--without-trust-paths"
  ]; # TODO: store trust anchors in a directory common to Nix and NixOS

  enableParallelBuilding = true;

  doCheck = false;

  installFlags = [ "exampledir=\${out}/etc/pkcs11" ];

  meta = with stdenv.lib; {
    description = "Library for loading and sharing PKCS#11 modules";
    longDescription = ''
      Provides a way to load and enumerate PKCS#11 modules.
      Provides a standard configuration setup for installing
      PKCS#11 modules in such a way that they're discoverable.
    '';
    homepage = https://p11-glue.github.io/p11-glue/p11-kit.html;
    platforms = platforms.all;
    license = licenses.bsd3;
  };
}
