# BuildAtScale Claude Code Plugins - Windows Fork 🪟

> **Windows-compatible fork** of [buildatscale-tv/claude-code-plugins](https://github.com/buildatscale-tv/claude-code-plugins)

This fork resolves the Windows compatibility issue where bash hooks fail with:
```
Error: Could not fork child process: There are no available terminals (-1).
```

## What's Different?

| Feature | Original | This Fork |
|---------|----------|-----------|
| **Hooks** | Bash scripts with `python3`/`jq` | Node.js scripts (cross-platform) |
| **Dependencies** | `python3`, `jq`, `sed` | Only Node.js (already required by Claude Code) |
| **Windows Support** | ❌ Broken | ✅ Works |
| **macOS/Linux** | ✅ Works | ✅ Works |

## Quick Start

### Add the Marketplace

```bash
/plugin marketplace add https://github.com/r1di/claude-code-plugins-windows
```

### Install Plugins

**Core features (slash commands and hooks):**
```bash
/plugin install buildatscale@buildatscale-claude-code-windows
```

**Image generation skill:**
```bash
/plugin install nano-banana-pro@buildatscale-claude-code-windows
```

## Prerequisites

### For Hooks (buildatscale plugin)
- **Node.js** - Already installed if you're using Claude Code ✅

### For Image Generation (nano-banana-pro plugin)

1. **Install [uv](https://docs.astral.sh/uv/)** - Python package manager:

   **PowerShell (as Administrator):**
   ```powershell
   irm https://astral.sh/uv/install.ps1 | iex
   ```

   **Or with pip:**
   ```bash
   pip install uv
   ```

2. **Set `GEMINI_API_KEY` environment variable:**

   **PowerShell (temporary - current session only):**
   ```powershell
   $env:GEMINI_API_KEY = "your-api-key-here"
   ```

   **PowerShell (permanent - persists after restart):**
   ```powershell
   [Environment]::SetEnvironmentVariable("GEMINI_API_KEY", "your-api-key-here", "User")
   ```

   **Or via Windows GUI:**
   1. Press `Win + S`, search "Environment Variables"
   2. Click "Edit environment variables for your account"
   3. Click "New" under User variables
   4. Variable name: `GEMINI_API_KEY`
   5. Variable value: Your Google AI API key
   6. Click OK and restart Claude Code

   **Get your API key:** [Google AI Studio](https://aistudio.google.com/apikey)

## Available Plugins

### buildatscale (Core Tools)

**Slash Commands:**
- `/buildatscale:commit` - Create commit message(s) for staged/unstaged changes
- `/buildatscale:pr` - Create pull request with GitHub CLI
- `/buildatscale:ceo` - Create executive summary of recent work

**Hooks (Windows-compatible):**
- `block-force-git` - Prevents dangerous git force operations
- `file-write-cleanup` - Cleans up trailing whitespace after file edits

### nano-banana-pro (Skill)

Generate images using Google's Gemini models.

**Available Models:**
| Model | Best For | Max Resolution |
|-------|----------|----------------|
| **Flash** (default) | Speed, high-volume | 1024px |
| **Pro** | Professional quality | Up to 4K |

**Usage:**
```bash
uv run "${SKILL_DIR}/scripts/image.py" \
  --prompt "Your image description" \
  --output "C:\path\to\output.png"
```

## Troubleshooting

### Hooks still showing terminal errors?

If you previously installed the original buildatscale plugin:

1. Close Claude Code completely
2. Delete the plugin cache:
   ```powershell
   Remove-Item -Recurse -Force "$env:USERPROFILE\.claude\plugins\cache\buildatscale-claude-code"
   ```
3. Restart Claude Code
4. Install this Windows fork instead

### GEMINI_API_KEY not found?

Make sure you:
1. Set the environment variable with the **permanent** method (not temporary)
2. **Restarted Claude Code** after setting the variable
3. The key has no extra spaces or quotes

### uv command not found?

Restart your terminal/PowerShell after installing uv, or add it to PATH manually:
```powershell
$env:PATH += ";$env:USERPROFILE\.local\bin"
```

## Repository Structure

```
.
├── .claude-plugin/
│   └── marketplace.json        # Plugin registry (Windows fork metadata)
├── plugins/
│   ├── buildatscale/
│   │   ├── commands/
│   │   │   ├── ceo.md
│   │   │   ├── commit.md
│   │   │   └── pr.md
│   │   └── hooks/
│   │       ├── block-force-git.sh    # Bash wrapper
│   │       ├── block-force-git.js    # Node.js implementation
│   │       ├── block-force-git.ps1   # PowerShell alternative
│   │       ├── file-write-cleanup.sh
│   │       ├── file-write-cleanup.js
│   │       └── file-write-cleanup.ps1
│   └── nano-banana-pro/
│       └── skills/
│           └── generate/
│               ├── SKILL.md
│               └── scripts/
│                   └── image.py
└── README.md
```

## Credits

- **Original Plugin:** [BuildAtScale](https://github.com/buildatscale-tv/claude-code-plugins)
- **Windows Fork:** [r1di](https://github.com/r1di)

## License

MIT (same as original)
