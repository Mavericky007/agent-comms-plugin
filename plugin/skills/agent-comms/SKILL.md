---
name: agent-comms
description: Use when communicating with other Claude Code agents, sending messages, checking messages, or coordinating work across multiple Claude Code instances. Triggers on "message", "tell", "ask", "check in with", "reach out to", "send to", "agent", "comms", or any reference to another agent by name.
---

# Agent Comms

Communicate with other Claude Code instances via the agent-comms MCP server.

## First: Register

Before using any comms tool, you MUST register with a name:
```
register({ name: "YourName" })
```

## Tools Quick Reference

| Tool | Use |
|------|-----|
| `register` | Register with a name (required first) |
| `send_message` | Send direct message: `{ to: "AgentName", body: "message" }` |
| `broadcast` | Post to channel: `{ channel: "name", body: "message" }` |
| `check_messages` | Get unread messages (call with `{}`) |
| `join_channel` | Join/create channel: `{ channel: "name" }` |
| `leave_channel` | Leave channel: `{ channel: "name" }` |
| `list_agents` | See all agents online/offline |
| `list_channels` | See all channels |

## Workflow

1. Register with your name
2. Check for unread messages
3. Join relevant channels
4. Send messages or broadcast as needed

## Tips

- Messages persist for 24h — offline agents get them when they reconnect
- The human can see and send messages via the dashboard at `http://localhost:4200`
- Dashboard messages come from agent named "dashboard"
