# Nessie Hermes

Nessie Hermes connects a [Hermes](https://hermes-agent.nousresearch.com)
agent to a user's Nessie context library.

It uses the two extension surfaces Hermes recommends:

1. The hosted Nessie MCP server, registered through Hermes' native MCP
   support (`hermes mcp add`). Hermes discovers the Nessie tools directly
   from `https://mcp.nessielabs.com/mcp`.
2. A `nessie` skill in the open agent-skills format (agentskills.io), which
   teaches the agent when and how to use those tools well: search strategy,
   source authority, team scoping, takeover workflows, and write-back rules.

No local Nessie app is required. The skill mirrors the Nessie OpenClaw skill,
which in turn mirrors the Claude Code and Codex skills, so agent behavior
stays consistent across surfaces.

## Setup

### 1. Create a Nessie API key

In the Nessie Mac app: Settings, then API Keys. Create an agent key
(`sk_nes_v1_...`). Copy it now; it is shown once.

### 2. Register the hosted MCP server

```bash
hermes mcp add nessie --url https://mcp.nessielabs.com/mcp --auth header
```

When prompted for the auth header, provide:

```
Authorization: Bearer sk_nes_v1_...
```

The connection is stored in `~/.hermes/config.yaml` under `mcp_servers`.
Verify it:

```bash
hermes mcp test nessie
```

### 3. Install the skill

From this repository (`hermes skills install` takes a direct SKILL.md URL):

```bash
hermes skills install https://raw.githubusercontent.com/nessielabs/nessie-hermes/main/skills/nessie/SKILL.md
```

For local development:

```bash
hermes skills install ./skills/nessie/SKILL.md
hermes skills list
```

Skills live in `~/.hermes/skills/`. Use `hermes skills config` to
enable or disable the skill per platform (CLI, Telegram, and other
gateways).

## Usage

Ask Hermes things like:

- "Nessie check-in"
- "What do I know about this topic?"
- "What did I decide about this project?"
- "What has my team been working on this week?"
- "Search my notes about this project."

The skill covers first-person and team scoping, literal search for names and
identifiers, transcript takeover ("resume this Claude session"), and saving
durable knowledge back to Nessie.

## Bonus: sync your Hermes conversations into Nessie

The reverse direction also works: Nessie can ingest this Hermes agent's own
conversations (CLI and Telegram) so they become searchable context. Run the
Nessie daemon next to Hermes:

```bash
npm install -g @nessielabs/daemon
nessie-daemon setup --api-key sk_nes_v1_...
nessie-daemon start
```

Conversations sync to your Nessie library automatically.
