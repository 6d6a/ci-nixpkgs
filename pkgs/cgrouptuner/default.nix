{ stdenv, makeWrapper, perlPackages }:

stdenv.mkDerivation {
  name = "cgrouptuner";
  src = ./src;
  nativeBuildInputs = [ makeWrapper ];
  installPhase = ''
    mkdir -p $out/bin
    install -m755 cgrouptuner.pl $out/bin/cgrouptuner
    wrapProgram $out/bin/cgrouptuner --set PERL5LIB ${with perlPackages; makeFullPerlPath [ ListAllUtils ]}
  '';
  dontStrip = true;
}
