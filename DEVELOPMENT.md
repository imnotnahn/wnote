# Development Guide

## Quick Start

1. Clone and setup:
```bash
git clone <repository-url>
cd wnote
python -m venv venv
source venv/bin/activate  # Linux/macOS
pip install -e ".[dev]"
```

2. Run tests:
```bash
pytest  # When tests are available
```

3. Build package:
```bash
python -m build
```

## Version Management

Update version in these files:
- `__init__.py`
- `pyproject.toml` 
- `setup.py`
- `CHANGELOG.md`

## Release Process

1. Update version numbers
2. Update CHANGELOG.md
3. Build package: `python -m build`
4. Test installation: `pip install dist/wnote-X.X.X-py3-none-any.whl`
5. Upload to PyPI: `twine upload dist/*`

## Key Files

- `wnote.py` - Main application code
- `__init__.py` - Package initialization and version
- `pyproject.toml` - Modern Python packaging config
- `setup.py` - Legacy packaging config (for compatibility)
- `requirements.txt` - Runtime dependencies
- `MANIFEST.in` - Package inclusion rules

## Recent Fixes (v0.5.2)

- Fixed attachment inheritance bug when reusing note IDs
- Fixed timezone issues (now uses local system time)
- Enabled SQLite foreign key constraints
- Improved attachment cleanup on note deletion 