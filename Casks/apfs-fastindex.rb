# Reference cask file for the apfs-fastindex tap.
#
# The canonical copy lives in the NicoNekoru/homebrew-apfs-fastindex
# repo at `Casks/apfs-fastindex.rb` — that's the path Homebrew's
# tap-resolution machinery looks for. This file in the main
# `apfs-fastindex` repo is the **template** the release flow
# regenerates on every `--publish`, alongside the .dmg.
#
# When you cut a release:
#
#   1. `./make-release.sh --publish --tag vX.Y.Z` here.
#   2. Script writes the `.dmg`, computes its SHA-256, and
#      overwrites this file with the right version + sha256.
#   3. Copy the resulting `homebrew/Casks/apfs-fastindex.rb`
#      into the `homebrew-apfs-fastindex` tap repo, commit,
#      push. Users see the update on their next
#      `brew update && brew upgrade --cask apfs-fastindex`.
#
# Users install via:
#
#   brew tap NicoNekoru/apfs-fastindex
#   brew install --cask apfs-fastindex
#
# Homebrew Cask strips the `com.apple.quarantine` xattr from
# downloaded `.app`s automatically, so users skip the
# right-click-→-Open Gatekeeper friction that ad-hoc-signed
# direct downloads otherwise produce.

cask "apfs-fastindex" do
  version "0.2.4"
  sha256 "7ef50af078df123be9268686db726afef42da05e0c47c5a6925f25b1f8aa5d88"

  url "https://github.com/NicoNekoru/apfs-fastindex/releases/download/v#{version}/ApfsFastindex-v#{version}-macos-arm64.dmg"
  name "apfs-fastindex"
  desc "Fast disk-usage visualizer for macOS / APFS"
  homepage "https://github.com/NicoNekoru/apfs-fastindex"

  # apfs-fastindex is built arm64-only today (the
  # `make-release.sh` flow targets the build host's arch). If
  # an Intel build is added later, remove this line and add an
  # `arch intel: "...", arm: "..."` block at the top.
  depends_on arch: "arm64"

  # macOS 13+ matches CFBundleSupportedPlatforms in the
  # Info.plist; brew rejects the install with a clear message
  # rather than letting the app launch and crash on older
  # systems.
  depends_on macos: ">= :ventura"

  app "ApfsFastindex.app"

  # `zap` removes user-level state on `brew uninstall --zap`.
  # Conservative list — only the prefs file we know we write.
  # Sparkle's own state lives in the same prefs file.
  zap trash: [
    "~/Library/Preferences/com.apfsfastindex.app.plist",
  ]
end
