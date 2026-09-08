#!/usr/bin/env bash
set -euo pipefail

PORT=8000
LOG_FILE="/tmp/overdrive-web-server.log"

if pgrep -f "python3 -m http.server ${PORT}" >/dev/null 2>&1; then
  echo "Web server already running on port ${PORT}"
else
  nohup python3 -m http.server "${PORT}" --bind 0.0.0.0 >"${LOG_FILE}" 2>&1 &
  sleep 1
  echo "Started web server on port ${PORT} (logs: ${LOG_FILE})"
fi

curl -sf "http://localhost:${PORT}/" >/dev/null
echo "Web server ready at http://localhost:${PORT}/"
