class Shapelib < Formula
  desc "Library for reading and writing ArcView Shapefiles"
  homepage "http://shapelib.maptools.org/"
  url "https://download.osgeo.org/shapelib/shapelib-1.5.0.tar.gz"
  sha256 "1fc0a480982caef9e7b9423070b47750ba34cd0ba82668f2e638fab1d07adae1"
  license any_of: ["LGPL-2.0-or-later", "MIT"]

  livecheck do
    url "https://download.osgeo.org/shapelib/"
    regex(/href=.*?shapelib[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "3f95046988d245291a4fb9973051b5c006500ba3ab0bf2842ae330c18936bdca"
    sha256 cellar: :any,                 big_sur:       "dfae7491c46ca8ed8b587dd6dfa885b4ec6db8520095b1f1ae44becd28ca76d2"
    sha256 cellar: :any,                 catalina:      "9800e87eaeeca3eca0d59c3bca555c0211df96f021735251964981ac2b16bd90"
    sha256 cellar: :any,                 mojave:        "90f9b9b0ccadf93be027e515be356d0b92f4dfb33979f11df9fc7570c3249d0e"
    sha256 cellar: :any,                 high_sierra:   "f1242aaf566b272f69331d16441171b12d0b4cef8396b56e0a8246fe7618ca68"
    sha256 cellar: :any,                 sierra:        "0add799fff38395de6300f1b18102270bd269b5dc37714e7cac1873849b2ced7"
    sha256 cellar: :any,                 x86_64_linux:  "bdb7d0db9d5bbb9d44cad1a102144620b3484c24e55cca719ab7200fbc609a2d" # linuxbrew-core
  end

  depends_on "cmake" => :build

  def install
    # shapelib's CMake scripts interpret `CMAKE_INSTALL_LIBDIR=lib` as relative
    # to the current directory, i.e. `CMAKE_INSTALL_LIBDIR:PATH=$(pwd)/lib`
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args(install_libdir: lib)
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    assert_match "shp_file", shell_output("#{bin}/shptreedump", 1)
  end
end
