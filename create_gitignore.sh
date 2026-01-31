#!/bin/bash
################################################################################
# Author: Bruno DELNOZ
# Email: bruno.delnoz@protonmail.com
# Script name: create_gitignore.sh
# Full path: ~/Security/scripts/divers/utility_tools/create_gitignore.sh
# Target usage: Creation and management of .gitignore files from templates
# Version: v2.0 - Date: 2026-01-30
#
# CHANGELOG:
# v2.0 - 2026-01-30
#   - MAJOR: Added mandatory --exec argument for script execution
#   - Added --prerequis argument to check prerequisites
#   - Added --install argument to install missing prerequisites
#   - Added --changelog argument to display full changelog
#   - Added automatic .gitignore management for script directory
#   - Added automatic .md documentation files generation
#   - Added post-execution numbered action list
#   - Added complete help with all available templates listed
#   - Added detailed internal comments for all logic blocks
#   - Fixed compliance with scripting rules V110
#
# v1.0 - 2025-10-25
#   - Initial version
#   - Basic template management
#   - Support for --list, --simulate, --no-log, --auto-append
#   - Log file creation
################################################################################

################################################################################
# GLOBAL VARIABLES
################################################################################
# Version and script information
SCRIPT_VERSION="v2.0"
SCRIPT_DATE="2026-01-30"
SCRIPT_NAME="create_gitignore.sh"
SCRIPT_AUTHOR="Bruno DELNOZ"
SCRIPT_EMAIL="bruno.delnoz@protonmail.com"

# Directories and files paths
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_DIR="${SCRIPT_DIR}/logs"
LOG_FILE="${LOG_DIR}/log.${SCRIPT_NAME}.${SCRIPT_VERSION}.log"
RESULTS_DIR="${SCRIPT_DIR}/results"
TEMPLATES_DIR="${SCRIPT_DIR}/gitignore_templates"
BACKUP_DIR="${SCRIPT_DIR}/backup"

# Documentation files
README_FILE="${SCRIPT_DIR}/README.${SCRIPT_NAME}.md"
CHANGELOG_FILE="${SCRIPT_DIR}/CHANGELOG.${SCRIPT_NAME}.md"
USAGE_FILE="${SCRIPT_DIR}/USAGE.${SCRIPT_NAME}.md"

# Execution flags
DRY_RUN=false
NO_LOG=false
AUTO_APPEND=false
EXEC_MODE=false

# Action tracking for post-execution summary
declare -a ACTIONS_PERFORMED=()

################################################################################
# FUNCTION: log
# Description: Log messages to file and/or console
# Parameters: $1 = message to log
################################################################################
log() {
    local message="$1"
    local timestamp="$(date '+%Y-%m-%d %H:%M:%S')"

    if [ "$NO_LOG" = false ]; then
        echo "${timestamp} - ${message}" | tee -a "$LOG_FILE"
    else
        echo "${timestamp} - ${message}"
    fi
}

################################################################################
# FUNCTION: track_action
# Description: Track actions performed for post-execution summary
# Parameters: $1 = action description
################################################################################
track_action() {
    ACTIONS_PERFORMED+=("$1")
}

################################################################################
# FUNCTION: ensure_directories
# Description: Ensure all required directories exist
################################################################################

ensure_directories() {
    for dir in "$LOG_DIR" "$RESULTS_DIR" "$BACKUP_DIR"; do
        if [ ! -d "$dir" ]; then
            mkdir -p "$dir"
            track_action "Created directory: $dir"
        fi
    done
}



