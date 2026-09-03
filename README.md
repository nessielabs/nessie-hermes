# Nessie Hermes

Nessie Hermes connects a [Hermes](https://hermes-agent.nousresearch.com)
agent to a user's Nessie context library.

It uses the two extension surfaces Hermes recommends:

1. The hosted Nessie MCP server, registered through Hermes' native MCP
   support (`hermes mcp add`). Hermes discovers the Nessie tools directly
   from `https://mcp.nessielabs.com/mcp?client=hermes`.
2. A `nessie` skill in the open agent-skills format (agentskills.io), which
   teaches the agent when and how to use those tools well: search strategy,
   source authority, team scoping, takeover workflows, and write-back rules.

The Nessie app is used to create the agent API key and enable Cloud Sync, but
it does not need to stay running after setup. The skill mirrors the Nessie
OpenClaw skill, which in turn mirrors the Claude Code and Codex skills, so
agent behavior stays consistent across surfaces.

## Setup

The companion Nessie website guide is tracked in
[nessielabs/nessie-codebase#1297](https://github.com/nessielabs/nessie-codebase/pull/1297)
and will be linked here after it deploys.

### 1. Create a Nessie API key

In the Nessie Mac app: Settings, then API Keys. Create an agent key
(`sk_nes_v1_...`). Copy it now; it is shown once.

### 2. Register the hosted MCP server

```bash
hermes mcp add nessie --url "https://mcp.nessielabs.com/mcp?client=hermes" --auth header
```

The `client=hermes` marker uses the same hosted MCP route as every other
Nessie connector. It only provides a bounded client-surface label for usage
telemetry.

When Hermes displays the hidden `API key / Bearer token` prompt, enter only
the raw key:

```
sk_nes_v1_...
```

Do not paste the key into a Hermes conversation, and do not enter a complete
`Authorization: Bearer ...` header. Hermes stores the secret in
`~/.hermes/.env` as `MCP_NESSIE_API_KEY`; the server entry in
`~/.hermes/config.yaml` references that environment variable.

When Hermes asks which tools to enable, choose `select` and start with the
modern read-only surface:

- `nessie_check_in`
- `nessie_analytics`
- `nessie_skill_analytics_overview`
- `nessie_skill_analytics`
- `nessie_who_am_i`
- `nessie_team_list`
- `nessie_integration_list`
- `nessie_ls`
- `nessie_grep`
- `nessie_cat`
- `nessie_head`
- `nessie_tail`
- `nessie_stat`
- `nessie_asset_get`

Run `hermes mcp configure nessie` later if you want to opt into specific
context/profile write or deletion tools. Verify the connection:

```bash
hermes mcp test nessie
```

### 3. Install the skill

Install the skill directly from its public GitHub repository:

```bash
hermes skills install nessielabs/nessie-hermes/skills/nessie
```

The public repository path above uses the Skills Hub. For local development,
point Hermes at the working copy instead by adding the repository's `skills`
directory to `~/.hermes/config.yaml`:

```yaml
skills:
  external_dirs:
    - /absolute/path/to/nessie-hermes/skills
```

Then verify that Hermes sees the skill:

```bash
hermes skills list
```

Skills live in `~/.hermes/skills/`. Use `hermes skills config` to
enable or disable the skill per platform (CLI, Telegram, and other
gateways). Start a new Hermes session after setup so both the MCP tools and
skill are loaded.

## Updates

The hosted MCP tools update automatically when Nessie deploys. The local skill
is versioned separately. Check for and install its updates with:

```bash
hermes skills check nessie
hermes skills update nessie
```

## Usage

Ask Hermes things like:

- "Nessie check-in"
- "What do I know about this topic?"
- "What did I decide about this project?"
- "How many tokens did my coding agents use this month?"
- "What has my team been working on this week?"
- "Search my notes about this project."

The skill covers first-person and team scoping, literal search for names and
identifiers, transcript takeover ("resume this Claude session"), read-only
Claude Code and Codex native memory for project orientation, and saving durable
knowledge back to Nessie.

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
