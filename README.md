# WNote - Terminal Note Taking Application 📝

[![PyPI version](https://badge.fury.io/py/wnote.svg)](https://badge.fury.io/py/wnote)
[![Python Version](https://img.shields.io/pypi/pyversions/wnote.svg)](https://pypi.org/project/wnote/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

WNote is a beautiful, feature-rich CLI note-taking application that runs entirely in your terminal. Designed for developers and power users who prefer working in the command line, WNote combines simplicity with powerful features like tags, smart attachments with **symlink support**, reminders, templates, and backups.


## 🏗️ Architecture

### Project Structure

```
wnote/
├── wnote/                      # Main package directory
│   ├── __init__.py            # Package initialization
│   ├── cli.py                 # CLI entry point
│   ├── core/                  # Core functionality
│   │   ├── __init__.py
│   │   ├── config.py          # Configuration management
│   │   └── database.py        # Database operations
│   ├── utils/                 # Utility functions
│   │   ├── __init__.py
│   │   ├── decorators.py      # Decorators (retry logic, etc.)
│   │   ├── formatters.py      # Formatting utilities
│   │   └── file_ops.py        # File operations
│   └── commands/              # Command modules
│       ├── __init__.py
│       ├── note_commands.py   # Note CRUD operations
│       ├── tag_commands.py    # Tag management
│       ├── attachment_commands.py
│       ├── reminder_commands.py
│       ├── export_commands.py
│       ├── config_commands.py
│       └── backup_commands.py
├── setup.py                   # Setup configuration
├── pyproject.toml            # Modern Python packaging config
├── requirements.txt          # Runtime dependencies
├── README.md                 # This file
├── CHANGELOG.md              # Version history
├── LICENSE                   # MIT License
└── MANIFEST.in              # Package inclusion rules
```

### System Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                        CLI Interface (Click)                 │
│                         wnote.cli                            │
└────────────────────┬────────────────────────────────────────┘
                     │
        ┌────────────┼────────────┬─────────────────┐
        │            │            │                 │
┌───────▼──────┐ ┌──▼──────┐ ┌──▼──────┐ ┌────────▼────────┐
│ Note Commands│ │   Tag   │ │Reminder │ │ Backup Commands │
│              │ │Commands │ │Commands │ │                 │
└───────┬──────┘ └──┬──────┘ └──┬──────┘ └────────┬────────┘
        │           │            │                 │
        └───────────┴────────────┴─────────────────┘
                                │
                    ┌───────────▼────────────┐
                    │    Core Modules        │
                    ├────────────────────────┤
                    │  • Database (SQLite)   │
                    │  • Configuration       │
                    │  • File Operations     │
                    └───────────┬────────────┘
                                │
                    ┌───────────▼────────────┐
                    │    Data Layer          │
                    ├────────────────────────┤
                    │  • SQLite Database     │
                    │  • JSON Config         │
                    │  • Attachments Dir     │
                    │  • Backups Dir         │
                    └────────────────────────┘
```

### Database Schema

```
┌─────────────┐     ┌──────────────┐     ┌─────────────┐
│   notes     │     │  note_tags   │     │    tags     │
├─────────────┤     ├──────────────┤     ├─────────────┤
│ id (PK)     │────┐│ note_id (FK) │┌────│ id (PK)     │
│ title       │    ││ tag_id (FK)  ││    │ name        │
│ content     │    │└──────────────┘│    └─────────────┘
│ is_archived │    │                 │
│ created_at  │    │                 │
│ updated_at  │    │                 │
└─────────────┘    │                 │
       │           │                 │
       │           │  ┌──────────────▼────────┐
       │           └──│  attachments          │
       │              ├───────────────────────┤
       │              │ id (PK)               │
       │              │ note_id (FK)          │
       │              │ filename              │
       │              │ original_path         │
       │              │ stored_path           │
       │              │ is_directory          │
       │              │ attachment_mode 🔗    │
       │              │ created_at            │
       │              └───────────────────────┘
       │
       │              ┌─────────────────┐
       └──────────────│   reminders     │
                      ├─────────────────┤
                      │ id (PK)         │
                      │ note_id (FK)    │
                      │ reminder_date   │
                      │ message         │
                      │ is_completed    │
                      └─────────────────┘

🔗 attachment_mode: 'symlink' | 'copy' | 'reference'
```

## 🛠️ Technology Stack

### Core Technologies
- **Python 3.7+**: Programming language
- **Click 8.1+**: Command-line interface creation
- **Rich 13.7+**: Beautiful terminal formatting and UI
- **SQLite**: Embedded database for data storage

### Dependencies
- **Markdown 3.4+**: Markdown processing for exports
- **Colorama 0.4+**: Cross-platform colored terminal text
- **Tabulate 0.9+**: Pretty-print tabular data
- **Requests 2.28+**: HTTP library (future features)

### Development Tools
- **pytest**: Unit testing framework
- **black**: Code formatting
- **isort**: Import sorting
- **mypy**: Static type checking
- **flake8**: Linting

## 📦 Installation

### From PyPI (Recommended)

```bash
pip install wnote
```

### From Source

```bash
git clone https://github.com/imnotnahn/wnote.git
cd wnote
pip install -e .
```

### Development Installation

```bash
git clone https://github.com/imnotnahn/wnote.git
cd wnote
pip install -e ".[dev]"
```

## 🚀 Quick Start

```bash
# Create your first note
wnote add "My First Note" -t "personal,ideas"

# View all notes
wnote show

# Search notes
wnote search "keyword"

# Create a backup
wnote backup

# View statistics
wnote stats
```

## 📖 Usage Guide

### Note Management

```bash
# Create a note with editor
wnote add "Meeting Notes"

# Create a note with inline content
wnote add "Quick Note" -c "Note content here"

# Create a note with tags
wnote add "Project Plan" -t "work,project,planning"

# Create a note with template
wnote add "Weekly Report" --template weekly

# View all notes
wnote show

# View specific note
wnote show 1

# View notes by tag
wnote show -t work

# Show archived notes
wnote show --archived

# Edit note content
wnote edit 1

# Update note title or tags
wnote update 1 -t "New Title"
wnote update 1 --tags "new,tags"

# Archive a note
wnote update 1 --archive
wnote archive 1  # Alternative

# Unarchive a note
wnote update 1 --unarchive
wnote archive --restore-note 1  # Alternative

# Delete note (archives by default)
wnote delete 1

# Permanently delete note
wnote delete 1 --permanent
```

### Tags

```bash
# View all tags
wnote tags

# Set tag color
wnote color work blue
wnote color personal green
wnote color urgent red

# Delete a tag
wnote delete work --tag
```

Available colors: `red`, `green`, `blue`, `yellow`, `magenta`, `cyan`, `white`, `black`, `bright_red`, `bright_green`, `bright_blue`, `bright_yellow`, `bright_magenta`, `bright_cyan`, `bright_white`, `bright_black`


```bash
# Attach with symlink (default, recommended)
wnote attach 1 ~/Documents/report.pdf
wnote attach 1 ~/Documents/report.pdf --mode symlink

# Attach with copy (safe snapshot)
wnote attach 1 ~/config.json --mode copy

# Attach with reference only (no copy/link)
wnote attach 1 /mnt/external/bigdata.csv --mode reference

# Attach directory (works with all modes)
wnote attach 1 ~/Projects/code --mode symlink

# Create note with attachment in one command
wnote add "Report" -f ~/report.pdf -t "work"
wnote add "Backup" -f ~/config.json --attach-mode copy

# List attachments (shows mode icons: 🔗 📄 📌)
wnote deattach 1 --list

# Remove specific attachment (safe: only removes link/copy, not original)
wnote deattach 1 --attachment-id 2

# Remove all attachments
wnote deattach 1 --all

# View note with attachments
wnote show 1 -o  # Auto-open all attachments
```


### Reminders

```bash
# Add reminder with date and time
wnote reminder 1 "2025-12-31 14:30" "Project deadline"

# Add reminder with date only (defaults to 09:00)
wnote reminder 1 "2025-12-31" "Important meeting"

# View all reminders
wnote reminders

# View reminders for specific note
wnote reminders -n 1

# View including completed reminders
wnote reminders -c

# Mark reminder as completed
wnote reminders --complete 1

# Delete reminder
wnote reminders --delete 1
```

### Search & Export

```bash
# Search notes (case-insensitive by default)
wnote search "keyword"

# Case-sensitive search
wnote search "Keyword" --case-sensitive

# Search with tag filter
wnote search "project" --tag work

# Include archived notes in search
wnote search "old" --archived

# Export note to markdown
wnote export 1 --format markdown

# Export note to HTML file
wnote export 1 --format html --output note.html

# Export to plain text
wnote export 1 --format text --output note.txt
```

### Templates

```bash
# Create new template
wnote template create meeting

# Create template with description
wnote template create "project-plan" -d "Template for project planning"

# List all templates
wnote template list

# View template content
wnote template show meeting

# Use template when creating note
wnote add "Weekly Meeting" --template meeting
```

### Backup & Restore

```bash
# Create automatic backup
wnote backup

# Create named backup
wnote backup --name "before-cleanup"

# Create compressed backup
wnote backup --compress

# List all backups
wnote list-backups

# Restore from backup
wnote restore backup_20250315_120000

# Delete a backup
wnote list-backups --delete backup_20250315_120000
```

### Configuration

```bash
# View configuration
wnote config

# Reset to defaults
wnote config --reset

# Manually edit config
nano ~/.config/wnote/config.json
```

### Statistics

```bash
# View comprehensive statistics
wnote stats
```

Shows:
- Total, active, and archived notes
- Tag distribution
- Attachment statistics
- Reminder status
- Recent activity
- Note timeline
- Helpful tips

## ⚙️ Configuration

WNote stores its configuration in `~/.config/wnote/config.json`. You can customize:

```json
{
  "editor": "nano",
  "default_color": "white",
  "file_opener": "xdg-open",
  "auto_backup": true,
  "backup_interval_days": 7,
  "max_backups": 10,
  "search_limit": 100,
  "preview_length": 40,
  "date_format": "%d/%m/%Y %H:%M",
  "tag_colors": {
    "work": "blue",
    "personal": "green",
    "urgent": "red",
    "idea": "yellow"
  }
}
```

### Configuration Paths

- **Database**: `~/.config/wnote/notes.db`
- **Config**: `~/.config/wnote/config.json`
- **Attachments**: `~/.config/wnote/attachments/`
- **Backups**: `~/.config/wnote/backups/`
- **Templates**: `~/.config/wnote/templates/`
- **Archive**: `~/.config/wnote/archive/`

## 🔧 Development

### Setup Development Environment

```bash
# Clone repository
git clone https://github.com/imnotnahn/wnote.git
cd wnote

# Create virtual environment
python -m venv venv
source venv/bin/activate  # Linux/macOS
# or
venv\Scripts\activate  # Windows

# Install in development mode with dev dependencies
pip install -e ".[dev]"
```

### Running Tests

```bash
# Run all tests
pytest

# Run with coverage
pytest --cov=wnote --cov-report=html

# Run specific test file
pytest tests/test_database.py
```

### Code Quality

```bash
# Format code
black wnote/
isort wnote/

# Lint code
flake8 wnote/

# Type checking
mypy wnote/
```

### Building Package

```bash
# Clean previous builds
rm -rf dist/ build/ *.egg-info

# Build distribution packages
python -m build

# Check built packages
ls -lh dist/

# Test installation locally
pip install dist/wnote-0.6.1-py3-none-any.whl

# Or test with editable install
pip install -e .
```

## 🐛 Troubleshooting

### Database Locked Error

If you encounter database locked errors:

```bash
# WNote automatically handles this with retry logic, but you can manually clean up
rm ~/.config/wnote/notes.db-wal
rm ~/.config/wnote/notes.db-shm
```

### Attachments Not Opening

Ensure you have the correct file opener configured:

```bash
# Linux
wnote config  # Check "file_opener": "xdg-open"

# macOS
# Set "file_opener": "open" in config

# Windows
# Set "file_opener": "start" in config
```

### Broken Symlinks

If you see "❌ Missing" for attachments:

```bash
# This means the original file was moved or deleted
# To find broken symlinks:
wnote show <note_id>  # Look for "Missing" status

# Remove broken attachment:
wnote deattach <note_id> --list
wnote deattach <note_id> -a <attachment_id>

# Original file was moved? Re-attach it:
wnote attach <note_id> /new/path/to/file
```

### Permission Denied on Symlink Creation

On some systems, symlink creation requires special permissions:

```bash
# Linux: Usually no issue
# Windows: May need admin rights or Developer Mode enabled
# Solution: Use copy mode instead
wnote attach 1 file.txt --mode copy
```

### Editor Not Working

Set your preferred editor:

```bash
export EDITOR=vim  # Add to ~/.bashrc or ~/.zshrc
# or edit config.json: "editor": "vim"
```

## 📚 Quick Reference

### Most Used Commands

```bash
# Create & View
wnote add "Title" -c "Content" -t "tag1,tag2"  # Create note
wnote show                                      # List all notes
wnote show 1                                    # View note #1
wnote search "keyword"                          # Search notes

# Edit & Update
wnote edit 1                                    # Edit content
wnote update 1 --title "New Title"              # Update title
wnote update 1 --tags "new,tags"                # Update tags
wnote update 1 --archive                        # Archive note

# Attachments (NEW in v0.6.1)
wnote attach 1 file.pdf                         # Symlink (default)
wnote attach 1 file.pdf --mode copy             # Copy file
wnote attach 1 file.pdf --mode reference        # Path only
wnote deattach 1 --list                         # List attachments
wnote deattach 1 -a 2                           # Remove attachment

# Organization
wnote tags                                      # List all tags
wnote color work blue                           # Set tag color
wnote stats                                     # View statistics

# Reminders
wnote reminder 1 "2025-12-31 14:30" "Deadline"  # Add reminder
wnote reminders                                 # View reminders
wnote reminders --complete 1                    # Mark complete

# Backup & Export
wnote backup                                    # Create backup
wnote export 1 --format markdown                # Export to MD
wnote restore backup_20250315_120000            # Restore backup

# Delete
wnote delete 1                                  # Archive (soft delete)
wnote delete 1 --permanent                      # Permanent delete
```

### Keyboard Shortcuts & Tips

```bash
# Use TAB for autocompletion (if supported by your shell)

# Quick note creation
wnote add "Quick note" -c "$(xclip -o)"        # From clipboard

# Pipe content
echo "Note content" | wnote add "Title" -c -

# Editor shortcuts (when editing notes)
# Ctrl+X (nano), :wq (vim), Ctrl+O+Enter (most editors)

# View help for any command
wnote <command> --help
```

### File Locations

```bash
~/.config/wnote/
├── notes.db              # SQLite database
├── config.json           # Configuration
├── attachments/          # Symlinks and copied files
├── backups/              # Database backups
├── templates/            # Note templates
└── archive/              # Archived exports
```


## 🆕 What's New in v0.6.1

### 🔗 Symlink Support (Major Feature)

WNote now supports **three attachment modes** for maximum flexibility:

1. **Symlink (Default)** - Creates symbolic links, saves 99% disk space
2. **Copy** - Old behavior, copies files for safety
3. **Reference** - Only saves path, no storage overhead

```bash
# Symlink mode (new default)
wnote attach 1 large_file.mp4  # <0.1s, saves space

# Copy mode (old behavior)
wnote attach 1 important.pdf --mode copy

# Reference mode (path only)
wnote attach 1 /external/dataset.csv --mode reference
```

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [Click](https://click.palletsprojects.com/) - For the excellent CLI framework
- [Rich](https://rich.readthedocs.io/) - For beautiful terminal formatting
- All contributors and users of WNote

## 🔗 Links

- **GitHub**: https://github.com/imnotnahn/wnote
- **PyPI**: https://pypi.org/project/wnote/
- **Issues**: https://github.com/imnotnahn/wnote/issues
- **Changelog**: [CHANGELOG.md](CHANGELOG.md)

## 📊 Project Stats

![GitHub stars](https://img.shields.io/github/stars/imnotnahn/wnote?style=social)
![GitHub forks](https://img.shields.io/github/forks/imnotnahn/wnote?style=social)
![PyPI downloads](https://img.shields.io/pypi/dm/wnote)
![GitHub last commit](https://img.shields.io/github/last-commit/imnotnahn/wnote)

---

**Made with ❤️ by [imnahn](https://github.com/imnotnahn)**

*If you find WNote useful, please consider giving it a star ⭐ on GitHub!*

```
     _    _   _   _       _       
    | |  | | | \ | |     | |      
    | |  | | |  \| | ___ | |_ ___ 
    | |/\| | | . ` |/ _ \| __/ _ \
    \  /\  / | |\  | (_) | ||  __/
     \/  \/  |_| \_|\___/ \__\___|
                                   
    Terminal Note Taking, Perfected.
```