################################################################################
# FUNCTION: manage_script_gitignore
# Description: Manage .gitignore file in script directory
# Ensures /logs, /outputs, /results, /resume are excluded
################################################################################
manage_script_gitignore() {
    local gitignore_path="${SCRIPT_DIR}/.gitignore"
    local entries_to_add=("/logs" "/outputs" "/results" "/resume" "/backup")
    local added_count=0
    local already_present=0

    log "════════════════════════════════════════════════════════════════════════════"
    log "[GitIgnore Management] Checking script directory .gitignore"
    log "════════════════════════════════════════════════════════════════════════════"

    # Create .gitignore if not exists
    if [ ! -f "$gitignore_path" ]; then
        touch "$gitignore_path"
        log "✓ Created .gitignore file in script directory"
        track_action "Created .gitignore in script directory"
    fi

    # Check and add each entry
    for entry in "${entries_to_add[@]}"; do
        if grep -qxF "$entry" "$gitignore_path" 2>/dev/null; then
            log "  ✓ Entry already present: $entry"
            ((already_present++))
        else
            if [ "$DRY_RUN" = false ]; then
                # Add with identification comment
                echo "" >> "$gitignore_path"
                echo "# Section added automatically by ${SCRIPT_NAME}" >> "$gitignore_path"
                echo "$entry" >> "$gitignore_path"
                log "  ✓ Added entry: $entry"
                track_action "Added '$entry' to script .gitignore"
                ((added_count++))
            else
                log "  [DRY-RUN] Would add entry: $entry"
            fi
        fi
    done

    # Summary
    if [ $added_count -eq 0 ] && [ $already_present -gt 0 ]; then
        log "✓ No modifications needed. All required entries already present in .gitignore"
    elif [ $added_count -gt 0 ]; then
        log "✓ Added $added_count new entries to .gitignore"
    fi

    log ""
}

################################################################################
# FUNCTION: generate_readme
# Description: Generate or update README.md file
################################################################################
generate_readme() {
    if [ "$DRY_RUN" = false ]; then
        cat > "$README_FILE" << 'EOFREADME'
# create_gitignore.sh - Documentation

**Author:** Bruno DELNOZ
**Email:** bruno.delnoz@protonmail.com
**Version:** v2.0
**Last Updated:** 2026-01-30 22:00:00

## Description

`create_gitignore.sh` is a comprehensive tool for creating and managing `.gitignore` files from predefined templates. It supports multiple programming languages, operating systems, IDEs, and development tools.

## Features

- ✅ 25+ predefined templates for various technologies
- ✅ Support for multiple templates combination
- ✅ Automatic backup of existing .gitignore files
- ✅ Simulation mode (dry-run)
- ✅ Comprehensive logging
- ✅ Auto-append mode for non-interactive usage
- ✅ Prerequisites checking
- ✅ Automatic installation of missing dependencies

## Available Templates

### Programming Languages
- python, web, node, java, cpp, rust, go, ruby, php, dotnet, swift, android

### Operating Systems
- macos, linux, windows

### IDEs
- vscode, jetbrains, vim, sublime

### Frameworks & Tools
- django, laravel, rails, unity, docker, terraform

## Usage

### Basic Usage
```bash
# List available templates
./create_gitignore.sh --list

# Create .gitignore with Python template
./create_gitignore.sh --exec python

# Combine multiple templates
./create_gitignore.sh --exec python vscode macos

# Simulation mode
./create_gitignore.sh --exec --simulate python vscode
```

### Advanced Options
```bash
# Check prerequisites
./create_gitignore.sh --prerequis

# Install missing prerequisites
./create_gitignore.sh --install

# Display changelog
./create_gitignore.sh --changelog

# Auto-append without confirmation
./create_gitignore.sh --exec --auto-append python

# Disable logging
./create_gitignore.sh --exec --no-log python
```

## Prerequisites

- Bash 4.0+
- Read/write permissions in current directory
- Templates directory: `gitignore_templates/`

## Installation

1. Clone or download the script
2. Ensure templates directory exists with template files
3. Make script executable: `chmod +x create_gitignore.sh`
4. Run: `./create_gitignore.sh --help`

## Documentation Files

- `README.create_gitignore.sh.md` - This file
- `CHANGELOG.create_gitignore.sh.md` - Complete version history
- `USAGE.create_gitignore.sh.md` - Detailed usage examples

## Support

For issues, questions, or contributions:
- Email: bruno.delnoz@protonmail.com
- Check documentation files for detailed information

## License

Maintained by Bruno DELNOZ - 2026
EOFREADME
        log "[DocSync] File 'README.${SCRIPT_NAME}.md' updated automatically"
        track_action "Generated README.md documentation"
    else
        log "[DRY-RUN] Would generate README.md"
    fi
}

