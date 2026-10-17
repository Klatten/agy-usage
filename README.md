# agy-usage

A lightweight command-line tool that formats and enhances the output of `agy -p /usage` from Google's Antigravity CLI.

It provides two display modes:
1. **Interactive TUI Style (Default)**: Recreates the exact multi-group visual modal rendered by `/usage` in the interactive Antigravity CLI (headers, progress bars, group descriptions, dynamic countdown timers, and footer shortcuts).
2. **Compact Table Mode (`-c` / `--compact`)**: A clean, single-line-per-model table with a 25-character progress bar, column headers, simplified limit names, integer percentages, and local refresh timestamps.

---

## Features

- **Exact Interactive TUI**: Faithfully renders the Antigravity CLI's native `/usage` modal layout and color grading.
- **Compact One-Line View**: Summarizes model limits in an aligned, scannable terminal table (`Model`, `Limit`, `Remaining`, `Refresh`).
- **Visual Row Separators**: Uses lower-block elements (`▇`) by default to introduce a subtle top pixel gap between stacked progress bars.
- **Integer Percentages**: Clean, rounded integer percentages (`80%`, `100%`) aligned without cluttering decimals.
- **Local Timezone Conversion**: Automatically converts ISO-8601 UTC reset timestamps to your local system time and timezone (`YYYY-MM-DD HH:MM ZZZ`).
- **Flexible Invocation**: Works seamlessly when piped from `agy -p /usage`, given a file, or executed directly on its own.
- **Dynamic Account Detection**: Discovers the active session account email without any hardcoded credentials.

---

## Installation

### Quick Install (via curl)

```bash
curl -fsSL https://raw.githubusercontent.com/Klatten/agy-usage/main/install.sh | bash
```

The installer automatically installs `agy-usage` into `/usr/local/bin` (or `~/.local/bin` if running without root privileges).

### Manual Installation

Clone the repository and run the installer:

```bash
git clone https://github.com/Klatten/agy-usage.git
cd agy-usage
./install.sh
```

Or copy the script directly into your `$PATH`:

```bash
sudo cp agy-usage /usr/local/bin/
sudo chmod +x /usr/local/bin/agy-usage
```

---

## Usage

### 1. Compact Table View (`-c` / `--compact`)

```bash
agy-usage -c
```
*(Or pipe directly from Antigravity CLI)*
```bash
agy -p /usage | agy-usage -c
```

**Output:**
```text
Model                  Limit   Remaining                         Refresh
Gemini Models          Weekly  [▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇░░░░░]  80%  2026-10-24 16:11 CEST
Gemini Models          5 Hour  [▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇░░░░░░░░]  68%  2026-10-18 02:11 CEST
Claude and GPT models  Weekly  [▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇] 100%  2026-10-24 23:10 CEST
Claude and GPT models  5 Hour  [▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇] 100%  2026-10-18 04:10 CEST
Gemini 4 Argon         Weekly  [▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇] 100%  2026-10-24 23:10 CEST
```

### 2. Full Interactive Modal View (Default)

```bash
agy-usage
```

**Output:**
```text
└ Models & Quota

  Account: user@example.com

GEMINI MODELS
  Models within this group: Gemini Flash, Gemini Pro

  Weekly Limit Remaining
    [▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇░░░░░░░░░░] 80%
    Refreshes in 161h 5m

  Five Hour Limit Remaining
    [▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇░░░░░░░░░░░░░░░] 68%
    Refreshes in 3h 5m

CLAUDE AND GPT MODELS
  Models within this group: Claude Opus, Claude Sonnet, GPT-OSS

  Weekly Limit Remaining
    [▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇] 100%
    Quota available

  Five Hour Limit Remaining
    [▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇] 100%
    Quota available

GEMINI 4 ARGON
  For paid Pro plans, Argon quota is separate. Higher Argon quota (included as part of the larger Gemini quota bucket) is available on Ultra plans.

  Gemini 4 Argon Weekly Limit
    [▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇] 100%
    Quota available

  │Within each group, models share a weekly limit and a 5-hour limit. Quota is
  │consumed proportionally to the cost of the tokens. Thus, limits will last
  │longer with shorter tasks or using more cost-effective models. The 5-hour
  │limit smooths out aggregate demand to fairly distribute global capacity
  │across all users, while your weekly limit is tied directly to your individual
  │tier.

  ↑/↓ Scroll · pgup/pgdown Page · ctrl+end Bottom · ctrl+home Top · esc Close
```

---

## Options & Arguments

| Flag | Description |
| :--- | :--- |
| `-c`, `--compact`, `--one-line` | Display in compact table format with 25-character bar |
| `--no-gap`, `--nogap` | Use solid block (`█`) instead of gapped block (`▇`) |
| `--bar-char <CHAR>` | Use a custom character for the filled portion of the bar |
| `--no-color` | Strip ANSI escape sequences for plain-text output |
| `--account <EMAIL>` | Manually specify or override the displayed account email |
| `--no-shortcuts` | Omit the interactive keyboard shortcut footer line in full mode |
| `[file]` | Optional path to read saved `agy -p /usage` output from |
| `-h`, `--help` | Show command-line help and options |

---

## Requirements

- Python 3.8+
- Antigravity CLI (`agy`)

---

## License

[MIT](LICENSE) © Klatten
