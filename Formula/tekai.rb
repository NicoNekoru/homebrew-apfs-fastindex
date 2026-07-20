class Tekai < Formula
  desc "Self-contained, fidelity-preserving LaTeX engine and build system"
  homepage "https://github.com/NicoNekoru/tekai"
  url "https://github.com/NicoNekoru/tekai/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "e018ddd98dd39538f6a48a27bccf88ecd42f7d9cd35545392818968b1250ddcc"
  license "MIT"
  head "https://github.com/NicoNekoru/tekai.git", branch: "main"

  depends_on "rust" => :build
  depends_on :macos

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "tekai #{version}", shell_output("#{bin}/tekai --version")
    assert_match "self-contained engine", shell_output("#{bin}/tekai --help")
  end
end
