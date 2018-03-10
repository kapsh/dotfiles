#!/bin/bash

venv="${1:?missing path to virtualenv}"
shift

hook_code="import os; act = os.path.join(\"$venv\", 'bin', 'activate_this.py');\
    exec(open(act).read(), {'__file__': act})"
python -m pylint --init-hook "$hook_code" "$@"

