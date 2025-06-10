class Mvnenv < Formula
  desc "Easily manage and switch between multiple Maven versions"
  homepage "https://github.com/felipearpa/mvnenv"
  url "https://github.com/felipearpa/mvnenv/archive/refs/tags/v0.0.3.tar.gz"
  sha256 "55df24b56171e71698ee8a8e5f179add435a409894a21a55c0359edc732a00e8"
  license "LGPL-3.0"
  head "https://github.com/felipearpa/mvnenv.git"

  def install
    libexec.install Dir["*", "!test", "!test/*"]
    bin.write_exec_script libexec/"bin/mvnenv"
    bin.write_exec_script libexec/"bin/mvn"
  end

  def caveats
    <<~EOS
      To enable mvnenv, add this to your shell profile:

        if command -v mvnenv >/dev/null; then
          eval "$(mvnenv init -)"
        fi

      To use Homebrew's installation rather than ~/.mvnenv, add:

        export MVNENV_ROOT=#{opt_prefix}
    EOS
  end

  test do
    (testpath/".maven-version").write "homebrew-test"
    output = shell_output("#{bin}/mvnenv version 2>&1", 1)
    assert_match "homebrew-test", output
  end
end
