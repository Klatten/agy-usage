#!/usr/bin/env bash
set -euo pipefail

# Determine target directory
if [ -w "/usr/local/bin" ]; then
    INSTALL_DIR="/usr/local/bin"
elif [ "$(id -u)" -eq 0 ]; then
    INSTALL_DIR="/usr/local/bin"
else
    INSTALL_DIR="${HOME}/.local/bin"
    mkdir -p "${INSTALL_DIR}"
fi

TARGET="${INSTALL_DIR}/agy-usage"
SRC_URL="https://raw.githubusercontent.com/Klatten/agy-usage/main/agy-usage"

# Check if installing from local directory clone or from remote
SCRIPT_DIR=""
if [ -n "${BASH_SOURCE[0]:-}" ] && [ -f "${BASH_SOURCE[0]}" ]; then
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
fi

echo "==> Installing agy-usage to ${TARGET}..."

if [ -n "${SCRIPT_DIR}" ] && [ -f "${SCRIPT_DIR}/agy-usage" ] && [ "${SCRIPT_DIR}/agy-usage" != "${TARGET}" ]; then
    cp "${SCRIPT_DIR}/agy-usage" "${TARGET}"
elif command -v curl >/dev/null 2>&1; then
    curl -fsSL "${SRC_URL}" -o "${TARGET}"
elif command -v wget >/dev/null 2>&1; then
    wget -qO "${TARGET}" "${SRC_URL}"
else
    echo "Error: Neither curl nor wget found to download agy-usage." >&2
    exit 1
fi

chmod +x "${TARGET}"

# Verify Python 3 is available
if ! command -v python3 >/dev/null 2>&1; then
    echo "Warning: python3 was not found in PATH. agy-usage requires Python 3.8+." >&2
fi

echo "✓ agy-usage successfully installed to ${TARGET}"

# Check PATH
case ":${PATH}:" in
    *:"${INSTALL_DIR}":*) ;;
    *)
        echo ""
        echo "Notice: ${INSTALL_DIR} is not in your PATH."
        echo "Add it to your shell configuration (e.g. ~/.bashrc or ~/.zshrc):"
        echo "    export PATH=\"${INSTALL_DIR}:\$PATH\""
        ;;
esac
