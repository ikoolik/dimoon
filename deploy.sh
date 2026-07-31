#!/bin/sh
# Deploy Dimoon to Cloudflare Pages.
#
# There is no build step — the app is a single self-contained index.html plus a favicon that pull
# their libraries from a CDN at runtime. This just assembles a clean dist/ (web assets only, no
# README/LICENSE/.git) and pushes it.
#
# Needs `npx wrangler login` once (opens a browser; the token is stored by wrangler, not here).
#
#   ./deploy.sh            # → dimoon.pages.dev
set -eu

PROJECT=dimoon
DIST=dist

cd "$(dirname "$0")"
rm -rf "$DIST" && mkdir -p "$DIST"
cp index.html favicon.svg _headers "$DIST/"

npx wrangler pages deploy "$DIST" --project-name="$PROJECT" --commit-dirty=true
