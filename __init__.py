"""
WNote - Terminal Note Taking Application

This file is kept for backward compatibility.
The actual package is now in the 'wnote' subdirectory.
"""

# Import from the actual package
try:
    from wnote.cli import cli
    from wnote import __version__
except ImportError:
    # Fallback for development/transition period
    __version__ = "0.6.1"
    cli = None

__all__ = ["cli", "__version__"]
