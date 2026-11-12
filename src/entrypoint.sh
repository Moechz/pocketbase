#!/bin/sh
# TOS wrapper: PocketBase serves its admin UI under /_/ and returns 404 on /,
# which fails the TOS application check. Seed a tiny public folder that
# redirects / to the admin UI, then start PocketBase as uid 1000.
set -u
set -e
PUB=/pocketbase/pb_data/public
mkdir -p "$PUB"
if [ ! -s "$PUB/index.html" ]; then
  cat > "$PUB/index.html" <<'HTML'
<!doctype html><meta http-equiv="refresh" content="0; url=/_/">
HTML
fi
exec /pocketbase/pocketbase serve --http=0.0.0.0:8090 --dir /pocketbase/pb_data --publicDir "$PUB"
