#!/bin/bash
# Block Force Git Hook - Windows Compatible Wrapper
# Calls Node.js version for cross-platform compatibility

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
node "$SCRIPT_DIR/block-force-git.js"
