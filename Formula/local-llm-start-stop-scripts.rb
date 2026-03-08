class LocalLlmStartStopScripts < Formula
  desc "Start/stop wrappers for Docker + Ollama + Open WebUI on macOS"
  homepage "https://github.com/example/local-llm-start-stop-scripts"
  head "https://github.com/example/local-llm-start-stop-scripts.git", branch: "main"
  license "MIT"

  depends_on "ollama"

  def install
    libexec.install "Start AI.command", "Stop AI.command", "Install Dependencies.command"
    bin.install "bin/local-llm-doctor"

    (bin/"local-llm-start").write <<~EOS
      #!/usr/bin/env bash
      exec /bin/bash "#{libexec}/Start AI.command" "$@"
    EOS

    (bin/"local-llm-stop").write <<~EOS
      #!/usr/bin/env bash
      exec /bin/bash "#{libexec}/Stop AI.command" "$@"
    EOS
  end

  def caveats
    <<~EOS
      Docker Desktop is also required.

      Install it with:
        brew install --cask docker

      Then open Docker Desktop once to complete first-run setup:
        open -a Docker

      Verify your environment:
        local-llm-doctor
    EOS
  end

  test do
    assert_match "Usage: local-llm-doctor", shell_output("#{bin}/local-llm-doctor --help")
  end
end
