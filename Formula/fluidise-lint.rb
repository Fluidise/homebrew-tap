require "json"

class FluidiseLint < Formula
  desc "Agent-first standalone commit message linter"
  version "0.1.0"
  license "MIT"
  depends_on :macos

  on_macos do
    on_arm do
      url "https://packages.acrazie.dev/lint/0.1.0/fluidise-lint-0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "fe6d7067e0a5c0c13af6918b41e8a976a7866775bf941f812ab63910b8d77671"
    end
    on_intel do
      url "https://packages.acrazie.dev/lint/0.1.0/fluidise-lint-0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "59f504f88e0ccd228488c57771ed2d65008f3e8b5a4e3f775a0637947b9d0e09"
    end
  end

  def install
    bin.install "fluidise-lint"
    pkgshare.install "LICENSE", "USAGE.md", "THIRD-PARTY", "THIRD-PARTY-NOTICES.md"
  end

  test do
    valid = JSON.parse(pipe_output("#{bin}/fluidise-lint --stdin", "feat: package test\n", 0))
    assert_equal "valid", valid.fetch("status")
    invalid = JSON.parse(pipe_output("#{bin}/fluidise-lint --stdin", "wrong\n", 1))
    assert_equal "invalid", invalid.fetch("status")
  end
end
