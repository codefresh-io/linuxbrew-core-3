class Codec2 < Formula
  desc "Open source speech codec"
  homepage "https://www.rowetel.com/?page_id=452"
  # Linked from https://freedv.org/
  url "https://github.com/drowe67/codec2/archive/v1.0.1.tar.gz"
  sha256 "14227963940d79e0ec5af810f37101b30e1c7e8555abd96c56b3c0473abac8ef"
  license "LGPL-2.1-only"

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "dca98080fb9c5738ffcc298547ce0c92a79349b7f04fea8056d968f63c34c1ca"
    sha256 cellar: :any,                 big_sur:       "5d4162b5b10568f57c326983cbebfe34c126bca31bd14923b0388d8f4ca785aa"
    sha256 cellar: :any,                 catalina:      "2834225209e520278515857dcada021ba2cc108f92131e8c6cc786070c336bf9"
    sha256 cellar: :any,                 mojave:        "a86e0264532c78b083ae12358ba569a43588c589c4f91569f620381e30a471b1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0ee9e9d8d105b256e74e35564feadec4228b77f341d3b3aa164873e568169106" # linuxbrew-core
  end

  depends_on "cmake" => :build

  def install
    mkdir "build_osx" do
      system "cmake", "..", *std_cmake_args, "-DCMAKE_EXE_LINKER_FLAGS=-Wl,-rpath,#{rpath}"
      system "make", "install"

      bin.install "demo/c2demo"
      bin.install Dir["src/c2*"]
    end
  end

  test do
    # 8 bytes of raw audio data (silence).
    (testpath/"test.raw").write([0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00].pack("C*"))
    system "#{bin}/c2enc", "2400", "test.raw", "test.c2"
  end
end
