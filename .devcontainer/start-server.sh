#!/bin/bash
# Start HTTP server for JSON Editor

cd /workspaces/json-editor
nohup python3 -m http.server 8000 > /tmp/http-server.log 2>&1 &
echo "HTTP server started on port 8000 (PID: $!)"
