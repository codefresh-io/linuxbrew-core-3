class Rebar3 < Formula
  desc "Erlang build tool"
  homepage "https://github.com/erlang/rebar3"
  url "https://github.com/erlang/rebar3/archive/3.17.0.tar.gz"
  sha256 "4c7f33a342bcab498f9bf53cc0ee5b698d9598b8fa9ef6a14bcdf44d21945c27"
  license "Apache-2.0"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "0501fc018a924c76dcd7248f12f7002296241874162db6ecf3cda0d6516e3ac3"
    sha256 cellar: :any_skip_relocation, big_sur:       "8b2581dc2365f4dff9d2533e1d8e18fdeab6282740caf47fc37d3c97365f90c9"
    sha256 cellar: :any_skip_relocation, catalina:      "7ee16a66ce6d611df47abd8118ed08651a237b15f687824ca5711cb2bb734684"
    sha256 cellar: :any_skip_relocation, mojave:        "311c51419024d8440c99de8c6711964ad329165d4c2bfea02a566549fcc39272"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "207e3705f6cf9aa43b9d372c41dd5b24ff42b27a1f47644dbf72286ab660f5f5" # linuxbrew-core
  end

  depends_on "erlang"

  def install
    system "./bootstrap"
    bin.install "rebar3"

    bash_completion.install "priv/shell-completion/bash/rebar3"
    zsh_completion.install "priv/shell-completion/zsh/_rebar3"
    fish_completion.install "priv/shell-completion/fish/rebar3.fish"
  end

  test do
    system bin/"rebar3", "--version"
  end
end
