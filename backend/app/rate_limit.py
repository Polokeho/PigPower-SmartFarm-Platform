from slowapi import Limiter
from slowapi.util import get_remote_address

# FR-SEC-005 — shared limiter instance. Lives in its own module (not
# app/main.py) specifically so route files can import it without a
# circular import (main.py -> router -> auth route -> main.py would
# otherwise be a cycle).
limiter = Limiter(key_func=get_remote_address)
