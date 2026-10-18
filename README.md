# Fluidise Homebrew tap

This repository contains Homebrew installation recipes, not application sources.
The authoritative Git repository is hosted on Entire. GitHub is a one-way public
copy of the approved main branch, for standard Git HTTPS access by Homebrew.
Do not edit the GitHub copy directly.

## Publication status

The formula is prepared for fluidise-lint 0.1.0 on macOS Apple Silicon and Intel.
Both macOS archives and SHA256SUMS-macos are published under
https://packages.acrazie.dev/lint/0.1.0/ and their HTTPS downloads match the
reviewed hashes. A real Homebrew installation on macOS ARM64 now succeeds, including six
direct CLI checks and removal. The formula test also passes with `brew test` after repairing the local
Homebrew prism dependency using a compatible SDK. The public GitHub tap has not yet been populated or tested. This tap is not an operational public installation channel yet.
Do not advertise installation until the recipe is published and the GitHub
tap installation path has been verified. The formula downloads precompiled binaries;
consumers do not need Rust or Node.

## Ownership

Packaging recipes are maintained in the sibling distribution project. The formula
in this tap is a reviewed publication copy, not an independently maintained fork.
Update it from the packaging recipe and verify byte equality before publication.
Only approved formulae and this README belong in the publication branch. Never
publish agent session histories, keys, packaging fixtures or build artifacts.

Maintainer preparation and synchronization procedure:
`/Users/acrazie/Fluidise/distribution/docs/homebrew-sync.md` on the current
maintainer workspace. This local guide is not required by consumers.
