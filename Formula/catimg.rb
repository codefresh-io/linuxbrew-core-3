class Catimg < Formula
  desc "Insanely fast image printing in your terminal"
  homepage "https://github.com/posva/catimg"
  url "https://github.com/posva/catimg/archive/2.7.0.tar.gz"
  sha256 "3a6450316ff62fb07c3facb47ea208bf98f62abd02783e88c56f2a6508035139"
  license "MIT"
  head "https://github.com/posva/catimg.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "f5537238f20cc678e14f52ecdc1bdbf2b9d20d58d51a322ae044bad5c0df2418"
    sha256 cellar: :any_skip_relocation, big_sur:       "4ed745935b27937d85de5e28e9f3345be90bfc725349247cb3b9770a720fe134"
    sha256 cellar: :any_skip_relocation, catalina:      "076781a169c35bba3b5bac8b4e5ea89497b9e21993da49739b4d3b690c4fad2b"
    sha256 cellar: :any_skip_relocation, mojave:        "f680ca7c613325854b5d93185ec4db42a94341d8c4556b9e76adefe90d63eaf9"
    sha256 cellar: :any_skip_relocation, high_sierra:   "83a6bf89d47c2347c30872201ea5a77c8af18ada90b1992b28838d10882c0c6b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1774ec8df95702f05c1271446283ed6c1d802a48078b12d0679ca62c73e50fe9" # linuxbrew-core
  end

  depends_on "cmake" => :build

  def install
    system "cmake", "-DMAN_OUTPUT_PATH=#{man1}", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    system "#{bin}/catimg", test_fixtures("test.png")
  end
end
