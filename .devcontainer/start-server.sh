#!/bin/bash
# Start HTTP server for JSON Editor

cd /workspaces/json-editor

# Wait for python3 to be available (features may still be installing)
for i in {1..30}; do
    if command -v python3 &> /dev/null; then
        break
    fi
    echo "Waiting for python3 to be available... ($i/30)"
    sleep 1
done

if ! command -v python3 &> /dev/null; then
    echo "ERROR: python3 not found after waiting"
    exit 1
fi

# Kill any existing server on port 8000 (stale processes)
pkill -f "python3 -m http.server 8000" 2>/dev/null || true
sleep 1

# Start the server with nohup and disown to survive shell exits
nohup python3 -m http.server 8000 > /tmp/http-server.log 2>&1 &
disown

echo "HTTP server started on port 8000 (PID: $!)"