################################################################################
# FUNCTION: generate_changelog
# Description: Generate or update CHANGELOG.md file
################################################################################
generate_changelog() {
    if [ "$DRY_RUN" = false ]; then
        cat > "$CHANGELOG_FILE" << 'EOFCHANGELOG'
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
EOFCHANGELOG
        log "[DocSync] File 'CHANGELOG.${SCRIPT_NAME}.md' updated automatically"
        track_action "Generated CHANGELOG.md documentation"
    else
        log "[DRY-RUN] Would generate CHANGELOG.md"
    fi
}

################################################################################
# FUNCTION: generate_usage
# Description: Generate or update USAGE.md file
################################################################################
generate_usage() {
    if [ "$DRY_RUN" = false ]; then
        cat > "$USAGE_FILE" << 'EOFUSAGE'
# USAGE GUIDE - create_gitignore.sh

**Author:** Bruno DELNOZ
**Email:** bruno.delnoz@protonmail.com
**Version:** v2.0
**Last Updated:** 2026-01-30 22:00:00

---

## Quick Start

```bash
# Display help
./create_gitignore.sh --help

# List all available templates
./create_gitignore.sh --list

# Create .gitignore with single template
./create_gitignore.sh --exec python
```

---

## Command Reference

### Execution Commands

#### `--exec` (Required for execution)
Execute the script to create/modify .gitignore files.

```bash
./create_gitignore.sh --exec python
./create_gitignore.sh --exec python vscode macos
```

#### `--simulate` / `-s`
Perform a dry-run without making actual changes.

```bash
./create_gitignore.sh --exec --simulate python
./create_gitignore.sh --exec -s python vscode
```

### Information Commands

#### `--help` / `-h`
Display comprehensive help with examples.

```bash
./create_gitignore.sh --help
./create_gitignore.sh -h
```

#### `--list`
List all available templates organized by category.

```bash
./create_gitignore.sh --list
```

#### `--changelog` / `-ch`
Display complete version history.

```bash
./create_gitignore.sh --changelog
./create_gitignore.sh -ch
```

### System Commands

#### `--prerequis` / `-pr`
Check if all prerequisites are met.

```bash
./create_gitignore.sh --prerequis
./create_gitignore.sh -pr
```

#### `--install` / `-i`
Install missing prerequisites.

```bash
./create_gitignore.sh --install
./create_gitignore.sh -i
```

### Behavior Modifiers

#### `--auto-append`
Automatically append to existing .gitignore without prompting.

```bash
./create_gitignore.sh --exec --auto-append python
```

#### `--no-log`
Disable logging to file (only console output).

```bash
./create_gitignore.sh --exec --no-log python
```

---

## Usage Examples

### Example 1: Python Project
```bash
# Create .gitignore for Python project with VSCode
./create_gitignore.sh --exec python vscode
```

### Example 2: Web Development
```bash
# Create .gitignore for Node.js web project
./create_gitignore.sh --exec web node vscode macos
```

### Example 3: Java Enterprise
```bash
# Create .gitignore for Java project with IntelliJ
./create_gitignore.sh --exec java jetbrains linux
```

### Example 4: Mobile Development
```bash
# Android project
./create_gitignore.sh --exec android jetbrains macos

# iOS project
./create_gitignore.sh --exec swift vscode macos
```

### Example 5: DevOps
```bash
# Docker + Terraform project
./create_gitignore.sh --exec docker terraform vscode linux
```

### Example 6: Full Stack Web
```bash
# React + Node.js + Docker
./create_gitignore.sh --exec web node docker vscode macos
```

---

## Template Categories

### Programming Languages
- **python** - Python projects (pip, poetry, pipenv)
- **web** - Web/JavaScript/Node.js projects
- **node** - Node.js specific
- **java** - Java projects (Maven, Gradle)
- **cpp** - C++ projects (CMake, Make)
- **rust** - Rust projects (Cargo)
- **go** - Go projects
- **ruby** - Ruby projects (Bundler, RSpec)
- **php** - PHP projects (Composer)
- **dotnet** - .NET/C# projects
- **swift** - Swift/iOS projects
- **android** - Android projects

### Frameworks
- **django** - Django Python framework
- **laravel** - Laravel PHP framework
- **rails** - Ruby on Rails framework
- **unity** - Unity 3D game engine

### Operating Systems
- **macos** - macOS system files
- **linux** - Linux system files
- **windows** - Windows system files

### IDEs
- **vscode** - Visual Studio Code
- **jetbrains** - IntelliJ IDEA, PyCharm, WebStorm, etc.
- **vim** - Vim/NeoVim editor
- **sublime** - Sublime Text editor

### Tools
- **docker** - Docker and Docker Compose
- **terraform** - Terraform infrastructure

---

## Workflow Tips

### Starting New Project
```bash
# 1. Check prerequisites
./create_gitignore.sh --prerequis

# 2. Simulate first
./create_gitignore.sh --exec --simulate python vscode macos

# 3. Create if satisfied
./create_gitignore.sh --exec python vscode macos
```

### Modifying Existing Project
```bash
# Add new templates to existing .gitignore
./create_gitignore.sh --exec --auto-append docker terraform
```

### Automation
```bash
# Use in scripts with auto-append and no-log
./create_gitignore.sh --exec --auto-append --no-log python vscode
```

---

## Troubleshooting

### Template Not Found
```bash
# List available templates
./create_gitignore.sh --list

# Check spelling and try again
./create_gitignore.sh --exec python  # Correct
./create_gitignore.sh --exec phyton  # Error
```

### Prerequisites Missing
```bash
# Check what's missing
./create_gitignore.sh --prerequis

# Install automatically
./create_gitignore.sh --install
```

### Backup Existing .gitignore
The script automatically creates backups:
```
.gitignore.backup.20260130_220000
```

---

**For more information, see README.create_gitignore.sh.md**
EOFUSAGE
        log "[DocSync] File 'USAGE.${SCRIPT_NAME}.md' updated automatically"
        track_action "Generated USAGE.md documentation"
    else
        log "[DRY-RUN] Would generate USAGE.md"
    fi
}

