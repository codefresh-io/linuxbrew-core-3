class Sslh < Formula
  desc "Forward connections based on first data packet sent by client"
  homepage "https://www.rutschle.net/tech/sslh.shtml"
  url "https://www.rutschle.net/tech/sslh/sslh-v1.22c.tar.gz"
  sha256 "8e3742d14edf4119350cfdc7bb96b89134d9218eb6d2a6e1f70891ca18a649b1"
  license all_of: ["GPL-2.0-or-later", "BSD-2-Clause"]
  head "https://github.com/yrutschle/sslh.git", branch: "master"

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "2baa52312b06845b59164cefec82633805e3a25ce30b1838de8588c13a73c37f"
    sha256 cellar: :any,                 big_sur:       "d8dc78ae9611573a5af86e21e0ce9a1dc08f8b615a1efa6914a28f09e5d973c2"
    sha256 cellar: :any,                 catalina:      "54584832683d93d67a4d2ab440da431d5407e6f23ec4fac5d0a31743000f12de"
    sha256 cellar: :any,                 mojave:        "65ebb8d28f6c458a16e8e942d00135ffc6efa03d23ac6808b015201dfcb86b01"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3a1e0718034ef90999fb28e8121a899bc6e3c333602e83683f634ca1927a7ac9" # linuxbrew-core
  end

  depends_on "libconfig"
  depends_on "pcre2"

  uses_from_macos "netcat" => :test

  def install
    ENV.deparallelize
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    listen_port = free_port
    target_port = free_port

    fork do
      exec sbin/"sslh", "--http=localhost:#{target_port}", "--listen=localhost:#{listen_port}", "--foreground"
    end

    sleep 1
    system "nc", "-z", "localhost", listen_port
  end
end
