class Ccal < Formula
  desc "Create Chinese calendars for print or browsing"
  # no https urls
  homepage "http://ccal.chinesebay.com/ccal/ccal.htm"
  url "http://ccal.chinesebay.com/ccal/ccal-2.5.3.tar.gz"
  sha256 "3d4cbdc9f905ce02ab484041fbbf7f0b7a319ae6a350c6c16d636e1a5a50df96"
  license "GPL-2.0"

  livecheck do
    url :homepage
    regex(/href=.*?ccal[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "e9555bba354683597a63cf86554624a01afbf7cc897c0e292b10edc3657f4572"
    sha256 cellar: :any_skip_relocation, big_sur:       "82e5a0c59583063fdfa23e254f77ac5d7972a8fb5a3e36138233c7a47245abdf"
    sha256 cellar: :any_skip_relocation, catalina:      "ea42afd04ed210cf6e0bedac3ab4ce6b3e37421ba8d79478769d2e117c38a41f"
    sha256 cellar: :any_skip_relocation, mojave:        "c3a4bead8506e0234e878727e6d7827925e600bcee3857859fd575d4bbb185cc"
    sha256 cellar: :any_skip_relocation, high_sierra:   "cd9bd38878cee9658e312142edfca7cf35e5223ef30b3a3effc9e4108ccf3d51"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "846faa1d98b5d0ba354ce7c770786c306f7e14460e16e8cf5edfa425e0997478" # linuxbrew-core
  end

  def install
    system "make", "-e", "BINDIR=#{bin}", "install"
    system "make", "-e", "MANDIR=#{man}", "install-man"
  end

  test do
    assert_match "Year JiaWu, Month 1X", shell_output("#{bin}/ccal 2 2014")
  end
end
