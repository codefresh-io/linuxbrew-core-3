class Libdnet < Formula
  desc "Portable low-level networking library"
  homepage "https://github.com/ofalk/libdnet"
  url "https://github.com/ofalk/libdnet/archive/libdnet-1.14.tar.gz"
  sha256 "592599c54a57102a177270f3a2caabda2c2ac7768b977d7458feba97da923dfe"
  license "BSD-3-Clause"

  livecheck do
    url :homepage
    regex(/^libdnet[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    cellar :any
    sha256 "f8c9ace5eb112c484f50da7624df13c551b14114ece91a155ce2394b30e264b7" => :catalina
    sha256 "1e967ac6c5b9c70f72efba9082844c755dba2d62054a4c4dfbd5629da3cb0b76" => :mojave
    sha256 "fd53de5c1830dcdb52ecba97cf0c9c6afccf44037e6df6f64ef1d163d6c6adff" => :high_sierra
    sha256 "5c5af547c3581d357f028605acd9f3d09e999a34e0d07a38844d073f235f1ef7" => :x86_64_linux
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    # autoreconf to get '.dylib' extension on shared lib
    ENV.append_path "ACLOCAL_PATH", "config"
    system "autoreconf", "-ivf"

    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}"
    system "make", "install"
  end

  test do
    system "#{bin}/dnet-config", "--version"
  end
end
