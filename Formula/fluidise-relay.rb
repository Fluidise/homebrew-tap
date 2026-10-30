require "json"

class FluidiseRelay < Formula
  desc "Agent-first Git hook manager with explicit plans and safe orchestration"
  homepage "https://github.com/Fluidise/relay"
  version "0.1.0"
  license "MIT"
  depends_on :macos
  depends_on "git"

  on_macos do
    on_arm do
      url "https://github.com/Fluidise/relay/releases/download/v0.1.0/fluidise-relay-0.1.0-aarch64-apple-darwin-0e25840e142e.tar.gz"
      sha256 "2ac1358ed83257ed5175801cb15dae4365174e1fca10d499691718817a33c11a"
    end
    on_intel do
      url "https://github.com/Fluidise/relay/releases/download/v0.1.0/fluidise-relay-0.1.0-x86_64-apple-darwin-0e25840e142e.tar.gz"
      sha256 "295117771d2b1faf35b8b540ea05e40205ac3236d21936c118b2883b34a866f3"
    end
  end

  def install
    bin.install "fluidise-relay"
    pkgshare.install "LICENSE", "USAGE.md", "THIRD-PARTY", "THIRD-PARTY-NOTICES.md"
  end

  test do
    assert_match "fluidise-relay #{version}", shell_output("#{bin}/fluidise-relay --version")
    ENV["GIT_CONFIG_GLOBAL"] = "/dev/null"
    ENV["GIT_CONFIG_SYSTEM"] = "/dev/null"
    system "git", "init", "--quiet", "--template="
    (testpath/"fluidise.toml").write <<~TOML
      [hooks]
      version = 1
      [[hooks.commit-msg]]
      id = "policy"
      program = "git"
      args = ["rev-parse", "--is-inside-work-tree"]
      modifies-message = false
    TOML
    (testpath/"message.txt").write "feat: package test\n"
    %w[prepare install].each do |operation|
      extra = operation == "install" ? " --binary #{bin}/fluidise-relay" : ""
      plan = JSON.parse(shell_output("#{bin}/fluidise-relay inspect --operation #{operation}#{extra}"))
      system bin/"fluidise-relay", operation, "--plan", plan.fetch("plan").fetch("id"),
             * (operation == "install" ? ["--binary", (bin/"fluidise-relay").to_s] : [])
    end
    result = JSON.parse(shell_output("#{bin}/fluidise-relay run --file message.txt"))
    assert_equal "success", result.fetch("status")
    assert_equal "feat: package test\n", (testpath/"message.txt").read
  end
end
