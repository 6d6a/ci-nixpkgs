{ stdenv, fetchurl, lib, cacert, openssl, nss, perl }:

with lib;

(cacert.override {
  nss = nss.overrideDerivation (old: rec {
    version = "3.66";
    src = fetchurl {
      url = concatStrings [
        "mirror://mozilla/security/nss/releases/NSS_"
        (builtins.replaceStrings [ "." ] [ "_" ] version)
        "_RTM/src/nss-"
        version
        ".tar.gz"
      ];
      sha256 = "1jfdnh5l4k57r2vb07s06hqi7m2qzk0d9x25lsdsrw3cflx9x9w9";
    };
  });
}).overrideDerivation (old: rec {
  patches = [
    ./delete-dst-root-ca-x3.patch
  ];
  buildPhase = ''
    python certdata2pem.py | grep -vE '^(!|UNTRUSTED)'

    for cert in *.crt; do
      echo $cert | cut -d. -f1 | sed -e 's,_, ,g' >> ca-bundle.crt
      cat $cert >> ca-bundle.crt
      echo >> ca-bundle.crt
    done

    # Install certificates from ./ca directory.
    for file in ${./ca}/*
    do
        echo "$(basename "$file")" >> ca-bundle.crt
        cat "$file" >> ca-bundle.crt
        echo >> ca-bundle.crt
    done

    # Install certificates from internet.
    ${concatStringsSep "\n"
      (map (cert: ''
                    file=${fetchurl cert}
                    echo "$(basename "$file")" >> ca-bundle.crt
                    cat $file >> ca-bundle.crt
                    echo >> ca-bundle.crt
                  '')
        (import ./certs.nix))}
  '';
  installPhase = ''
    mkdir -pv $out/etc/ssl/certs
    cp -v ca-bundle.crt $out/etc/ssl/certs
    # install individual certs in unbundled output
    mkdir -pv $unbundled/etc/ssl/certs
    cp -v *.crt $unbundled/etc/ssl/certs
    cd $unbundled/etc/ssl/certs
    chmod 755 .
    cp ${openssl}/bin/c_rehash .
    chmod a+x ./c_rehash
    ln -s ${openssl}/bin/openssl .
    substituteInPlace c_rehash --replace "/usr/bin/env perl" ${perl}/bin/perl
    export PATH=$PWD:$PATH
    ./c_rehash .
    cd -
    ln -s $unbundled/etc/ssl/certs/ca-bundle.crt $unbundled/etc/ssl/certs/ca-certificates.crt
  '';
})
