# Contributing

Thanks for improving `@nessielabs/nessie-hermes`. This package is mostly
documentation (the Nessie skill), but every change ships as a versioned
release, so a few release mechanics apply. Most of them are automated.

## Setup

Run `npm install` once after cloning. Its `prepare` script points
`core.hooksPath` at `scripts/hooks`, which installs the pre-commit hook below.

## Versioning is automatic

This project follows [Semantic Versioning](https://semver.org/spec/v2.0.0.html).
When you stage a change to shipped skill content (`skills/`), the pre-commit
hook auto-bumps the **patch** version and keeps three locations in lockstep:

1. `package.json` - `"version"`
2. `skills/nessie/SKILL.md` - the `version:` frontmatter field
3. `skill-version.json` - `"version"` (the remote pointer installed skill
   copies poll for updates)

You do not bump these by hand for a normal change.

**Minor or major bumps:** stage a hand-edited `package.json` version in your
commit. The hook sees `package.json` already staged and leaves your value
alone - including the other two files, so set the SKILL.md frontmatter and
`skill-version.json` yourself to match. If the three versions diverge, either
every session prompts a no-op update (pointer ahead) or installed copies never
notice the release (pointer behind).

## The CHANGELOG is auto-stubbed

The hook drops a dated CHANGELOG entry for the new version with a default
bullet. Refine it to a user-facing line before pushing.
