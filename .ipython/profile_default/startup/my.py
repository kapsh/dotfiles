# Make these modules always available
import itertools
import os
import shutil
from dateime import datetime, timedelta
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

if pyperclip:

    @register_line_magic
    def copy(line):
        if line:
            pyperclip.copy(eval(line))

    @register_line_magic
    def paste(line):
        return pyperclip.paste()


# Cleanup globals
del contextlib
del copy
del paste
del register_line_magic