################################################################################
# FUNCTION: check_prerequisites
# Description: Check if all prerequisites are met
# Returns: 0 if all OK, 1 if missing prerequisites
################################################################################
check_prerequisites() {
    local missing_count=0

    log "════════════════════════════════════════════════════════════════════════════"
    log "Checking prerequisites..."
    log "════════════════════════════════════════════════════════════════════════════"

    # Check Bash version
    if [ "${BASH_VERSINFO[0]}" -lt 4 ]; then
        log "✗ Bash version 4.0+ required (current: ${BASH_VERSION})"
        ((missing_count++))
    else
        log "✓ Bash version: ${BASH_VERSION}"
    fi

    # Check templates directory
    if [ ! -d "$TEMPLATES_DIR" ]; then
        log "✗ Templates directory not found: $TEMPLATES_DIR"
        ((missing_count++))
    else
        log "✓ Templates directory found: $TEMPLATES_DIR"

        # Count available templates
        local template_count=$(find "$TEMPLATES_DIR" -name "*.gitignore" -o -name "*.txt" 2>/dev/null | wc -l)
        log "  → $template_count template files available"
    fi

    # Check write permissions
    if [ ! -w "." ]; then
        log "✗ No write permission in current directory"
        ((missing_count++))
    else
        log "✓ Write permission in current directory"
    fi

    # Check read permissions on templates
    if [ -d "$TEMPLATES_DIR" ] && [ ! -r "$TEMPLATES_DIR" ]; then
        log "✗ No read permission on templates directory"
        ((missing_count++))
    elif [ -d "$TEMPLATES_DIR" ]; then
        log "✓ Read permission on templates directory"
    fi

    log ""

    # Summary
    if [ $missing_count -eq 0 ]; then
        log "✓ All prerequisites are met"
        return 0
    else
        log "✗ $missing_count prerequisite(s) missing"
        log "  Run with --install to attempt automatic installation"
        return 1
    fi
}

