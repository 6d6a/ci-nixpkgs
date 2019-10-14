self: super:

rec {
  inherit (super) callPackage;

  lib = super.lib // (import ./lib.nix { pkgs = self; });

  wordpress = callPackage ./pkgs/wordpress {};

  apacheHttpd = callPackage ./pkgs/apacheHttpd {};
  apacheHttpdmpmITK = callPackage ./pkgs/apacheHttpdmpmITK {};
  connectorc = callPackage ./pkgs/connectorc {};
  ioncube = callPackage ./pkgs/ioncube {};
  libjpeg130 = callPackage ./pkgs/libjpeg130 {};
  libpng12 = callPackage ./pkgs/libpng12 {};
  elktail = callPackage ./pkgs/elktail {};
  clamchk = callPackage ./pkgs/clamchk {};
  luajitPackages = super.luajitPackages // (callPackage ./pkgs/luajit-packages { lua = openrestyLuajit2; });
  mjHttpErrorPages = callPackage ./pkgs/mj-http-error-pages {};

  mjperl5Packages = (callPackage ./pkgs/mjperl5Packages {}).mjPerlPackages.perls;
  mjperl5lib = (callPackage ./pkgs/mjperl5Packages {}).mjPerlPackages.mjPerlModules;
  mjPerlPackages = mjperl5Packages;
  TextTruncate = mjPerlPackages.TextTruncate;
  TimeLocal = mjPerlPackages.TimeLocal;
  PerlMagick = mjPerlPackages.PerlMagick;
  commonsense = mjPerlPackages.commonsense;
  Mojolicious = mjPerlPackages.Mojolicious;
  base = mjPerlPackages.base;
  libxml_perl = mjPerlPackages.libxml_perl;
  libnet = mjPerlPackages.libnet;
  libintl_perl = mjPerlPackages.libintl_perl;
  LWP = mjPerlPackages.LWP;
  ListMoreUtilsXS = mjPerlPackages.ListMoreUtilsXS;
  LWPProtocolHttps = mjPerlPackages.LWPProtocolHttps;
  DBI = mjPerlPackages.DBI;
  DBDmysql = mjPerlPackages.DBDmysql;
  CGI = mjPerlPackages.CGI;
  FilePath = mjPerlPackages.FilePath;
  DigestPerlMD5 = mjPerlPackages.DigestPerlMD5;
  DigestSHA1 = mjPerlPackages.DigestSHA1;
  FileBOM = mjPerlPackages.FileBOM;
  GD = mjPerlPackages.GD;
  LocaleGettext = mjPerlPackages.LocaleGettext;
  HashDiff = mjPerlPackages.HashDiff;
  JSONXS = mjPerlPackages.JSONXS;
  POSIXstrftimeCompiler = mjPerlPackages.POSIXstrftimeCompiler;
  perl = mjPerlPackages.perl;

  nginxModules = super.nginxModules // (callPackage ./pkgs/nginx-modules {});
  nginx = callPackage ./pkgs/nginx {};

  openrestyLuajit2 = callPackage ./pkgs/openresty-luajit2 {};
  pcre831 = callPackage ./pkgs/pcre831 {};
  penlight = luajitPackages.penlight;
  postfix = callPackage ./pkgs/postfix {};
  sockexec = callPackage ./pkgs/sockexec {};
  zendoptimizer = callPackage ./pkgs/zendoptimizer {};

  libjpegv6b = callPackage ./pkgs/libjpegv6b {};

  imagemagick68 = callPackage ./pkgs/imagemagick68 {};

  php = callPackage ./pkgs/php {};

  php70 = php.php70;
  php71 = php.php71;
  php72 = php.php72;
  php73 = php.php73;

  php73zts = php.php73zts;

  php73ztsFpm = php.php73ztsFpm;

  phpPackages = callPackage ./pkgs/php-packages {};

  php70Packages = phpPackages.php70Packages;
  php70-imagick = php70Packages.imagick;
  php70-memcached = php70Packages.memcached;
  php70-redis = php70Packages.redis;
  php70-rrd = php70Packages.rrd;
  php70-timezonedb = php70Packages.timezonedb;

  php71Packages = phpPackages.php71Packages;
  php71-imagick = php71Packages.imagick;
  php71-libsodiumPhp = php71Packages.libsodiumPhp;
  php71-memcached = php71Packages.memcached;
  php71-redis = php71Packages.redis;
  php71-rrd = php71Packages.rrd;
  php71-timezonedb = php71Packages.timezonedb;

  php72Packages = phpPackages.php72Packages;
  php72-imagick = php72Packages.imagick;
  php72-memcached = php72Packages.memcached;
  php72-redis = php72Packages.redis;
  php72-rrd = php72Packages.rrd;
  php72-timezonedb = php72Packages.timezonedb;

  php73Packages = phpPackages.php73Packages;
  php73-imagick = php73Packages.imagick;
  php73-memcached = php73Packages.memcached;
  php73-redis = php73Packages.redis;
  php73-rrd = php73Packages.rrd;
  php73-timezonedb = php73Packages.timezonedb;

  pure-ftpd = callPackage ./pkgs/pure-ftpd {};

  phpinfoCompare = callPackage ./pkgs/phpinfo-compare {};

  mcron = callPackage ./pkgs/mcron {};

  locale = callPackage ./pkgs/locale {};

  sh = callPackage ./pkgs/sh {};

  maketestPhp = {php, image, rootfs, ...}@args:
    callPackage ./pkgs/docker/tests.nix args;

  inetutilsMinimal = callPackage ./pkgs/inetutils-minimal {};
}
