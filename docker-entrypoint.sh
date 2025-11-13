#!/bin/sh
set -e

# If MAINT_UNTIL is not provided, use a sensible default
: "${MAINT_UNTIL:=06.07 23:59 МСК}"
export MAINT_UNTIL

# If template exists, substitute environment variables into index.html
if [ -f /usr/share/nginx/html/index.html.template ]; then
  envsubst '${MAINT_UNTIL}' < /usr/share/nginx/html/index.html.template > /usr/share/nginx/html/index.html
fi

# exec the CMD
exec "$@"