################################################################################
# FUNCTION: install_prerequisites
# Description: Install missing prerequisites
################################################################################
install_prerequisites() {
    log "════════════════════════════════════════════════════════════════════════════"
    log "Installing prerequisites..."
    log "════════════════════════════════════════════════════════════════════════════"

    # Create templates directory if missing
    if [ ! -d "$TEMPLATES_DIR" ]; then
        if [ "$DRY_RUN" = false ]; then
            mkdir -p "$TEMPLATES_DIR"
            log "✓ Created templates directory: $TEMPLATES_DIR"
            track_action "Created templates directory"
        else
            log "[DRY-RUN] Would create templates directory: $TEMPLATES_DIR"
        fi
    else
        log "✓ Templates directory already exists"
    fi

    # Check if templates need to be downloaded or created
    local template_count=$(find "$TEMPLATES_DIR" -name "*.gitignore" -o -name "*.txt" 2>/dev/null | wc -l)
    if [ $template_count -eq 0 ]; then
        log "⚠ No template files found in $TEMPLATES_DIR"
        log "  Please add template files manually to this directory"
        log "  Expected format: <template_name>.gitignore or <template_name>.txt"
    else
        log "✓ Found $template_count template files"
    fi

    log ""
    log "✓ Installation check complete"
    log "  Run --prerequis to verify all requirements"
}

################################################################################
# FUNCTION: print_changelog
# Description: Display the complete changelog
################################################################################
print_changelog() {
    cat << 'EOFCHANGELOG'
╔════════════════════════════════════════════════════════════════════════════╗
║                         COMPLETE CHANGELOG                                 ║
╚════════════════════════════════════════════════════════════════════════════╝

Version v2.0 - 2026-01-30 22:00:00
Author: Bruno DELNOZ (bruno.delnoz@protonmail.com)

MAJOR CHANGES:
  🔴 Added mandatory --exec argument for script execution (rule 59.2)
  🔴 Added automatic .gitignore management for script directory (rule 75.x)
  🔴 Added automatic .md documentation files generation (rule 76.x)

NEW FEATURES:
  ✅ Added --prerequis argument to check prerequisites (rule 59.3)
  ✅ Added --install argument to install missing prerequisites (rule 59.4)
  ✅ Added --changelog argument to display full changelog (rule 59.6)
  ✅ Added post-execution numbered action list (rule 62.1)
  ✅ Added complete help with all available templates listed (rule 57.3)

IMPROVEMENTS:
  📝 Enhanced internal comments for all logic blocks (rule 51.1)
  📝 Improved logging with detailed action tracking
  📝 Better error handling and user feedback
  📝 Structured code with clear function separation

FIXES:
  🐛 Fixed compliance with scripting rules V110
  🐛 Fixed help display to show all available templates
  🐛 Fixed default behavior: now shows help when no arguments provided

────────────────────────────────────────────────────────────────────────────

Version v1.0 - 2025-10-25
Author: Bruno DELNOZ (bruno.delnoz@protonmail.com)

INITIAL RELEASE:
  ✅ Basic template management functionality
  ✅ Support for --list, --simulate, --no-log, --auto-append arguments
  ✅ Log file creation
  ✅ Template checking and validation
  ✅ Interactive and auto-append modes

════════════════════════════════════════════════════════════════════════════
EOFCHANGELOG
    exit 0
}

