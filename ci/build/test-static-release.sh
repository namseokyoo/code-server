#!/usr/bin/env bash
set -euo pipefail

# Makes sure the release works.
# This is to make sure we don't have Node version errors or any other
# compilation-related errors.
main() {
  cd "$(dirname "${0}")/../.."

  local EXTENSIONS_DIR
  EXTENSIONS_DIR="$(mktemp -d)"

  echo "Testing static release"

  ./release-static/bin/code-server --extensions-dir "$EXTENSIONS_DIR" --install-extension ms-python.python
  local installed_extensions
  installed_extensions="$(./release-static/bin/code-server --extensions-dir "$EXTENSIONS_DIR" --list-extensions 2>&1)"
  if [[ $installed_extensions != "ms-python.python" ]]; then
    echo "Unexpected output from listing extensions:"
    echo "$installed_extensions"
    exit 1
  fi

  echo "Static release works correctly"
}

main "$@"
