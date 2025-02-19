class Libjwt < Formula
  desc "JSON Web Token C library"
  homepage "https://github.com/benmcollins/libjwt"
  url "https://github.com/benmcollins/libjwt/archive/v1.13.1.tar.gz"
  sha256 "4df55ac89c6692adaf3badb43daf3241fd876612c9ab627e250dfc4bb59993d9"
  license "MPL-2.0"

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "4d89729e216bebd3dcd95d7edca9050b125387a122e1525f2b647175074154aa"
    sha256 cellar: :any,                 big_sur:       "6007f616df31c2f700524c3dab66d9f09f5b9bcca728ac7e1b848000aabece90"
    sha256 cellar: :any,                 catalina:      "fb6e811d2e09405a322bccac174af800742fc0655a8e72a1220311eacec1b78a"
    sha256 cellar: :any,                 mojave:        "97801be0001a6c9a180d425ffecc9cef4d51a2bd246c71ec4d60c7a0016ce490"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5f2510df67dc43abe65670cc1828e1ed7e62ed9100ee196f328220451418fc59" # linuxbrew-core
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "jansson"
  depends_on "openssl@1.1"

  def install
    system "autoreconf", "-fiv"
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "all"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <stdlib.h>
      #include <jwt.h>

      int main() {
        jwt_t *jwt = NULL;
        if (jwt_new(&jwt) != 0) return 1;
        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-L#{lib}", "-I#{include}", "-ljwt", "-o", "test"
    system "./test"
  end
end