################################################################################
# FUNCTION: print_help
# Description: Display comprehensive help information
################################################################################
print_help() {
    cat << 'EOFHELP'
╔════════════════════════════════════════════════════════════════════════════╗
║                  CREATE_GITIGNORE.SH v2.0 - HELP                           ║
╚════════════════════════════════════════════════════════════════════════════╝

DESCRIPTION:
  Create and manage .gitignore files from predefined templates.
  Supports multiple programming languages, frameworks, OS, and IDEs.

USAGE:
  ./create_gitignore.sh --exec <template> [template2] [template3] [OPTIONS]

REQUIRED ARGUMENTS:
  --exec, -exe          Execute the script (mandatory for creating .gitignore)

EXAMPLES:
  # List all available templates
  ./create_gitignore.sh --list

  # Create .gitignore with single template
  ./create_gitignore.sh --exec python

  # Combine multiple templates
  ./create_gitignore.sh --exec python vscode macos

  # Simulation mode (dry-run)
  ./create_gitignore.sh --exec --simulate python vscode

  # Auto-append without confirmation
  ./create_gitignore.sh --exec --auto-append docker terraform

  # Check prerequisites
  ./create_gitignore.sh --prerequis

  # Install missing prerequisites
  ./create_gitignore.sh --install

  # Display changelog
  ./create_gitignore.sh --changelog

OPTIONS:
  --list                List all available templates
  --simulate, -s        Simulation mode (dry-run, no actual changes)
  --no-log              Disable logging to file
  --auto-append         Add templates automatically without confirmation
  --prerequis, -pr      Check prerequisites before execution
  --install, -i         Install missing prerequisites
  --changelog, -ch      Display complete changelog
  --help, -h            Display this help message

TEMPLATES:
  Programming Languages:
    python, web, node, java, cpp, rust, go, ruby, php, dotnet, swift, android

  Frameworks & CMS:
    django, laravel, rails, unity

  Operating Systems:
    macos, linux, windows

  IDEs & Editors:
    vscode, jetbrains, vim, sublime

  DevOps & Tools:
    docker, terraform

BEHAVIOR:
  - If .gitignore exists: Prompts to append or replace (unless --auto-append)
  - Creates backup before replacing: .gitignore.backup.YYYYMMDD_HHMMSS
  - Logs all actions to: logs/log.create_gitignore.sh.v2.0.log
  - Generates documentation files: README, CHANGELOG, USAGE

PREREQUISITES:
  - Bash 4.0+
  - Read/write permissions in current directory
  - Templates directory: gitignore_templates/

FILES CREATED:
  - .gitignore (in current directory)
  - logs/log.create_gitignore.sh.v2.0.log
  - README.create_gitignore.sh.md
  - CHANGELOG.create_gitignore.sh.md
  - USAGE.create_gitignore.sh.md

AUTHOR:
  Bruno DELNOZ
  Email: bruno.delnoz@protonmail.com
  Version: v2.0 (2026-01-30)

MORE INFO:
  See README.create_gitignore.sh.md for complete documentation
  See USAGE.create_gitignore.sh.md for detailed usage examples
EOFHELP
    exit 0
}

################################################################################
# FUNCTION: list_templates
# Description: List all available templates organized by category
################################################################################
list_templates() {
    log "╔════════════════════════════════════════════════════════════════════════════╗"
    log "║                        AVAILABLE TEMPLATES                                 ║"
    log "╚════════════════════════════════════════════════════════════════════════════╝"
    log ""

    if [ ! -d "$TEMPLATES_DIR" ]; then
        log "✗ ERROR: Templates directory not found: $TEMPLATES_DIR"
        log "  Run --install to create the directory"
        exit 1
    fi

    # Define template categories
    local -a lang_templates=(python web node java cpp rust go ruby php dotnet swift android)
    local -a framework_templates=(django laravel rails unity)
    local -a os_templates=(macos linux windows)
    local -a ide_templates=(vscode jetbrains vim sublime)
    local -a tools_templates=(docker terraform)

    # Programming Languages
    log "PROGRAMMING LANGUAGES:"
    for template in "${lang_templates[@]}"; do
        if [ -f "$TEMPLATES_DIR/${template}.gitignore" ] || [ -f "$TEMPLATES_DIR/template_${template}.txt" ]; then
            log "  ✓ $template"
        fi
    done

    log ""

    # Frameworks
    log "FRAMEWORKS & CMS:"
    for template in "${framework_templates[@]}"; do
        if [ -f "$TEMPLATES_DIR/${template}.gitignore" ] || [ -f "$TEMPLATES_DIR/template_${template}.txt" ]; then
            log "  ✓ $template"
        fi
    done

    log ""

    # Operating Systems
    log "OPERATING SYSTEMS:"
    for template in "${os_templates[@]}"; do
        if [ -f "$TEMPLATES_DIR/${template}.gitignore" ] || [ -f "$TEMPLATES_DIR/template_${template}.txt" ]; then
            log "  ✓ $template"
        fi
    done

    log ""

    # IDEs
    log "IDEs & EDITORS:"
    for template in "${ide_templates[@]}"; do
        if [ -f "$TEMPLATES_DIR/${template}.gitignore" ] || [ -f "$TEMPLATES_DIR/template_${template}.txt" ]; then
            log "  ✓ $template"
        fi
    done

    log ""

    # Tools
    log "DEVOPS & TOOLS:"
    for template in "${tools_templates[@]}"; do
        if [ -f "$TEMPLATES_DIR/${template}.gitignore" ] || [ -f "$TEMPLATES_DIR/template_${template}.txt" ]; then
            log "  ✓ $template"
        fi
    done

    log ""
    log "Use --exec <template> to create .gitignore with selected template(s)"

    exit 0
}

