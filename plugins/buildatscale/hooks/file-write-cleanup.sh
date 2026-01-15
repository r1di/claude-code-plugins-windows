#!/bin/bash
# File Write Cleanup Hook - Windows Compatible Wrapper
# Calls Node.js version for cross-platform compatibility

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
node "$SCRIPT_DIR/file-write-cleanup.js"
