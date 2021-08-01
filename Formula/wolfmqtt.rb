class Wolfmqtt < Formula
  desc "Small, fast, portable MQTT client C implementation"
  homepage "https://github.com/wolfSSL/wolfMQTT"
  url "https://github.com/wolfSSL/wolfMQTT/releases/download/v1.9/wolfMQTT-1.9.tar.gz"
  sha256 "7f3668b7e5f025d0bf2b4d32dc26c292e617b04f5e531a66240af086f2062b62"
  license "GPL-2.0-or-later"
  head "https://github.com/wolfSSL/wolfMQTT.git"

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "9dbed9dab1a056b8def79ca789b583f8e3b28b4f1b3571b849bd79fe2844c1bc"
    sha256 cellar: :any,                 big_sur:       "0e500f223cdac295647510e777e4afaf37b51670a23e38e576e6d1244d4feff8"
    sha256 cellar: :any,                 catalina:      "ee6bbe790e69aba3891af042d7a3f2bde6af8e7b19cce2392258e2ebc1a32dcb"
    sha256 cellar: :any,                 mojave:        "246f40624e64bf5219a93a174cfd0462317786d2de69db74ba2b348b35e5e03e"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "wolfssl"

  def install
    args = %W[
      --disable-silent-rules
      --disable-dependency-tracking
      --infodir=#{info}
      --mandir=#{man}
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --enable-nonblock
      --enable-mt
      --enable-mqtt5
      --enable-propcb
      --enable-sn
    ]

    system "./autogen.sh"
    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOT
      #include <wolfmqtt/mqtt_client.h>
      int main() {
        MqttClient mqttClient;
        return 0;
      }
    EOT
    system ENV.cc, "test.cpp", "-L#{lib}", "-lwolfmqtt", "-o", "test"
    system "./test"
  end
end
