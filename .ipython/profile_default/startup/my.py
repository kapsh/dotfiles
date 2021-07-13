# Make these modules always available
import itertools
import logging
import os
import shutil
import datetime
from pathlib import Path

# Specific to this file
import contextlib
from IPython.core.magic import register_line_magic

# Useful to have, but not critical

with contextlib.suppress(ImportError):
    import bitmath

with contextlib.suppress(ImportError):
    import pdir

with contextlib.suppress(ImportError):
    import requests

with contextlib.suppress(ImportError):
    import pendulum

try:
    import pyperclip
except ImportError:
    pyperclip = None

# https://github.com/ipython/ipython/issues/10946
logging.getLogger('parso').setLevel(logging.WARNING)

if pyperclip:

    @register_line_magic
    def copy(line):
        if line:
            pyperclip.copy(eval(line))

    @register_line_magic
    def paste(line):
        return pyperclip.paste()

    del copy
    del paste

del contextlib
del register_line_magic

