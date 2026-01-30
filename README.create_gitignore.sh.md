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
