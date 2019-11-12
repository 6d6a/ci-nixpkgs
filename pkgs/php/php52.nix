{ lib, stdenv, apacheHttpd, autoconf, autoconf213, automake, bison, bzip2
, callPackage, connectorc, curl, expat, fetchurl, flex, freetype, gettext, glibc
, glibcLocales, gmp, html-tidy, icu, icu58, kerberos, libargon2, libiconv
, libjpeg, libjpeg130, libjpegv6b, libmcrypt, libmhash, libpng, libpng12
, libsodium, libtidy, libxml2, libxslt, libwebp, libzip, openssl, pam
, pcre, pcre2, pcre831, pkgconfig, postfix, postgresql, readline, sablotron
, sqlite, t1lib, uwimap, xorg, zlib }:
with lib;
stdenv.mkDerivation {
  name = "php52-${version}";
  version = "5.2.17";

  srcs = [
    (fetchurl {
      url = "https://museum.php.net/php5/php-5.2.17.tar.bz2";
      sha256 =
        "e81beb13ec242ab700e56f366e9da52fd6cf18961d155b23304ca870e53f116c";
    })
    (fetchGit {
      url = "https://gitlab.intr/pyhalov/php52-extra.git";
      ref = "master";
    })
  ];

  sourceRoot = [ "php-5.2.17" ];

  enableParallelBuilding = true;
  stripDebugList = "bin sbin lib modules";
  checkTarget = "test";
  doCheck = true;
  postConfigure = [
    ''
      sed -i ./main/build-defs.h -e '/PHP_INSTALL_IT/d'
      sed -i ./main/build-defs.h -e '/CONFIGURE_COMMAND/d'
    ''
    ''
      substituteInPlace configure --replace enable_experimental_zts=yes enable_experimental_zts=no
    ''
  ];
  preConfigure = [
    ''
      # Don't record the configure flags since this causes unnecessary
      # runtime dependencies
      for i in main/build-defs.h.in scripts/php-config.in; do
        substituteInPlace $i \
          --replace '@CONFIGURE_COMMAND@' '(omitted)' \
          --replace '@CONFIGURE_OPTIONS@' "" \
          --replace '@PHP_LDFLAGS@' ""
      done
    ''
    ''
      substituteInPlace ext/gmp/gmp.c \
        --replace '__GMP_BITS_PER_MP_LIMB' 'GMP_LIMB_BITS'
    ''
    ''
      cp -vr ../source/* ./
    ''
    ''
      substituteInPlace ext/tidy/tidy.c --replace buffio.h tidybuffio.h
    ''
    ''
      substituteInPlace configure \
        --replace enable_maintainer_zts=yes enable_maintainer_zts=no
    ''
    ''
      [[ -z "$libxml2" ]] || addToSearchPath PATH $libxml2/bin

      export EXTENSION_DIR=$out/lib/php/extensions

      configureFlags+=(--with-config-file-path=$out/etc \
        --includedir=$dev/include)

      ./buildconf --force
    ''
  ];
  preCheck = [
    ''
      for file in  ext/posix/tests/posix_getgrgid.phpt ext/sockets/tests/bug63000.phpt ext/sockets/tests/socket_shutdown.phpt ext/sockets/tests/socket_send.phpt ext/sockets/tests/mcast_ipv4_recv.phpt ext/standard/tests/general_functions/getservbyname_basic.phpt ext/standard/tests/general_functions/getservbyport_basic.phpt ext/standard/tests/general_functions/getservbyport_variation1.phpt ext/standard/tests/network/getprotobyname_basic.phpt ext/standard/tests/network/getprotobynumber_basic.phpt ext/standard/tests/strings/setlocale_basic1.phpt ext/standard/tests/strings/setlocale_basic2.phpt ext/standard/tests/strings/setlocale_basic3.phpt ext/standard/tests/strings/setlocale_variation1.phpt ext/gd/tests/bug39780_extern.phpt ext/gd/tests/libgd00086_extern.phpt ext/gd/tests/bug45799.phpt ext/gd/tests/bug66356.phpt ext/gd/tests/bug72339.phpt ext/gd/tests/bug72482.phpt ext/gd/tests/bug72482_2.phpt ext/gd/tests/bug73213.phpt ext/gd/tests/createfromwbmp2_extern.phpt ext/gd/tests/bug65148.phpt ext/gd/tests/bug77198_auto.phpt ext/gd/tests/bug77198_threshold.phpt ext/gd/tests/bug77200.phpt ext/gd/tests/bug77269.phpt ext/gd/tests/xpm2gd.phpt ext/gd/tests/xpm2jpg.phpt ext/gd/tests/xpm2png.phpt ext/gd/tests/bug77479.phpt ext/gd/tests/bug77272.phpt ext/gd/tests/bug77973.phpt ext/iconv/tests/bug52211.phpt ext/iconv/tests/bug60494.phpt ext/iconv/tests/iconv_mime_decode_variation3.phpt ext/iconv/tests/iconv_strlen_error2.phpt ext/iconv/tests/iconv_strlen_variation2.phpt ext/iconv/tests/iconv_substr_error2.phpt ext/iconv/tests/iconv_strpos_error2.phpt ext/iconv/tests/iconv_strrpos_error2.phpt ext/iconv/tests/iconv_strpos_variation4.phpt ext/iconv/tests/iconv_strrpos_variation3.phpt ext/iconv/tests/bug76249.phpt ext/curl/tests/bug61948.phpt ext/curl/tests/curl_basic_009.phpt ext/standard/tests/file/bug41655_1.phpt ext/standard/tests/file/glob_variation5.phpt ext/standard/tests/streams/proc_open_bug64438.phpt ext/gd/tests/bug43073.phpt ext/gd/tests/bug48732-mb.phpt ext/gd/tests/bug48732.phpt ext/gd/tests/bug48801-mb.phpt ext/gd/tests/bug48801.phpt ext/gd/tests/bug53504.phpt ext/gd/tests/bug73272.phpt ext/iconv/tests/bug48147.phpt ext/iconv/tests/bug51250.phpt ext/iconv/tests/iconv003.phpt ext/iconv/tests/iconv_mime_encode.phpt ext/standard/tests/file/bug43008.phpt ext/pdo_sqlite/tests/bug_42589.phpt ext/mbstring/tests/mb_ereg_variation3.phpt ext/mbstring/tests/mb_ereg_replace_variation1.phpt ext/mbstring/tests/bug72994.phpt ext/mbstring/tests/bug77367.phpt ext/mbstring/tests/bug77370.phpt ext/mbstring/tests/bug77371.phpt ext/mbstring/tests/bug77381.phpt ext/mbstring/tests/mbregex_stack_limit.phpt ext/mbstring/tests/mbregex_stack_limit2.phpt ext/ldap/tests/ldap_set_option_error.phpt ext/ldap/tests/bug76248.phpt ext/pcre/tests/bug76909.phpt ext/curl/tests/bug64267.phpt ext/curl/tests/bug76675.phpt ext/date/tests/bug52480.phpt ext/date/tests/DateTime_add-fall-type2-type3.phpt ext/date/tests/DateTime_add-fall-type3-type2.phpt ext/date/tests/DateTime_add-fall-type3-type3.phpt ext/date/tests/DateTime_add-spring-type2-type3.phpt ext/date/tests/DateTime_add-spring-type3-type2.phpt ext/date/tests/DateTime_add-spring-type3-type3.phpt ext/date/tests/DateTime_diff-fall-type2-type3.phpt ext/date/tests/DateTime_diff-fall-type3-type2.phpt ext/date/tests/DateTime_diff-fall-type3-type3.phpt ext/date/tests/DateTime_diff-spring-type2-type3.phpt ext/date/tests/DateTime_diff-spring-type3-type2.phpt ext/date/tests/DateTime_diff-spring-type3-type3.phpt ext/date/tests/DateTime_sub-fall-type2-type3.phpt ext/date/tests/DateTime_sub-fall-type3-type2.phpt ext/date/tests/DateTime_sub-fall-type3-type3.phpt ext/date/tests/DateTime_sub-spring-type2-type3.phpt ext/date/tests/DateTime_sub-spring-type3-type2.phpt ext/date/tests/DateTime_sub-spring-type3-type3.phpt ext/date/tests/rfc-datetime_and_daylight_saving_time-type3-bd2.phpt ext/date/tests/rfc-datetime_and_daylight_saving_time-type3-fs.phpt ext/filter/tests/bug49184.phpt ext/filter/tests/bug67167.02.phpt ext/iconv/tests/bug48147.phpt ext/iconv/tests/bug51250.phpt ext/iconv/tests/bug52211.phpt ext/iconv/tests/bug60494.phpt ext/iconv/tests/bug76249.phpt ext/iconv/tests/iconv_mime_decode_variation3.phpt ext/iconv/tests/iconv_mime_encode.phpt ext/iconv/tests/iconv_strlen_error2.phpt ext/iconv/tests/iconv_strlen_variation2.phpt ext/iconv/tests/iconv_strpos_error2.phpt ext/iconv/tests/iconv_strpos_variation4.phpt ext/iconv/tests/iconv_strrpos_error2.phpt ext/iconv/tests/iconv_strrpos_variation3.phpt ext/iconv/tests/iconv_substr_error2.phpt ext/mbstring/tests/bug52861.phpt ext/mbstring/tests/mb_send_mail01.phpt ext/mbstring/tests/mb_send_mail02.phpt ext/mbstring/tests/mb_send_mail03.phpt ext/mbstring/tests/mb_send_mail04.phpt ext/mbstring/tests/mb_send_mail05.phpt ext/mbstring/tests/mb_send_mail06.phpt ext/mbstring/tests/mb_send_mail07.phpt ext/openssl/tests/bug65538_002.phpt ext/pdo_sqlite/tests/bug_42589.phpt ext/pdo_sqlite/tests/pdo_022.phpt ext/phar/tests/bug69958.phpt ext/posix/tests/posix_errno_variation1.phpt ext/posix/tests/posix_errno_variation2.phpt ext/posix/tests/posix_kill_basic.phpt ext/session/tests/bug71162.phpt ext/session/tests/bug73529.phpt ext/soap/tests/bug71610.phpt ext/soap/tests/bugs/bug76348.phpt ext/sockets/tests/mcast_ipv4_recv.phpt ext/sockets/tests/socket_bind.phpt ext/sockets/tests/socket_send.phpt ext/sockets/tests/socket_shutdown.phpt ext/standard/tests/file/006_variation2.phpt ext/standard/tests/file/bug41655_1.phpt ext/standard/tests/file/bug43008.phpt ext/standard/tests/file/chmod_basic.phpt ext/standard/tests/file/chmod_variation4.phpt ext/standard/tests/general_functions/getservbyname_basic.phpt ext/standard/tests/general_functions/getservbyport_basic.phpt ext/standard/tests/general_functions/getservbyport_variation1.phpt ext/standard/tests/general_functions/proc_nice_basic.phpt ext/standard/tests/network/gethostbyname_error004.phpt ext/standard/tests/network/getmxrr.phpt ext/standard/tests/network/getprotobyname_basic.phpt ext/standard/tests/network/getprotobynumber_basic.phpt ext/standard/tests/serialize/bug70219.phpt ext/standard/tests/streams/bug60602.phpt ext/standard/tests/streams/bug74090.phpt ext/standard/tests/streams/stream_context_tcp_nodelay_fopen.phpt ext/standard/tests/streams/stream_context_tcp_nodelay.phpt ext/tidy/tests/020.phpt sapi/cli/tests/cli_process_title_unix.phpt tests/output/stream_isatty_err.phpt tests/output/stream_isatty_in-err.phpt tests/output/stream_isatty_in-out.phpt tests/output/stream_isatty_out-err.phpt tests/output/stream_isatty_out.phpt tests/security/open_basedir_linkinfo.phpt Zend/tests/access_modifiers_008.phpt Zend/tests/access_modifiers_009.phpt Zend/tests/bug48770_2.phpt Zend/tests/bug48770_3.phpt Zend/tests/bug48770.phpt Zend/tests/method_static_var.phpt ext/curl/tests/curl_multi_info_read.phpt; do
        rm $file || true
      done
    ''
    ''
      for file in  ext/standard/tests/streams/proc_open_bug60120.phpt; do
        rm $file || true
      done
    ''
  ];
  patches = [
    ./php52-backport_crypt_from_php53.patch
    ./php52-configure.patch
    ./php52-zts.patch
    ./php52-fix-pcre-php52.patch
    ./php52-debian_patches_disable_SSLv2_for_openssl_1_0_0.patch.patch
    ./php52-fix-exif-buffer-overflow.patch
    ./php52-libxml2-2-9_adapt_documenttype.patch
    ./php52-libxml2-2-9_adapt_node.patch
    ./php52-libxml2-2-9_adapt_simplexml.patch
    ./php52-mj_engineers_apache2_4_abi_fix.patch
    ./php52-fix-mysqli-buffer-overflow.patch
    ./php52-add-configure-flags.patch

  ];
  hardeningDisable = [ "bindnow" ];
  CXXFLAGS = "-std=c++11";
  buildInputs = [
    apacheHttpd
    automake
    bison
    bzip2
    curl
    flex
    freetype
    gettext
    glibcLocales
    gmp
    kerberos
    libiconv
    libmcrypt
    libmhash
    html-tidy
    libxml2
    libxslt
    openssl
    pam
    postfix
    postgresql
    readline
    sablotron
    sqlite
    t1lib
    uwimap
    xorg.libXpm
    zlib
    libpng
    libmhash
    pcre
    connectorc
    icu
    libjpeg
  ];
  nativeBuildInputs = [ pkgconfig autoconf213 ];
  configureFlags = [
    "--disable-cgi"
    "--disable-debug"
    "--disable-maintainer-zts"
    "--enable-bcmath"
    "--enable-calendar"
    "--enable-dba"
    "--enable-dom"
    "--enable-exif"
    "--enable-ftp"
    "--enable-gd-native-ttf"
    "--enable-inline-optimization"
    "--enable-magic-quotes"
    "--enable-mbstring"
    "--enable-pdo"
    "--enable-soap"
    "--enable-sockets"
    "--enable-sysvsem"
    "--enable-sysvshm"
    "--enable-zip"
    "--with-apxs2=${apacheHttpd.dev}/bin/apxs"
    "--with-bz2=${bzip2.dev}"
    "--with-curl=${curl.dev}"
    "--with-freetype-dir=${freetype.dev}"
    "--with-gd"
    "--with-gmp=${gmp.dev}"
    "--with-imap-ssl"
    "--with-imap=${uwimap}"
    "--with-mcrypt=${libmcrypt}"
    "--with-mhash"
    "--with-openssl"
    "--with-pdo-pgsql=${postgresql}"
    "--with-pdo-sqlite=${sqlite.dev}"
    "--with-pdo-mysql=${connectorc}"
    "--with-pgsql=${postgresql}"
    "--with-readline=${readline.dev}"
    "--with-tidy=${html-tidy}"
    "--with-xsl=${libxslt.dev}"
    "--with-xslt-sablot=${sablotron}"
    "--with-zlib=${zlib.dev}"
    "--with-png-dir=${libpng12}"
    "--with-mhash=${libmhash}"
    "--with-dbase"
    "--with-config-file-scan-dir=/run/php52.d/"
    "--with-gettext=${glibc.dev}"
    "--enable-libxml"
    "--with-libxml-dir=${libxml2.dev}"
    "--with-xmlrpc"
    "--with-xslt"
    "--with-mysql=${connectorc}"
    "--with-mysqli=${connectorc}/bin/mysql_config"
    "--with-jpeg-dir=${libjpeg130}"
  ];
}
