class Sqliteodbc < Formula
  desc "ODBC driver for SQLite"
  homepage "https://ch-werner.homepage.t-online.de/sqliteodbc/"
  url "https://ch-werner.homepage.t-online.de/sqliteodbc/sqliteodbc-0.9998.tar.gz"
  sha256 "fabcbec73f98d1a34911636c02c29fc64147d27516b142e8e132c68c05a6065b"

  livecheck do
    url :homepage
    regex(/href=.*?sqliteodbc[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 big_sur:      "5f98876aef9733997e750451ee0e3db30cc2bd1f371aa690f08d7e4038f11958"
    sha256 cellar: :any,                 catalina:     "d0105cc73d44561e636923adb520710cdd7e0db835c6b31f151fe8a66a1b4fcc"
    sha256 cellar: :any,                 mojave:       "6499af774d13212bf19dfdbd14c18feadf516a5d6afbd2ebe7718d99db1723eb"
    sha256 cellar: :any,                 high_sierra:  "6220e24f32b5b26c5c983c9f9fb1aaa6aba7c13cad44a7500ecb72c7d7723a80"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "80fb4127ce50b43d98d4145585ff66471b4a9cc9de9191c2f5a52450b8dadac6" # linuxbrew-core
  end

  depends_on "sqlite"
  depends_on "unixodbc"

  uses_from_macos "libxml2"
  uses_from_macos "zlib"

  def install
    ENV["SDKROOT"] = MacOS.sdk_path if MacOS.version == :sierra

    lib.mkdir
    args = ["--with-odbc=#{Formula["unixodbc"].opt_prefix}",
            "--with-sqlite3=#{Formula["sqlite"].opt_prefix}"]
    args << "--with-libxml2=#{Formula["libxml2"].opt_prefix}" if OS.linux?

    system "./configure", "--prefix=#{prefix}", *args
    system "make"
    system "make", "install"
    lib.install_symlink lib/"libsqlite3odbc.dylib" => "libsqlite3odbc.so" if OS.mac?
  end

  test do
    output = shell_output("#{Formula["unixodbc"].opt_bin}/dltest #{lib}/libsqlite3odbc.so")
    assert_equal "SUCCESS: Loaded #{lib}/libsqlite3odbc.so\n", output
  end
end