################################################################################
# FUNCTION: check_template_exists
# Description: Verify if a template file exists
# Parameters: $1 = template name
# Returns: 0 if exists, 1 if not found
################################################################################
check_template_exists() {
    local template="$1"
    local template_file=""

    # Check for .gitignore extension first
    if [ -f "$TEMPLATES_DIR/${template}.gitignore" ]; then
        template_file="$TEMPLATES_DIR/${template}.gitignore"
        return 0
    fi

    # Check for template_*.txt format
    if [ -f "$TEMPLATES_DIR/template_${template}.txt" ]; then
        template_file="$TEMPLATES_DIR/template_${template}.txt"
        return 0
    fi

    # Template not found
    log "✗ ERROR: Template '$template' not found"
    log "  Expected locations:"
    log "    - $TEMPLATES_DIR/${template}.gitignore"
    log "    - $TEMPLATES_DIR/template_${template}.txt"
    log "  Use --list to see all available templates"
    return 1
}

################################################################################
# FUNCTION: get_template_file
# Description: Get the full path to a template file
# Parameters: $1 = template name
# Returns: Echo the template file path
################################################################################
get_template_file() {
    local template="$1"

    if [ -f "$TEMPLATES_DIR/${template}.gitignore" ]; then
        echo "$TEMPLATES_DIR/${template}.gitignore"
    elif [ -f "$TEMPLATES_DIR/template_${template}.txt" ]; then
        echo "$TEMPLATES_DIR/template_${template}.txt"
    fi
}

################################################################################
# FUNCTION: create_gitignore
# Description: Create or append .gitignore file with specified template
# Parameters: $1 = template name
# Returns: 0 on success, 1 on failure
################################################################################
create_gitignore() {
    local template="$1"
    local gitignore_path=".gitignore"
    local template_file=""

    log "════════════════════════════════════════════════════════════════════════════"
    log "Processing template: $template"
    log "════════════════════════════════════════════════════════════════════════════"

    # Verify template exists
    if ! check_template_exists "$template"; then
        return 1
    fi

    # Get template file path
    template_file=$(get_template_file "$template")

    # Handle existing .gitignore file
    if [ -f "$gitignore_path" ]; then
        log "⚠ .gitignore already exists"

        if [ "$AUTO_APPEND" = true ]; then
            log "→ Auto-append mode: adding to existing file"
            track_action "Auto-appended template '$template' to existing .gitignore"
        elif [ "$DRY_RUN" = false ]; then
            read -p "Action: [a]ppend or [r]eplace? (a/r): " choice
            case "$choice" in
                r|R)
            local backup_file="${BACKUP_DIR}/.gitignore.backup.$(date +%Y%m%d_%H%M%S)"

            if [ "$DRY_RUN" = false ]; then
                mv "$gitignore_path" "$backup_file"
                log "✓ Backup created: $backup_file"
                track_action "Backup stored in $backup_file"
            else
                log "[DRY-RUN] Would move $gitignore_path to $backup_file"
                fi



                    log "✓ Backup created: $backup"
                    track_action "Created backup: $backup"
                    track_action "Replaced .gitignore with template '$template'"
                    ;;
                a|A)
                    log "→ Appending to existing file"
                    track_action "Appended template '$template' to existing .gitignore"
                    ;;
                *)
                    log "✗ Invalid choice. Operation cancelled."
                    return 1
                    ;;
            esac
        else
            log "[DRY-RUN] Would prompt for append or replace"
        fi
    fi

    # Create or append content
    if [ "$DRY_RUN" = false ]; then
        if [ -f "$gitignore_path" ]; then
            # Append with separator
            echo "" >> "$gitignore_path"
            echo "# ========================================" >> "$gitignore_path"
            echo "# Template: $template" >> "$gitignore_path"
            echo "# Added: $(date '+%Y-%m-%d %H:%M:%S')" >> "$gitignore_path"
            echo "# ========================================" >> "$gitignore_path"

            # Extract content (skip metadata lines)
            grep -v "^# Template :" "$template_file" | \
            grep -v "^# Description :" | \
            grep -v "^# Maintainer :" | \
            grep -v "^# Last update :" | \
            grep -v "^# Compatible with :" >> "$gitignore_path"

            log "✓ Template '$template' added to existing .gitignore"
        else
            # Create new file
            cat "$template_file" > "$gitignore_path"
            log "✓ Created .gitignore with template '$template'"
            track_action "Created new .gitignore with template '$template'"
        fi
    else
        log "[DRY-RUN] Would create/append template '$template'"
    fi

    return 0
}

