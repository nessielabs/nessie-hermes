# Changelog

## 0.1.18 - 2026-09-01

- Skill: add read-only native coding-agent memory discovery and verification
  guidance.

## 0.1.17 - 2026-08-30

- Skill: make session initiation filters discoverable in the list and search
  reference guidance.

## 0.1.16 - 2026-08-29

- Skill: filter session discovery and resume workflows by human, agent, or
  automation initiation while preserving raw execution metadata.

## 0.1.15 - 2026-08-27

- Setup: label hosted MCP requests as Hermes while retaining the shared Nessie
  endpoint, with a shell-safe quoted setup URL.

## 0.1.13 - 2026-08-25

- Skill: describe meeting reports and transcripts with provider-neutral
  meeting-source language.

## 0.1.12 - 2026-08-25

- Skill: search meeting integrations through the provider-neutral `meeting` category instead of defaulting to Granola.

## 0.1.11 - 2026-08-22

- Skill: detect published skill updates at first Nessie use and point the user at `hermes skills update nessie`; add the `skill-version.json` pointer installed copies poll.

## 0.1.10 - 2026-08-20

- Skill: find named folders and contexts before pagination, and follow
  `nessie_ls` continuation offsets until discovery is complete.

## 0.1.9 - 2026-08-17

- Skill: teach Hermes to answer token-usage questions with the hosted
  `nessie_analytics` tool.

## 0.1.8 - 2026-08-06

- Skill: batch multiple inline edits to one context in a single ordered,
  all-or-nothing `nessie_sed` call.

## 0.1.7 - 2026-08-01

- Skill: distinguish incoming direct and team shares, teach the canonical owner
  scopes and collaborative permissions, and require explicit trace access.

## 0.1.6 - 2026-07-31

- Security: make Nessie read-only by default and require an exact preview plus
  explicit user confirmation before every persistent write.

## 0.1.5 - 2026-07-31

- Skill: prefer structured complete-line context edits for Markdown rows and
  require a canonical readback after every edit.

## 0.1.4 - 2026-07-29

- Skill: update the bundled Nessie guidance.

## 0.1.3 - 2026-07-29

- Skill: update the bundled Nessie guidance.

## 0.1.2 - 2026-07-28

- Skill: update the bundled Nessie guidance.

## 0.1.1 - 2026-07-28

- Skill: recency-first teammate search (enumerate root children, not roots), no prior-seeded topic terms, and per-surface search operator semantics.

## 0.1.0 - 2026-07-28

- Initial release: hosted Nessie MCP setup guide and the nessie agent skill.
