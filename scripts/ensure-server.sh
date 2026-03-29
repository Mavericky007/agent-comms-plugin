#!/bin/bash
# Ensure the agent-comms MCP server is running
# Called on every Claude Code session start

SERVER_DIR="$HOME/.claude/agent-comms"
SERVER_URL="http://localhost:4200/api/state"

# Check if server is already running
if curl -s -o /dev/null -w "%{http_code}" --connect-timeout 1 "$SERVER_URL" 2>/dev/null | grep -q "200"; then
  exit 0
fi

# Check if server is installed
if [ ! -f "$SERVER_DIR/dist/server.js" ]; then
  # Try to build
  if [ -f "$SERVER_DIR/package.json" ]; then
    cd "$SERVER_DIR" && npm install --silent 2>/dev/null && npm run build --silent 2>/dev/null
  else
    echo '{"continue": true, "systemMessage": "agent-comms server not installed. Run: cd ~/.claude/agent-comms && npm install && npm run build"}'
    exit 0
  fi
fi

# Start the server
cd "$SERVER_DIR" && node dist/server.js &
echo $! > "$SERVER_DIR/.server.pid"

# Wait for it to come up
for i in 1 2 3 4 5 6 7 8 9 10; do
  sleep 1
  if curl -s -o /dev/null -w "%{http_code}" --connect-timeout 1 "$SERVER_URL" 2>/dev/null | grep -q "200"; then
    exit 0
  fi
done

echo '{"continue": true, "systemMessage": "agent-comms server failed to start. Check ~/.claude/agent-comms/ for issues."}'
exit 0
