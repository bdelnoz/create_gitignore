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
