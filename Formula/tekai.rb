class Tekai < Formula
  desc "Self-contained, fidelity-preserving LaTeX engine and build system"
  homepage "https://github.com/NicoNekoru/tekai"
  url "https://github.com/NicoNekoru/tekai/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "1fb557a6b14f501b41dcc4337ae1dfcb46091d0dd5f6be0c514e3ffeb64d6989"
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
