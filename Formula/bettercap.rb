class Bettercap < Formula
  desc "Swiss army knife for network attacks and monitoring"
  homepage "https://www.bettercap.org/"
  url "https://github.com/bettercap/bettercap/archive/v2.32.0.tar.gz"
  sha256 "ea28d4d533776a328a54723a74101d1720016ffe7d434bf1d7ab222adb397ac6"
  license "GPL-3.0-only"
  head "https://github.com/bettercap/bettercap.git", branch: "master"

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "e52d4ecc4d9b34037d66f1399b4111f3753ac6fde6fdebb922170367d82578f2"
    sha256 cellar: :any,                 big_sur:       "6ca4df5dc6af80e97961923613220f3930989b3b2ef2911609a719003500d613"
    sha256 cellar: :any,                 catalina:      "d719df24fe3a24f2712fd5e08027b20ec0cf4a1e3e9f659d1b085a0b23bc7ee8"
    sha256 cellar: :any,                 mojave:        "cb44f7b4fed4e8c10049d4e69f3745f78d07a70b03b77327b9e6d02e03e7c020"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "178b9e000b63477b586c4f31679b4e1aae6513efd454bbbc4f9a150719f47615" # linuxbrew-core
  end

  depends_on "go" => :build
  depends_on "pkg-config" => :build
  depends_on "libusb"

  uses_from_macos "libpcap"

  on_linux do
    depends_on "libnetfilter-queue"
  end

  def install
    system "make", "build"
    bin.install "bettercap"
  end

  def caveats
    <<~EOS
      bettercap requires root privileges so you will need to run `sudo bettercap`.
      You should be certain that you trust any software you grant root privileges.
    EOS
  end

  test do
    on_macos do
      assert_match "Operation not permitted", shell_output(bin/"bettercap 2>&1", 1)
    end

    on_linux do
      assert_match "Permission Denied", shell_output(bin/"bettercap 2>&1", 1)
    end
  end
end
