class BrewGem < Formula
  desc "Install RubyGems as Homebrew formulae"
  homepage "https://github.com/sportngin/brew-gem"
  url "https://github.com/sportngin/brew-gem/archive/v1.1.1.tar.gz"
  sha256 "affa68105dcabc5c8b4832cf70ee2b35c1fbf19496173753645bda496d9b0a34"
  license "MIT"
  head "https://github.com/sportngin/brew-gem.git"

  # Until versions exceed 2.2, the leading `v` in this regex isn't optional, as
  # we need to avoid an older `2.2` tag (a typo) while continuing to match
  # newer tags like `v1.1.1` and allowing for a future `v2.2.0` version.
  livecheck do
    url :stable
    regex(/^v(\d+(?:\.\d+)+)$/i)
  end

  def install
    inreplace "lib/brew/gem/formula.rb.erb", "/usr/local", HOMEBREW_PREFIX

    lib.install Dir["lib/*"]
    bin.install "bin/brew-gem"
  end

  test do
    system "#{bin}/brew-gem", "help"
  end
end
