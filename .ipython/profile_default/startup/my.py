import contextlib
import itertools
from pathlib import Path

from IPython.core.magic import register_line_magic

with contextlib.suppress(ImportError):
    import bitmath

with contextlib.suppress(ImportError):
    import pdir


@register_line_magic
def copy(line):
    import pyperclip
    pyperclip.copy(eval(line))


@register_line_magic
def paste(line):
    import pyperclip
    return pyperclip.paste()


# Cleanup globals
del contextlib
del register_line_magic
