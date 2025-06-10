class Mvnenv < Formula
  desc "Easily manage and switch between multiple Maven versions"
  homepage "https://github.com/felipearpa/mvnenv"
  url "https://github.com/felipearpa/mvnenv/archive/refs/tags/v0.0.4.tar.gz"
  sha256 "4864f6005bacb29805c2bf6a61acd117577b37af1f80f24f8bcdd15eedb59755"
  license "LGPL-3.0"
  head "https://github.com/felipearpa/mvnenv.git"

  def install
    libexec.install Dir["*"].reject { |f| f == "test" }
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
