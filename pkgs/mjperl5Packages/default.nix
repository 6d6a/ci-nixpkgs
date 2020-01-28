{ pkgs, lib, stdenv, perl, perlPackages }:

# TODO:
#
# Failed to find: 'WPUserAgentDetermined' , 'Webinject',
# 'UnicodeUTF8', , 'UnicodeMap', 'TextASCIITable' 2'TermSize',
# 'ScalarUtilNumeric' , 'RPCXML' , 'Quota', 'NetIPv6Addr', ,
# 'NetIPv4Addr' 'NetCUPS', 'AlgorithmDiffXS' 'ApacheReload'
# 'DateCalcXS', , 'YAMLSyck' 'DigestBubbleBabble' 'Dpkg', 'Filechmod',
# 'FileFcntlLock', 'HTMLFormat', 'HTMLTemplatePro', 'IOSocketINET6', ,
# 'libwwwperl', 'libxmlperl', 'YAMLAppConfig' , 'MIMEBase32'
# 'mimetypes', 'NagiosPlugin',
#
# Failing test: 'NetAddrIP', 'DataValidateIP'.

let
  # add new modules at ./nixpkgs/pkgs/top-level/perl-packages.nix
  perls = {
    DateTime = perlPackages.DateTime;
    NetHTTP = perlPackages.NetHTTP;
    Carp = perlPackages.Carp;
    EmailDateFormat = perlPackages.EmailDateFormat;
    RTFWriter = perlPackages.RTFWriter;
    URIEscape = perlPackages.URIEscape;
    perl5lib = perlPackages.Perl5lib;
    # Propagates gcc
    # mod_perl2 = perlPackages.mod_perl2;
    TestTester = perlPackages.TestTester;
    ArchiveZip = perlPackages.ArchiveZip;
    EncodeLocale = perlPackages.EncodeLocale;
    TextTruncate = perlPackages.TextTruncate;
    MIMEBase64 = perlPackages.MIMEBase64;
    TemplateToolkit = perlPackages.TemplateToolkit;
    OpenOfficeOODoc = perlPackages.OpenOfficeOODoc;
    IOStty = perlPackages.IOStty;
    CarpAlways = perlPackages.CarpAlways;
    CarpAssertMore = perlPackages.CarpAssertMore;
    CarpAssert = perlPackages.CarpAssert;
    CarpClan = perlPackages.CarpClan;
    DataDumper = perlPackages.DataDumper;
    FileCopyRecursive = perlPackages.FileCopyRecursive;
    FileCopyRecursiveReduced = perlPackages.FileCopyRecursiveReduced;
    HTMLTemplate = perlPackages.HTMLTemplate;
    ImageInfo = perlPackages.ImageInfo;
    MIMELite = perlPackages.MIMELite;
    SpreadsheetParseExcel = perlPackages.SpreadsheetParseExcel;
    SpreadsheetWriteExcel = perlPackages.SpreadsheetWriteExcel;
    TextIconv = perlPackages.TextIconv;
    FCGI = perlPackages.FCGI;
    FCGIProcManager = perlPackages.FCGIProcManager;
    XMLSimple = perlPackages.XMLSimple;
    ApacheTest = perlPackages.ApacheTest;
    TimeLocal = perlPackages.TimeLocal;
    PerlMagick = perlPackages.PerlMagick;
    commonsense = perlPackages.commonsense;
    Mojolicious = perlPackages.Mojolicious;
    base = perlPackages.base;
    libxml_perl = perlPackages.libxml_perl;
    libnet = perlPackages.libnet;
    libintl_perl = perlPackages.libintl_perl;
    LWP = perlPackages.LWP;
    ListMoreUtilsXS = perlPackages.ListMoreUtilsXS;
    LWPProtocolHttps = perlPackages.LWPProtocolHttps;
    DBI = perlPackages.DBI;
    DBDmysql = perlPackages.DBDmysql;
    CGI = perlPackages.CGI;
    FilePath = perlPackages.FilePath;
    DigestPerlMD5 = perlPackages.DigestPerlMD5;
    DigestSHA1 = perlPackages.DigestSHA1;
    FileBOM = perlPackages.FileBOM;
    GD = perlPackages.GD;
    LocaleGettext = perlPackages.LocaleGettext;
    HashDiff = perlPackages.HashDiff;
    POSIXstrftimeCompiler = perlPackages.POSIXstrftimeCompiler;
    HTMLParser = perlPackages.HTMLParser;
    HTTPDate = perlPackages.HTTPDate;
    TryTiny = perlPackages.TryTiny;
    perl = perlPackages.perl;
    TypesSerialiser = perlPackages.TypesSerialiser;
    XMLLibXML = perlPackages.XMLLibXML;
    XMLSAX = perlPackages.XMLSAX;
    XMLSAXBase = perlPackages.XMLSAXBase;
    AlgorithmDiff = perlPackages.AlgorithmDiff;
    AuthenSASL = perlPackages.AuthenSASL;
    CacheMemcached = perlPackages.CacheMemcached;
    # AlgorithmDiffXS = perlPackages.AlgorithmDiffXS;
    AlgorithmMerge = perlPackages.AlgorithmMerge;
    # ApacheReload = perlPackages.ApacheReload;
    ArchiveExtract = perlPackages.ArchiveExtract;
    BitVector = perlPackages.BitVector;
    BSDResource = perlPackages.BSDResource;
    ClassAccessor = perlPackages.ClassAccessor;
    ClassFactoryUtil = perlPackages.ClassFactoryUtil;
    ClassLoad = perlPackages.ClassLoad;
    ClassLoadXS = perlPackages.ClassLoadXS;
    ClassSingleton = perlPackages.ClassSingleton;
    ConfigIniFiles = perlPackages.ConfigIniFiles;
    ConfigTiny = perlPackages.ConfigTiny;
    CryptSSLeay = perlPackages.CryptSSLeay;
    DataOptList = perlPackages.DataOptList;
    # DataValidateIP = perlPackages.DataValidateIP;
    DateCalc = perlPackages.DateCalc;
    # DateCalcXS = perlPackages.DateCalcXS;
    DateManip = perlPackages.DateManip;
    DateTimeFormatBuilder = perlPackages.DateTimeFormatBuilder;
    DateTimeFormatISO8601 = perlPackages.DateTimeFormatISO8601;
    DevelSymdump = perlPackages.DevelSymdump;
    # DigestBubbleBabble = perlPackages.DigestBubbleBabble;
    DigestHMAC = perlPackages.DigestHMAC;
    # Dpkg = perlPackages.Dpkg;
    # Filechmod = perlPackages.Filechmod;
    # FileFcntlLock = perlPackages.FileFcntlLock;
    FileListing = perlPackages.FileListing;
    FilePid = perlPackages.FilePid;
    FontAFM = perlPackages.FontAFM;
    HTMLForm = perlPackages.HTMLForm;
    # HTMLFormat = perlPackages.HTMLFormat;
    HTMLTagset = perlPackages.HTMLTagset;
    # HTMLTemplatePro = perlPackages.HTMLTemplatePro;
    HTMLTree = perlPackages.HTMLTree;
    HTTPCookies = perlPackages.HTTPCookies;
    HTTPDaemon = perlPackages.HTTPDaemon;
    HTTPMessage = perlPackages.HTTPMessage;
    HTTPNegotiate = perlPackages.HTTPNegotiate;
    IOHTML = perlPackages.IOHTML;
    # IOSocketINET6 = perlPackages.IOSocketINET6;
    IOSocketSSL = perlPackages.IOSocketSSL;
    IOString = perlPackages.IOString;
    IOstringy = perlPackages.IOstringy;
    IPCRun = perlPackages.IPCRun;
    JSON = perlPackages.JSON;
    JSONXS = perlPackages.JSONXS;
    # libwwwperl = perlPackages.libwwwperl;
    # libxmlperl = perlPackages.libxmlperl;
    ListAllUtils = perlPackages.ListAllUtils;
    ListMoreUtils = perlPackages.ListMoreUtils;
    LogMessageSimple = perlPackages.LogMessageSimple;
    LWPMediaTypes = perlPackages.LWPMediaTypes;
    LWPProtocolhttps = perlPackages.LWPProtocolhttps;
    MailIMAPClient = perlPackages.MailIMAPClient;
    MailTools = perlPackages.MailTools;
    MathCalcUnits = perlPackages.MathCalcUnits;
    # MIMEBase32 = perlPackages.MIMEBase32;
    # mimetypes = perlPackages.mimetypes;
    ModuleImplementation = perlPackages.ModuleImplementation;
    ModulePluggable = perlPackages.ModulePluggable;
    ModuleRuntime = perlPackages.ModuleRuntime;
    # NagiosPlugin = perlPackages.NagiosPlugin;
    # NetAddrIP = perlPackages.NetAddrIP;
    # NetCUPS = perlPackages.NetCUPS;
    NetIP = perlPackages.NetIP;
    # NetIPv4Addr = perlPackages.NetIPv4Addr;
    # NetIPv6Addr = perlPackages.NetIPv6Addr;
    NetNetmask = perlPackages.NetNetmask;
    NetSMTPSSL = perlPackages.NetSMTPSSL;
    NetSMTPTLS = perlPackages.NetSMTPTLS;
    NetSSLeay = perlPackages.NetSSLeay;
    OLEStorage_Lite = perlPackages.OLEStorage_Lite;
    PackageStash = perlPackages.PackageStash;
    PackageStashXS = perlPackages.PackageStashXS;
    ParallelForkManager = perlPackages.ParallelForkManager;
    ParamsClassify = perlPackages.ParamsClassify;
    ParamsUtil = perlPackages.ParamsUtil;
    ParamsValidate = perlPackages.ParamsValidate;
    ParseRecDescent = perlPackages.ParseRecDescent;
    PodLaTeX = perlPackages.PodLaTeX;
    # Quota = perlPackages.Quota;
    Readonly = perlPackages.Readonly;
    ReadonlyXS = perlPackages.ReadonlyXS;
    # RPCXML = perlPackages.RPCXML;
    # ScalarUtilNumeric = perlPackages.ScalarUtilNumeric;
    Socket6 = perlPackages.Socket6;
    Specio = perlPackages.Specio;
    StringCRC32 = perlPackages.StringCRC32;
    SubInstall = perlPackages.SubInstall;
    SubName = perlPackages.SubName;
    Switch = perlPackages.Switch;
    TermReadKey = perlPackages.TermReadKey;
    # TermSize = perlPackages.TermSize;
    TermUI = perlPackages.TermUI;
    # TextASCIITable = perlPackages.TextASCIITable;
    TextCharWidth = perlPackages.TextCharWidth;
    TextSoundex = perlPackages.TextSoundex;
    TextWrapI18N = perlPackages.TextWrapI18N;
    TimeDate = perlPackages.TimeDate;
    # UnicodeMap = perlPackages.UnicodeMap;
    UnicodeString = perlPackages.UnicodeString;
    # UnicodeUTF8 = perlPackages.UnicodeUTF8;
    URI = perlPackages.URI;
    # Webinject = perlPackages.Webinject;
    # WPUserAgentDetermined = perlPackages.WPUserAgentDetermined;
    WWWRobotRules = perlPackages.WWWRobotRules;
    XMLNamespaceSupport = perlPackages.XMLNamespaceSupport;
    XMLSAXExpat = perlPackages.XMLSAXExpat;
    YAML = perlPackages.YAML;
    # YAMLAppConfig = perlPackages.YAMLAppConfig;
    # YAMLSyck = perlPackages.YAMLSyck;
  };

  perl-drv = lib.attrValues perls;

  # Install all Perl packages in a single package
  perl-union = stdenv.mkDerivation {
    name = "perl-union";
    buildInputs = perl-drv;
    phases = [ "buildPhase" "installPhase" ];
    buildPhase = ''
      env
    '';
    installPhase = ''
       for package in ${lib.concatStringsSep " " (lib.filter (x: x != null) perl-drv)}; do
         ${pkgs.rsync}/bin/rsync --exclude='.packlist' --exclude='bin' --exclude='propagated-build-inputs' -qav $package/ $out/
       done
    '';
  };

in

{
  mjPerlPackages = {
    perls = perl-union;
    mjPerlModules = stdenv.mkDerivation rec {
      name = "mjperl";
      nativeBuildInputs = [ perl ];
      buildInputs = [ perl-union ];
      src = ./perlmodules;
      buildPhase = ''
        export perl5lib="${perl}/lib/perl5:${perl-union}/lib/perl5/site_perl:."
        echo ${perl-union}
        substituteInPlace ./perl_modules.conf --subst-var perl5lib
        substituteInPlace ./perl_modules_modperl.conf --subst-var perl5lib
        substituteInPlace ./environment --subst-var perl5lib
      '';
      installPhase = ''
         mkdir -p $out/etc/
         cp -pr ./ $out/
         cp -pr ./environment $out/etc/
      '';
    };
  };
}
