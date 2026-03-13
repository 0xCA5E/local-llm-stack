cask "local-llm-stack" do
  version :latest
  sha256 :no_check

  url "https://github.com/0xCA5E/local-llm-stack/archive/refs/heads/main.tar.gz",
      verified: "github.com/0xCA5E/local-llm-stack/"
  name "local-llm-stack"
  desc "Run a local LLM stack with one command"
  homepage "https://github.com/0xCA5E/local-llm-stack"

  depends_on cask: "docker"
  depends_on formula: "ollama"

  binary "local-llm-stack-main/bin/local-llm-start"
  binary "local-llm-stack-main/bin/local-llm-stop"
  binary "local-llm-stack-main/bin/local-llm-doctor"

  uninstall script: {
    executable:   "#{staged_path}/support/local-llm-uninstall-helper",
    sudo:         false,
    sudo_as_root: false,
  }

  zap trash: [
    "~/.local/state/local-llm",
    "/tmp/local_llm_terminal_window_ids.tmp",
    "/tmp/terminal_window_ids.tmp",
  ]
end
