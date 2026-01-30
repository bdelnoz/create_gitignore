# CHANGELOG - create_gitignore.sh

**Author:** Bruno DELNOZ
**Email:** bruno.delnoz@protonmail.com

---

## Version v2.0 - 2026-01-30 22:00:00

### 🔴 Major Changes
- **CRITICAL:** Added mandatory `--exec` argument for script execution (compliance with rule 59.2)
- Added automatic .gitignore management for script directory (rule 75.x)
- Added automatic .md documentation files generation (rule 76.x)

### ✅ New Features
- Added `--prerequis` argument to check prerequisites (rule 59.3)
- Added `--install` argument to install missing prerequisites (rule 59.4)
- Added `--changelog` argument to display full changelog (rule 59.6)
- Added post-execution numbered action list (rule 62.1)
- Added complete help with all available templates listed (rule 57.3)

### 📝 Improvements
- Enhanced internal comments for all logic blocks (rule 51.1)
- Improved logging with detailed action tracking
- Better error handling and user feedback
- Structured code with clear function separation

### 🐛 Fixes
- Fixed compliance with scripting rules V110
- Fixed help display to show all available templates
- Fixed default behavior: now shows help when no arguments provided (rule 57.2)

---

## Version v1.0 - 2025-10-25

### Initial Release
- Basic template management functionality
- Support for `--list`, `--simulate`, `--no-log`, `--auto-append` arguments
- Log file creation
- Template checking and validation
- Interactive and auto-append modes

---

**Complete version history maintained according to rule 71.10**