################################################################################
# FUNCTION: print_execution_summary
# Description: Display numbered list of all actions performed
################################################################################
print_execution_summary() {
    if [ ${#ACTIONS_PERFORMED[@]} -eq 0 ]; then
        return
    fi

    log ""
    log "════════════════════════════════════════════════════════════════════════════"
    log "EXECUTION SUMMARY - Actions Performed:"
    log "════════════════════════════════════════════════════════════════════════════"

    local counter=1
    for action in "${ACTIONS_PERFORMED[@]}"; do
        log "  ${counter}. ${action}"
        ((counter++))
    done

    log "════════════════════════════════════════════════════════════════════════════"
}

################################################################################
# MAIN EXECUTION BLOCK
################################################################################

# Display help if no arguments provided (rule 57.2)
if [ $# -eq 0 ]; then
    print_help
fi

# Ensure required directories exist
ensure_directories

# Initialize log file
if [ "$NO_LOG" = false ]; then
    echo "════════════════════════════════════════════════════════════════════════════" > "$LOG_FILE"
    echo "Script execution started: $(date '+%Y-%m-%d %H:%M:%S')" >> "$LOG_FILE"
    echo "Version: ${SCRIPT_VERSION}" >> "$LOG_FILE"
    echo "════════════════════════════════════════════════════════════════════════════" >> "$LOG_FILE"
fi

# Parse command line arguments
TEMPLATES=()

while [[ $# -gt 0 ]]; do
    case "$1" in
        --exec|-exe)
            EXEC_MODE=true
            shift
            ;;
        --list)
            list_templates
            ;;
        --simulate|-s)
            DRY_RUN=true
            log "⚠ SIMULATION MODE ENABLED"
            track_action "Executed in simulation mode"
            shift
            ;;
        --no-log)
            NO_LOG=true
            shift
            ;;
        --auto-append)
            AUTO_APPEND=true
            shift
            ;;
        --prerequis|-pr)
            check_prerequisites
            exit $?
            ;;
        --install|-i)
            install_prerequisites
            exit 0
            ;;
        --changelog|-ch)
            print_changelog
            ;;
        --help|-h)
            print_help
            ;;
        *)
            TEMPLATES+=("$1")
            shift
            ;;
    esac
done

# Manage script's own .gitignore
manage_script_gitignore

# Generate documentation files
generate_readme
generate_changelog
generate_usage

# Check if execution mode is enabled
if [ "$EXEC_MODE" = false ]; then
    if [ ${#TEMPLATES[@]} -gt 0 ]; then
        log "✗ ERROR: Templates specified but --exec argument missing"
        log "  Use --exec to execute the script"
        log "  Example: ./create_gitignore.sh --exec ${TEMPLATES[0]}"
        log ""
        print_help
    else
        # No templates and no exec mode - show help
        print_help
    fi
fi

# Verify templates were specified
if [ ${#TEMPLATES[@]} -eq 0 ]; then
    log "✗ ERROR: No templates specified"
    log "  Use --list to see available templates"
    log "  Use --help for usage information"
    exit 1
fi

# Verify templates directory exists
if [ ! -d "$TEMPLATES_DIR" ]; then
    log "✗ ERROR: Templates directory not found: $TEMPLATES_DIR"
    log "  Ensure gitignore_templates/ exists in the same directory as this script"
    log "  Run --install to create the directory"
    exit 1
fi

# Process each template
for template in "${TEMPLATES[@]}"; do
    create_gitignore "$template" || exit 1
done

# Print execution summary
print_execution_summary

log "════════════════════════════════════════════════════════════════════════════"
log "✓ Operation completed successfully"
log "════════════════════════════════════════════════════════════════════════════"

exit 0
